class ProductModel {
  //field
  var name, price, pathimage, detail, id, type, exp;

  //Method
  ProductModel(
      this.name, this.price, this.pathimage, this.detail, this.id, this.type, this.exp);

  ProductModel.fromMap(Map<String, dynamic> map) {
    name = map['Name'];
    price = map['Price'];
    pathimage = map['image'];
    detail = map['Detail'];
    exp = map['EXP'];
    id = map['id'];
    type = map['Type'];
  }
}
