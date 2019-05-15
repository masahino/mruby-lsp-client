module LSP
  class  Client
    def initialized
      send_notification("initialized")
      @status = :running
    end

    def shutdown
      send_request("shutdown")
      @status = :stop
    end
  end
end