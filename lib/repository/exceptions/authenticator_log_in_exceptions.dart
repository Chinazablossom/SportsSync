class LogInFailure {
  final String errorMessage;

  const LogInFailure(
      [this.errorMessage = "An Error Occurred"]);


  factory LogInFailure.code(String code) {
    switch (code) {

      case "invalid-email":
        return const LogInFailure(
            "The email provided is not valid or badly formatted");

      case "user-disabled":
        return const LogInFailure(
            "The account you're attempting to login to has been disabled");

      case "user-not-found":
        return const LogInFailure("there is no user corresponding to the given email");

      case "wrong-password":
        return const LogInFailure("The password you entered is invalid");

      default:
        return const LogInFailure();
    }
  }


}
