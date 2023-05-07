/// SocketException - For no Internet
/// Unauthorised exception - For invalid credentials
/// ServerError - For error on server side

class ApiException implements Exception {
  final String? message;

  ApiException(this.message);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException() : super("Invalid Credentials");
}

class ServerError extends ApiException {
  ServerError() : super("Server Error");
}
