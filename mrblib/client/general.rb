module LSP
  class  Client
    def initialized(resp = nil)
      if resp != nil and resp['result'] != nil
        @server_capabilities.merge! resp['result']['capabilities']
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