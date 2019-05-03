module LSP
  class  Client
    def initialized
      send_notification("initialized")
    end

    def shutdown
      send_request("shutdown")
    end
  end
end