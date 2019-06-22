module LSP
  class  Client
    def initialized(resp = nil)
      if resp != nil
        @server_capabilities = resp['result']['capabilities']
        $stderr.puts @server_capabilities
      end
      send_notification("initialized")
      @status = :running
    end

    def shutdown
      send_request("shutdown")
      @status = :stop
    end
  end
end