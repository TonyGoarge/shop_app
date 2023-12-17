class HomeModel
{
   bool? status;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String,dynamic>json)
  {
status=json['status'];
data=HomeDataModel.formjson(json['data']) ;
}
}

class HomeDataModel
{
  List<BannerModel>banners=[];
  List<productsModel>products=[];
HomeDataModel.formjson(Map<String,dynamic>json)
{
json['banners'].forEach((element)
  {
    banners.add(BannerModel.fromjson(element));
  });



json['products'].forEach((element)
{
  products.add(productsModel.fromjson(element));
});


}
}




class BannerModel
{
  int? id;
  dynamic image;
  dynamic category;
  dynamic product;
  BannerModel.fromjson(Map<String,dynamic>json)
  {
  id=json['id'];
  image=json['image'];
  category=json['category'];
  product=json['product'];
  }
}


class productsModel
{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  late String name;
  bool? inFavorites;
  bool? in_cart;
  productsModel.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}







// List<BannerModel>?banners;
// List<productsModel>?products;
// HomeDataModel.fromJson(Map<String,dynamic>json)
// {
//   if (json['banners']!=null)
//     {
//       banners=<BannerModel>[];
//       json['banners'].forEach((element){
//         banners!.add(BannerModel.fromjson(element));
//       });
//     }
//
//   if (json['products']!=null)
//     {
//       products=<productsModel>[];
//       json['products'].forEach((element){
//         products!.add(productsModel.fromjson(element));
//       });
//     }
