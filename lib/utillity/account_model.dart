class AccountModel {
  //field
  dynamic ID, address, avatar, id, password, name, phone, gender;

  //Method
  AccountModel(this.name, this.ID, this.address, this.avatar, this.id,
      this.password, this.gender, this.phone);

  AccountModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    ID = map['ID'];
    address = map['address'];
    password = map['password'];
    id = map['id'];
    avatar = map['image'];
    phone = map['phone'];
    gender = map['gender'];
  }
}
