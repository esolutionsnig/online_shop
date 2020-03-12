import 'package:flutter/material.dart';
import 'package:online_shop/src/model/data.dart';
import 'package:online_shop/src/model/product.dart';
import 'package:online_shop/src/themes/light_color.dart';
import 'package:online_shop/src/widgets/title_text.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Product model;
  @override
  void initState() {
    model = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail');
        setState(() {
          model.isSelected = !model.isSelected;
          AppData.productList.forEach((x) {
            if (x.id == model.id && x.name == model.name) {
              return;
            }
            x.isSelected = false;
          });
          var m = AppData.productList
              .firstWhere((x) => x.id == model.id && x.name == model.name);
          m.isSelected = !m.isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0XFFf8f8f8),
              blurRadius: 15,
              spreadRadius: 10,
            )
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: !model.isSelected ? 20 : 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(
                  model.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: model.isLiked ? LightColor.red : LightColor.iconColor,
                ),
                onPressed: () {
                  setState(() {
                    model.isLiked = !model.isLiked;
                  });
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: model.isSelected ? 10 : 0,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: LightColor.orange.withAlpha(40),
                    ),
                    Image.asset(model.image)
                  ],
                ),
                TitleText(
                  text: model.name,
                  fontSize: model.isSelected ? 15 : 13,
                ),
                TitleText(
                  text: model.category,
                  fontSize: model.isSelected ? 13 : 11,
                  color: LightColor.orange,
                ),
                TitleText(
                  text: model.price.toString(),
                  fontSize: model.isSelected ? 17 : 15,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
