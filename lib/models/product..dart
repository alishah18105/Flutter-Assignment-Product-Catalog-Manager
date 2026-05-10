class Products{
    String? id;
    String? name;
    int? price;

    Products({this.id, this.name, this.price});

    factory Products.fromJson(Map<String,dynamic> json){
      return Products(
        id: json["_id"],
        name: json["name"],
        price: json["price"]
      );
    }

}