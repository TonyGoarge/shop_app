class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? datetime;
  String? text;
  String? postimage;


  PostModel({
    this.name,
    this.uId,
    this.image,
    this.datetime,
    this.text,
    this.postimage,
  });
  PostModel.fromjson(Map<String,dynamic>json)     //اما اجي استقبل يبقي fromjson
  {
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    datetime=json['datetime'];
    text=json['text'];
    postimage=json['postimage'];
  }
  Map<String,dynamic> toMap()    //اما احوله ل map يبقي tomap
  {
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'datetime':datetime,
      'text':text,
      'postimage':postimage,
    };
  }

}