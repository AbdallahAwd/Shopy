class PriceModel
{
  String product;
  String image ;
  String dateTime;
  String price ;
  PriceModel({
    this.image,
    this.dateTime,
    this.product,
    this.price
    });
  PriceModel.fromJson(Map<String , dynamic> json)
  {
    product = json['product'];
    image = json['image'];
    dateTime = json['dateTime'];
    price = json['price'];
  }
  Map<String , dynamic> toMap()
  {
    return
      {
      'product':product,
      'image':image,
      'dateTime':dateTime,
      'price':price,
      };
  }
}