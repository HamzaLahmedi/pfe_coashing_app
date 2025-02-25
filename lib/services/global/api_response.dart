class APIResponse {
  var data;
  bool isError;
  String? errorMessage;
  int? status;
  APIResponse({this.data, required this.isError, this.errorMessage, required this.status});
}