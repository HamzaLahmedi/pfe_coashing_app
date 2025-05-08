class APIResponse {
  var data;
  bool isError;
  String? errorMessage;
  int? status;
  APIResponse({
    this.data,
    required this.isError,
    this.errorMessage,
    required this.status,
  });
  @override
  String toString() {
    return 'APIResponse(isError: $isError, data: $data, errorMessage: $errorMessage, status: $status )';
  }
}
