class SignUpWithEmailAndPasswordFailure {
  final String errorMessage;

  const SignUpWithEmailAndPasswordFailure(
      [this.errorMessage = "An Error Occurred"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {

      case "email-already-in-use":
        return const SignUpWithEmailAndPasswordFailure(
            "An account already exist for the email you provided");

      case "invalid-email":
        return const SignUpWithEmailAndPasswordFailure(
            "The email provided is not valid or badly formatted");

      case "operation-not-allowed":
        return const SignUpWithEmailAndPasswordFailure("Operation not allowed");

      case "weak-password":
        return const SignUpWithEmailAndPasswordFailure("Please enter a stronger password");

      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }


}
