class ProductModel {
  final String id;
  final String name;
  final String? desc;
  final String image;
  final num price;

  ProductModel(  {
    required this.id,
    required this.name,
    this.desc,
    required this.image,
   required this.price,
  });

factory ProductModel.fromJson(Map<String,dynamic>json){
  return ProductModel(
   id: json['id'].toString(),
   desc: json['description'],
   name: json['title'], 
   image: json['thumbnail'],
    price: json['price'],
   );

}

}
