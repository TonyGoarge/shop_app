class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool ? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.image,
    this.cover,
    this.isEmailVerified,
});
  SocialUserModel.fromjson(Map<String,dynamic>json)     //اما اجي استقبل يبقي fromjson
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    bio=json['bio'];
    image=json['image'];
    cover=json['cover'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap()    //اما احوله ل map يبقي tomap
  {
    return{
    'name':name,
    'email':email,
    'phone':phone,
    'uId':uId,
    'image':image,
    'cover':cover,
    'bio':bio,
    'isEmailVerified':isEmailVerified,
    };
  }

}