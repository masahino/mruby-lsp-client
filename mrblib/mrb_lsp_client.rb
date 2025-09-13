module LSP
  # LSP::Client
  class Client
    JSON_RPC_VERSION = '2.0'.freeze

    attr_accessor :recv_buffer, :request_buffer, :status, :io, :file_version, :logfile, :server, :server_capabilities

    def initialize(command, options = {})
      args = options['args']
      args = [] if args.nil?
      @server = { command: command, args: args }
      @recv_buffer = []
      @request_buffer = {}
      @server_status = nil
      @server_capabilities = {} # init_server_capabilities
      @io = nil
      @id = 0
      @status = :stop
      @file_version = {}
      @initialization_options = options['initializationOptions']
      @logfile = options['logfile']
      return unless @logfile.nil?

      tmpdir = ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || ENV['USERPROFILE'] || '/tmp'
      @logfile = "#{tmpdir}/mruby_lsp_#{File.basename(command)}_#{$$}.log"
    end

    def make_id
      @id += 1
    end

    def read_message(io, length)
      data = ''
      chunk_size = 4096
      bytes_read = 0
      # buffer = ' ' * chunk_size
      while bytes_read < length
        remaining_length = length - bytes_read
        bytes_to_read = [remaining_length, chunk_size].min
        chunk = io.sysread(bytes_to_read)
        raise EOFError, "End of file reached before reading #{length} bytes" if chunk.nil?

        bytes_read += chunk.bytesize
        data += chunk
      end
      data
    end

    def recv_message
      headers = {}
      message = nil
      data = ''
      loop do
        char = @io.sysread(1)
        raise EOFError, 'end of file reached' if char.nil?

        data << char
        break if data.end_with?("\r\n\r\n")
      end
      # Content-Length: ...\r\n
      # Content-type: ...\r\n
      # \r\n
      data.each_line do |line|
        k, v = line.chomp.split(':')
        case k
        when 'Content-Length'
          headers[k] = v.to_i
        when 'Content-Type'
          headers[k] = v
        end
      end
      # message = @io.sysread(headers['Content-Length']) unless headers['Content-Length'].nil?
      unless headers['Content-Length'].nil?
        message = read_message(@io, headers['Content-Length'])
        $stderr.puts message if $DEBUG
        message = JSON.parse(message)
      end
      [headers, message]
    end

    def wait_response(id = nil)
      message = nil
      loop do
        headers, message = recv_message
        break if headers == {} || message.nil?

        if id == message['id'].to_i
          @request_buffer.delete(id)
          break
        else
          @recv_buffer.push(message)
        end
      end
      message
    end

    def send_message(message)
      json_message = message.to_json
      header = "Content-Length: #{json_message.bytesize}\r\n\r\n"
      $stderr.puts json_message if $DEBUG
      begin
        @io.print header
        @io.print json_message
        true
      rescue Errno::ESPIPE => e
        $stderr.puts e
        false
      end
    end

    def create_request_message(method, params)
      id = make_id
      {
        'jsonrpc' => JSON_RPC_VERSION,
        'method' => method,
        'params' => params,
        'id' => id
      }
    end

    def send_request(method, params = {}, &block)
      message = create_request_message(method, params)
      id = message['id']
      ret = send_message(message)
      if ret == false
        nil
      elsif block_given?
        resp = wait_response(id)
        block.call(resp)
        id
      else
        @request_buffer[message['id']] = {
          message: message,
          block: block
        }
        id
      end
    end

    def send_notification(method, params = {})
      message = {
        'jsonrpc' => JSON_RPC_VERSION,
        'method' => method,
        'params' => params
      }
      send_message(message)
    end

    def start_server(params, &block)
      return unless @io.nil?

      command_str = @server[:command] + " " + @server[:args].join(' ')
      log = File.open(@logfile, 'w')
      begin
        @io = IO.popen(command_str, 'rb+', err: log.fileno)
      rescue
        $stderr.puts 'error'
        @status = :not_found
        return
      end
      @status = :initializing
      params['initializationOptions'] = @initialization_options
      send_request('initialize', params, &block)
    end

    def stop_server
      if @status == :running
        send_notification('exit')
      end
      Process.kill(15, @io.pid)
    end

    def cancel_request_with_method(method)
      @request_buffer.each_pair do |id, v|
        if v[:message]['method'] == method
          send_notification('$/cancelParams', { 'id' => id })
          @request_buffer.delete(id)
        end
      end
    end
  end
end
