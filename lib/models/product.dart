class Products{
    String? id;
    String? name;
    double? price;

    Products({this.id, this.name, this.price});

    factory Products.fromJson(Map<String,dynamic> json){
      return Products(
        id: json["id"] as String?,
        name: json["name"] as String,
        price: (json["price"] as num).toDouble(),
      );
    }

    Map<String, dynamic> toJson() =>{
      "name" : name,
      "price" : price
    };

}