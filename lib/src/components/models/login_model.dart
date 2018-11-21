//login class
class LoginBody {
  //login objects
  static String email, password;

  //login constructor
  LoginBody({email, password});

  //function to convert from json to object 
  factory LoginBody.fromJson(Map <String, dynamic> parsedJson) {
    return LoginBody(
      email: parsedJson['email'],
      password: parsedJson['password']
    );
  }

  //toString method
  String toString() {
    return 'Email: $email, Password: $password';
  }
}

class ResponseBody {
  String username, email, password, accessToken;

  ResponseBody({this.username, this.email, this.password, this.accessToken});
}
