module LSP
  class ErrorCodes
    extend Type
    CONST = {
      ParseError: -32700,
      InvalidRequest: -32600,
      MethodNotFound: -32601,
      InvalidParams: -32602,
      InternalError: -32603,

      # @since 3.16.0
      jsonrpcReservedErrorRangeStart: -32099,

      ServerNotInitialized: -32002,
      UnknownErrorCode: -32001,

      #  @since 3.16.0
      jsonrpcReservedErrorRangeEnd: -32000,

      # @since 3.16.0
      lspReservedErrorRangeStart: -32899,

      #  @since 3.17.0
      RequestFailed: -32803,

      # @since 3.17.0
      ServerCancelled: -32802,

      ContentModified: -32801,

      RequestCancelled: -32800,

      #  @since 3.16.0
      lspReservedErrorRangeEnd: -32800
    }.freeze
  end
end
