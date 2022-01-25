class ProductModel {
  //field
  var name, price, pathimage, detail;

  //Method
  ProductModel(this.name, this.price, this.pathimage, this.detail);

  ProductModel.fromMap(Map<String, dynamic> map) {
    name = map['Name'];
    price = map['Price'];
    pathimage = map['image'];
    detail = map['Detail'];
  }
}
