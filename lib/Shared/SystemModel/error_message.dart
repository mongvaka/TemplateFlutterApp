class ErrorMessage {
  final String code;
  final String errorMessage;
  final String errorParameter;
  final String rowParameter;
  final String message;
  final String source;
  final String stackTrace;
  final String messageList;

  ErrorMessage(
      {this.code,
      this.errorMessage,
      this.errorParameter,
      this.rowParameter,
      this.message,
      this.source,
      this.stackTrace,
      this.messageList});
  factory ErrorMessage.fromJson(Map<dynamic, dynamic> json) {
    return ErrorMessage(
      code: json['code'],
      errorMessage: json['errorMessage'],
      errorParameter: json['errorParameter'],
      rowParameter: json['rowParameter'],
      message: json['message'],
      source: json['source'],
      stackTrace: json['stackTrace'],
      messageList: json['messageList'],
    );
  }
}
