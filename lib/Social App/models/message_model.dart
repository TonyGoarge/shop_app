class MessageModel
{
  String? senderId;
  String? receiverId;
  String? datetime;
  String? text;


  MessageModel({
    this.senderId,
    this.receiverId,
    this.datetime,
    this.text,
  });
  MessageModel.fromjson(Map<String,dynamic>json)     //اما اجي استقبل يبقي fromjson
  {
    senderId=json['senderId'];
    receiverId=json['receiverId'];
    datetime=json['datetime'];
    text=json['text'];

  }
  Map<String,dynamic> toMap()    //اما احوله ل map يبقي tomap
  {
    return{
      'senderId':senderId,
      'receiverId':receiverId,
      'datetime':datetime,
      'text':text,

    };
  }

}