module LSP
  class  Client
    JSON_RPC_VERSION = '2.0'

    attr_accessor :recv_buffer
    def initialize(command, args = [])
      @server = {:command => command, :args => args}
      @recv_buffer = []
      @request_buffer = {}
      @server_status = nil
      @io = nil
    end

    def make_id
      rand(10**12)
    end

    def recv_message()
      headers = {}
      while line = @io.gets
        if line == "\r\n"
          break
        end
        k, v = line.chomp.split(":")
        if k == "Content-Length"
          headers[k] = v.to_i
        end
      end
      message = ""
      if headers["Content-Length"] != nil
        message = JSON.parse(@io.read(headers["Content-Length"]))
      end
      return headers, message
    end

    def send_message(message)
      json_message = message.to_json
      header = "Content-Length: " + json_message.length.to_s + "\r\n\r\n"
      @io.print header
      @io.print json_message
    end

    def create_request_message(method, params)
      id = make_id
      {
        'jsonrpc' => JSON_RPC_VERSION,
        'method' => method,
        'params' => params,
        'id' => id,
      }
    end

    def send_request(method, params = {}, &block)
      message = create_request_message(method, params)
      id = message['id']
      send_message(message)
      resp = nil
      loop do
        resp = recv_message[1]
        break  if id == resp['id'].to_i
        @recv_buffer.push(resp)
      end
      if block != nil
        block.call(resp)
      else
        resp
      end
    end

    def send_request_async(method, params)
      message = create_request_message(method, params)
      @request_buffer[message['id']] = message
      send_message(message)
    end

    def send_notification(method, params = {})
      message = {
        'jsonrpc' => JSON_RPC_VERSION,
        'method' => method,
        'params' => params,
      }
      send_message(message)
    end
  
    def start_server(params)
      if @io == nil
        command_str = @server[:command] + " " + @server[:args].join(' ')
        @io = IO.popen(command_str, "rb+")
        send_request('initialize', params)
      end
    end

    def stop_server
      send_notification("exit")
      Process.kill(15, @io.pid)
    end
  end
end