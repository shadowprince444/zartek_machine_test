enum SignInStatus { none, google, phone, signedIn, firstSignIn }
enum ConnectionStatusEnum {
  internetConnectionAvailable,
  internetConnectionNotAvailable,
  loading,
}
enum DeviceScreenType {
  mobile,
  tablet,
  desktop,
}
enum ApiResponseStatus {
  idle,
  loading,
  completed,
  notFound,
  unProcessable,
  error,
}

enum APIMethod {
  post,
  get,
  put,
  delete,
  patch,
}
enum InitialScreenStatus { firstLogIn, authenticated, unauthenticated }

enum PhoneAuthState {
  started,
  codeSent,
  codeResent,
  verified,
  failed,
  error,
  autoRetrievalTimeOut,
}
