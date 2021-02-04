import 'package:flutter/material.dart';
import 'package:fashion_world/models/categories.dart';
import 'package:fashion_world/services/product_repository.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:fashion_world/models/products.dart';
class CategoriesPage extends StatefulWidget{
  CategoriesPage({Key key,@ required this.userCategories,@required this.button_status,
  @required this.future_product}): super(key:key);
  var button_status;
  final List<Categories> userCategories;

  Future<List<Product>> future_product;
  @override
  Categories_state createState()=> Categories_state(userCategories,button_status,future_product);
}

class Categories_state extends State<CategoriesPage>{

  Categories_state(this.userCategories,this.button_status,future_product);
  var button_status;
  Future<List<Product>> future_product;
  var brands_selected=[false,false,false,false,false,false];
  List<Product> all_products = [],products_by_categories=[];
  ProductRepository productRepository=new ProductRepository();
  List<Categories> userCategories=[];
   String current_category='';

  @override
  void initState() {
 // fetchCategories=productRepository.getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StatefulBuilder(builder: (BuildContext context,updateState){
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close_outlined,color: Colors.white,size: 20,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(
                    top:30.0,
                    left:20.0,
                    right: 20.0,
                    bottom: 2.0,
                  ),

                  child: Text('Categories',style: TextStyle(fontWeight: FontWeight.w700,
                      fontSize: 18,fontFamily: 'Open Sans',color: Colors.white),),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20.0),
                  child:  Divider(color: Colors.white),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1/4,
                        child: // GridView.count(
                        //         crossAxisCount: 2,
                        GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 9/9,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 50
                          ),

                          itemCount: userCategories.length,
                          itemBuilder: (context,index){
                            //  List<Categories> userCategories=snapshot.data;
                            return  ChoiceChip(label: Text(userCategories[index].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,
                              fontFamily: 'Open Sans',color: button_status[index] ? Colors.white: Color.fromRGBO(214,24,195,1),),
                            ), selected: button_status[index],
                              avatar: button_status[index] ? Icon(Icons.check,color: Colors.white,) :null,
                              shape: StadiumBorder(side: BorderSide(color: Color.fromRGBO(214,24,195,0.3))),
                              elevation: 5,
                              onSelected: (bool selected){

                                updateState((){
                                  selectCategory(userCategories.length, index,userCategories.elementAt(index));
                          });
                              },backgroundColor:Colors.white,
                              selectedColor: Color.fromRGBO(214,24,195,1),);

                          },
                        )
                    )),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical:0.0,horizontal: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width *9/10,
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                updateState((){
                                  updateCategoryStatus();
                                  Navigator.pop(context);
                                });
                              },
                              color: Color.fromRGBO(214, 24, 195, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(24))),
                              child: Text(
                                "Search",style: TextStyle(fontSize: 16,fontFamily: 'Open Sans',color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),
                              ),

                            ),
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width *9/10,
                            height: 50,
                            child: OutlineButton(
                              onPressed: () {
                                flushCategories(userCategories.length);
                                Navigator.pop(context);
                              },
                              //   color: Color.fromRGBO(214, 24, 195, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(24))),
                              child: Text(
                                "Clear",style: TextStyle(fontSize: 16,fontFamily: 'Open Sans',
                                  color: Color.fromRGBO(214,24,195,1),
                                  fontWeight: FontWeight.w600
                              ),
                              ),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(214,24,195,1)
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                )

              ]));
    });


  }

  selectCategory(int size,int index,Categories categories){
    for(int i=0;i<size;i++){
      if(i==index){
        setState(() {
          button_status[index]=!button_status[index];
          current_category=categories.name;
          print('The selected category is ' + current_category);
        });
      }
      else{
        setState(() {
          button_status[i]=false;
        });
      }
    }
  }

  flushCategories(int size){
    for(int i=0;i<size;i++){
      setState((){
        button_status[i]=false;
      });
    }

    setState(() {
      Provider.of<Categories>(context,listen: false).flushName();
      //future_product=this.getProducts();
    });
  }

  updateCategoryStatus(){
    setState(() {
      Provider.of<Categories>(context,listen: false).flushName();
      Provider.of<Categories>(context,listen: false).updateName(current_category);
      print('The searched text is '+ current_category);
     // future_product=this.getProductByCategory(current_category);
    });
  }

  Future<List<Product>> getProductByCategory(String category) async{
    products_by_categories=await this.productRepository.getProductByCategories(category);
    return products_by_categories;
  }

  Future<List<Product>> getProducts() async {
    all_products = await this.productRepository.getProducts();
    return all_products;
  }

}




