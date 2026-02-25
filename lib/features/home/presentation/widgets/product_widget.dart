import 'package:flutter/cupertino.dart';
import 'package:store_app/features/home/data/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.productitem});
  final ProductModel productitem;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(96, 148, 207, 227),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          ClipRRect(child: Image.network(productitem.image,
              height: 180,
              width: double.infinity, 
              fit: BoxFit.cover, // عشان الصورة تملأ المساحة ومتمطش


          ),
          
          ),
          SizedBox(height: 15,),
          Text(productitem.name, style: TextStyle(fontSize: 14),maxLines: 2,),
          Text(productitem.desc ?? "", style: TextStyle(fontSize: 15),maxLines: 2,),
          Text("\$${productitem.price}",style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }
}
