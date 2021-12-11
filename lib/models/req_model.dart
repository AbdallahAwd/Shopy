class ReqModel
{
  String product;
  String quantity;
  bool checkedValues = false;

  ReqModel({
    this.product,
    this.quantity,
    this.checkedValues
  });

  ReqModel.fromJson(Map<String , dynamic> element)
  {
    product = element['product'];
    quantity = element['quantity'];
    checkedValues = element['checkedValues'];
  }

 Map <String , dynamic> toMap()
  {
    return
        {
          'product' : product,
          'quantity' : quantity,
          'checkedValues' : checkedValues,
        };
  }
}