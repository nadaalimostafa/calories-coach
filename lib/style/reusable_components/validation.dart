class Validation {
  static String? fullNameValidator (String? value, String message){
    if (value==null || value.isEmpty){
      return message;
    
    }
    return null;
  }
  static String? emailValidator(String? value){
    String? email = fullNameValidator(value, "Should Enter your Email");
    if (email ==null ){
      if(!isValidEmail(value!)){
         email = "email is not valid";
      }
    }
    return email; 

    
  
  }
  static bool isValidEmail(String email){
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
      return emailValid;
  }
}