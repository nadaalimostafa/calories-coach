class User{
  static const String collectionName = "User";
  String? fullName;
  String? email;
  String? id ;


  User({
    this.fullName,
    this.email,
    this.id,

  });

  Map<String , dynamic> toFireStore(){
    return {
      "id":id,
      "fullName":fullName,
      "email":email,

    };
  }

  User.fromFireStore(Map<String,dynamic>? data){
    id = data?["id"];
    email = data?["email"];
    fullName = data?["fullName"];
  }}