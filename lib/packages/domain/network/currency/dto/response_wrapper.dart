class ResponseWrapper {
  ResponseWrapper({
    required this.data,
  });

  dynamic data;

  ResponseWrapper.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }
}
