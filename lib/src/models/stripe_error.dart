class StripeError {
  final String? code;
  final String? docUrl;
  final String? message;
  final String? param;
  final String? requestLogUrl;
  final String? type;

  StripeError({
    this.code,
    this.docUrl,
    this.message,
    this.param,
    this.requestLogUrl,
    this.type,
  });

  factory StripeError.fromMap(Map<String, dynamic> map) {
    return StripeError(
      code: map['code'],
      docUrl: map['doc_url'],
      message: map['message'],
      param: map['param'],
      requestLogUrl: map['request_log_url'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'doc_url': docUrl,
      'message': message,
      'param': param,
      'request_log_url': requestLogUrl,
      'type': type,
    };
  }
}
