class ChargeModel
{
  String dateTime;
  String name;
  String description;
  double price;
  double priceSum;

  ChargeModel({
    this.dateTime,
    this.price,
    this.name,
    this.description
    });



  ChargeModel.fromJson(Map<String , dynamic> element)
  {
    dateTime = element['dateTime'];
    name = element['name'];
    description = element['description'];
    price = element['price'];
  }

  Map <String , dynamic> toMap()
  {
    return
        {
          'dateTime': dateTime,
          'name': name,
          'description': description,
          'price': price,
        };
  }
}