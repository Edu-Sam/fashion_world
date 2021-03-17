import 'package:fashion_world/services/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:strcolor/strcolor.dart';
import 'package:fashion_world/models/products.dart';
import 'package:fashion_world/models/cart.dart';
import 'package:fashion_world/widgets/shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

/*class ProductDashBoardItem extends StatefulWidget{
  Future<List<Product>> future_product;
  ProductDashBoardItem({Key key,@required this.context,@required this.future_product}) :super(key:key);
 BuildContext context;
  @override
  ProductDashBoardItemState createState()=> ProductDashBoardItemState(context,future_product);
}*/

class ProductDashBoardItem extends StatelessWidget{
  ProductDashBoardItem({Key key,@required this.context,@required this.future_product}) :super(key:key);
 // ProductDashBoardItem(this.context,this.future_product);
  BuildContext context;
  var sizes_selected;
  String selected_color="";
  String selected_product_size='';
  ProductRepository productRepository=new ProductRepository();
  Future<List<Product>> fetchAllProducts;
  List<Sizes> product_sizes;
  Future<List<Product>> future_product;
  Future<List<Product>> new_product;
  var button_status;
  bool colors_on_expanded=false;
  bool is_expanded=true;
  double bottom_sheet_height=0;
  ScrollController scrollViewController = ScrollController();

  String message = '';
  bool _direction = false;

  /*@override
  void initState() {
    scrollViewController = ScrollController();
    scrollViewController.addListener(_scrollListener);
    super.initState();
  }*/

  /*_scrollListener() {
    if (scrollViewController.offset >=
        scrollViewController.position.maxScrollExtent &&
        !scrollViewController.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
        _direction = true;
      });
    }
  }*/
 // Cart cart;

  //ProductDashBoardItem_state(this.future_product);
  /*@override
   void initState() {
    fetchAllProducts=productRepository.getProducts();
    super.initState();
  }*/


  @override
  Widget build(context){
   //
      return  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 3/4,
          child:  Padding(
            padding:EdgeInsets.only(top: 5.0,bottom:5.0,left: 20.0),
            child: FutureBuilder(
              future: future_product,
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.done &&snapshot.hasData && snapshot.data!=null){
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3/4,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        List<Product> userproducts=snapshot.data;
                        return
                          GestureDetector(
                            onTap: (){
                              flushBottomSheet();
                              localSheet(userproducts[index]);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:0,right: 20,top:20,bottom:5
                              ),

                              child: Container(
                                width: MediaQuery.of(context).size.width * 2/5,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),

                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(3.0,3.0),
                                        blurRadius: 3.0,
                                        spreadRadius: 2.0,
                                        color: Colors.black12
                                    ),


                                  ],
                                  /*image: DecorationImage(
                                      image: NetworkImage(userproducts[index].image),
                                      fit: BoxFit.cover
                                  )*/
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3/6,
                                      height: MediaQuery.of(context).size.height * 1/9,
                                      // padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20)),
                                          image: DecorationImage(
                                              image: NetworkImage(userproducts[index].image),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:EdgeInsets.symmetric(
                                            vertical: 0.0,horizontal: 0.0
                                        ),
                                        child:  Wrap(
                                          children: [
                                            Text(userproducts[index].name,style: TextStyle(color:Color.fromRGBO(214,24,195,1),
                                                fontWeight: FontWeight.bold,fontSize: 12),),
                                          ],
                                        ),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.0,horizontal: 50.0,

                                      ),

                                      child: Text("Ksh ${userproducts[index].price}",
                                        style: TextStyle( color: Color.fromRGBO(66, 7, 91,1),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),),
                                    ),

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 1/5,
                                        height: 40,
                                        child: RaisedButton.icon(
                                          color:Color.fromRGBO(214,24,195,1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:BorderRadius.circular(18.0),
                                              side: BorderSide(color: Color.fromRGBO(214,24,195,1))
                                          ),
                                          onPressed: (){
                                            localSheet(userproducts[index]);
                                          },

                                          icon:Icon(Icons.add_shopping_cart_outlined,
                                              color:Colors.white
                                          ),
                                          textColor: Colors.white,
                                          elevation: 10,
                                          label: Text('Add to cart',style: TextStyle(fontSize: 14,
                                              fontWeight: FontWeight.w400,color: Colors.white),),


                                        ),
                                      ),
                                    )
                                    // ShoppingCart()
                                  ],
                                )/*Stack(
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomCenter ,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:EdgeInsets.symmetric(
                                                vertical: 0.0,horizontal: 0.0
                                            ),
                                            child:  Wrap(
                                              children: [
                                                Text(userproducts[index].name,style: TextStyle(color:Color.fromRGBO(214,24,195,1),
                                                    fontWeight: FontWeight.bold,fontSize: 14),),
                                              ],
                                            ),),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2.0,horizontal: 0.0,

                                            ),

                                            child: Text("Ksh ${userproducts[index].price}",style: TextStyle(color: Color.fromRGBO(214,24,195,1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),),
                                          ),

                                          RaisedButton.icon(
                                            color:Color.fromRGBO(214,24,195,1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:BorderRadius.circular(18.0),
                                                side: BorderSide(color: Color.fromRGBO(214,24,195,1))
                                            ),
                                            onPressed: (){
                                              localSheet(userproducts[index]);

                                            },

                                            icon:Icon(Icons.add_shopping_cart_outlined,
                                                color:Colors.white
                                            ),
                                            textColor: Colors.white,
                                            elevation: 10,
                                            label: Text('Add to cart',style: TextStyle(fontSize: 14,
                                                fontWeight: FontWeight.w400,color: Colors.white),),


                                          ),
                                          // ShoppingCart()

                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              )*/,
                              ),
                            ),
                          );
                      },

                    ),
                  );
                }

                else if(snapshot.hasError){
                  return Container();
                }

                else if (snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(214, 24, 195, 1)),
                      strokeWidth: 5,
                    ),
                  );
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(214, 24, 195, 1)),
                      strokeWidth: 5,
                    ),
                  );
                }
              },
            )
          )
      );

  }

  void localSheet(Product userProduct){
    _scrollListener() {
      if (scrollViewController.offset >=
          scrollViewController.position.maxScrollExtent &&
          !scrollViewController.position.outOfRange) {
        //      setState(() {
        message = "reach the bottom";
        _direction = true;
        //    });
      }
    }
    scrollViewController.addListener(_scrollListener);

    /*@override
    void dispose() {
      super.dispose();
      scrollViewController.dispose();
    }*/

    _moveUp() {
      scrollViewController.animateTo(scrollViewController.offset - 50,
          curve: Curves.linear, duration: Duration(milliseconds: 500));
    }

    _moveDown() {
      scrollViewController.animateTo(scrollViewController.offset + 50,
          curve: Curves.linear, duration: Duration(milliseconds: 500));
    }

    showModalBottomSheet(context: context,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top:Radius.circular(20.0))
    ),isScrollControlled: true,
        builder: (BuildContext context){
      return NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollViewController.position.userScrollDirection ==
                ScrollDirection.reverse) {
              print('User is going down');
          //    setState(() {
                message = 'going down';
                _direction = true;
         //     });
            } else {
              if (scrollViewController.position.userScrollDirection ==
                  ScrollDirection.forward) {
                print('User is going up');
          //      setState(() {
                  message = 'going up';
                  _direction = false;
             //   });
              }
            }
            return true;
          },
          child: StatefulBuilder(builder: (BuildContext context,updateState){
            return  Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.80,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:  FutureBuilder(
                      builder: (context,snapshot){
                        if(userProduct.colors!=null){
                          return  Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(3.0,3.0)
                                  )
                                ],
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                              ),

                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Column(

                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            children: [
                                              Text(userProduct.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,
                                                  color: Color.fromRGBO(214,24,195,1)))
                                            ],
                                          ),

                                          Text( "Ksh " + userProduct.price,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color:
                                          Color.fromRGBO(214,24,195,1)),)


                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.black12),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                                      child: Align(
                                        alignment: FractionalOffset.centerLeft,
                                        child: Text("Available colors",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(66, 7, 91,1)),),
                                      ),
                                    ),
                                   Padding(
                                     padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                     child:  ExpansionPanelList(
                                       elevation: 0,
                                       expansionCallback:(int index,bool isExpanded){
                                         updateState((){
                                           is_expanded=!is_expanded;
                                           if(is_expanded){
                                             selected_color="";
                                             selected_product_size="";
                                             product_sizes=[];
                                             sizes_selected=[];
                                           }
                                         });
                                       },
                                       children: [
                                         ExpansionPanel(
                                             headerBuilder: (BuildContext context,bool isexpanded){
                                               return ListTile(
                                                 title: Text('Please select a colour from the pallette below',style: TextStyle(
                                                     color: Colors.black54,fontSize: 11,fontWeight: FontWeight.w500
                                                 ),),
                                               );
                                             },
                                             body:  Container(
                                               width: MediaQuery.of(context).size.width,
                                               height: MediaQuery.of(context).size.height * 1/5,
                                               child: GridView.builder(
                                                   gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(
                                                     crossAxisCount: 4,
                                                     childAspectRatio: 3 / 2,
                                                     crossAxisSpacing: 10,
                                                     mainAxisSpacing: 10,

                                                   ),
                                                   itemCount: userProduct.colors.length,
                                                   itemBuilder: (ctx,index){
                                                     return Column(
                                                       children: [
                                                         Padding(
                                                           padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
                                                           child: Container(
                                                             width: 30,height: 30,
                                                             child: RaisedButton(shape: CircleBorder(side: BorderSide.none),
                                                               color: convert_string_to_color(userProduct.colors[index].colors),onPressed: (){
                                                                 updateState((){
                                                                   is_expanded=false;
                                                                   selected_color=userProduct.colors[index].colors;
                                                                   product_sizes=userProduct.colors[index].size;
                                                                   sizes_selected=new List(product_sizes.length);
                                                                   print('The length of the list is ' + sizes_selected.length.toString());
                                                                   for(int i=0;i<sizes_selected.length;i++){
                                                                     sizes_selected[i]=false;
                                                                   }

                                                                 });
                                                               },
                                                             ),
                                                           ),
                                                         ),

                                                       ],
                                                     );
                                                   }
                                               ),
                                             ),/*ListTile(
                                               title:Text('Item 1 child'),
                                               subtitle: Text('Details go here'),
                                             ),*/
                                             isExpanded: is_expanded,
                                           canTapOnHeader: true
                                         )
                                       ],
                                     ),
                                   ),
                                   /*Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                                        child: Container(
                                    //      duration: Duration(milliseconds: 100),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height * 1/3,
                                          child:

                                          ExpansionTile(
                                            title: Text('Please select a colour from the pallette below',style: TextStyle(
                                                color: Colors.black54,fontSize: 11,fontWeight: FontWeight.w500
                                            ),),
                                            onExpansionChanged: (item){
                                              if(item){
                                                updateState((){
                                                  colors_on_expanded=true;
                                                  Duration(milliseconds:  500);
                                                  is_expanded=false;
                                                });
                                              }
                                              else{
                                                updateState((){
                                                  colors_on_expanded=false;
                                                });
                                              }
                                            },
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height * 1/5,
                                                child: GridView.builder(
                                                    gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      childAspectRatio: 3 / 2,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,

                                                    ),
                                                    itemCount: userProduct.colors.length,
                                                    itemBuilder: (ctx,index){
                                                      return Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
                                                            child: Container(
                                                              width: 30,height: 30,
                                                              child: RaisedButton(shape: CircleBorder(side: BorderSide.none),
                                                                color: convert_string_to_color(userProduct.colors[index].colors),onPressed: (){
                                                                  updateState((){
                                                                    colors_on_expanded=false;
                                                                    selected_color=userProduct.colors[index].colors;
                                                                    product_sizes=userProduct.colors[index].size;
                                                                    sizes_selected=new List(product_sizes.length);
                                                                    print('The length of the list is ' + sizes_selected.length.toString());
                                                                    for(int i=0;i<sizes_selected.length;i++){
                                                                      sizes_selected[i]=false;
                                                                    }

                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      );
                                                    }
                                                ),
                                              )
                                            ],
                                          )
                                        )
                                    ),*/
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 0.0),
                                      child: Align(
                                        alignment: FractionalOffset.centerLeft,
                                        child: Text("Size",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(66, 7, 91,1)),),
                                      ),
                                    ),

                                    selected_color != "" ?
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 0.0),
                                      child: Align(
                                          alignment: FractionalOffset.centerLeft,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height * 1/4,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                    child:  Text("Select the preferred size from the menu below",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black45,
                                                        fontSize: 12),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                                                    child: Row(
                                                      children: [
                                                        Text("Color Selected:",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black45,
                                                            fontSize: 12),),
                                                        Container(
                                                          width: 40,height: 20,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                              color: convert_string_to_color(selected_color)
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height * 1/10,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              height:  MediaQuery.of(context).size.height * 1/12,
                                                              child: Row(
                                                                children: [
                                                                  IconButton(
                                                                    icon: Icon(Icons.arrow_back_ios,
                                                                      color: convert_string_to_color(selected_color),
                                                                      size: 30,),
                                                                    onPressed: (){
                                                                      updateState((){
                                                                        _moveUp();
                                                                      });
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(context).size.width * 3/6,
                                                                    height: 80,
                                                                    child: ListView.builder(
                                                                      controller: scrollViewController,
                                                                      itemCount: product_sizes!=null ? product_sizes.length : 0,
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemBuilder: (context,index){
                                                                        return Padding(
                                                                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                                                            child:  ChoiceChip(label: Text(product_sizes[index].size,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Open Sans',color: sizes_selected[index] ?Colors.white: convert_string_to_color(selected_color)),
                                                                            ), selected: false,
                                                                              avatar: sizes_selected[index] ? Icon(Icons.check,color: Colors.white,):null,
                                                                              shape: StadiumBorder(side: BorderSide(color: convert_string_to_color(selected_color))),
                                                                              elevation: 5,
                                                                              onSelected: (bool selected){
                                                                                updateState((){
                                                                                   selected_product_size="";
                                                                                  for(int i=0;i<product_sizes.length;i++){
                                                                                    if(i==index){
                                                                                      sizes_selected[index]=!sizes_selected[index];
                                                                                      if(sizes_selected[index]==true){
                                                                                        selected_product_size=product_sizes[index].size;
                                                                                      }

                                                                                      print('The selected size is ' + selected_product_size);
                                                                                    }
                                                                                    else{
                                                                                      sizes_selected[i]=false;
                                                                                    }
                                                                                  }
                                                                                });
                                                                              },backgroundColor:sizes_selected[index] ? convert_string_to_color(selected_color):
                                                                              Colors.white,
                                                                              selectedColor: sizes_selected[index] ? Colors.white: convert_string_to_color(selected_color),
                                                                            ));
                                                                      },
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    icon: Icon(Icons.arrow_forward_ios,
                                                                      color: convert_string_to_color(selected_color),
                                                                      size: 30,),
                                                                    onPressed: (){
                                                                      updateState((){
                                                                        _moveDown();
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                          ),


                                                        ],
                                                      )
                                                  ),

                                                  Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 45,
                                                        child: RaisedButton.icon(
                                                            textColor: Colors.white,
                                                            elevation: 10,
                                                            color: selected_product_size.isNotEmpty ? Color.fromRGBO(214,24,195,1) : Color.fromRGBO(214,24,195,0.2),
                                                            icon:Icon(selected_product_size.isNotEmpty ? Icons.add_shopping_cart_outlined : null,
                                                                color:Colors.white
                                                            ),
                                                            label: Text(selected_product_size.isNotEmpty ?'Add to Cart': 'No item selected',style: TextStyle(color: Colors.white,
                                                              fontSize: 14,fontWeight: FontWeight.w600,),
                                                            ),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                            onPressed:(){
                                                              addToCart(userProduct, selected_product_size);
                                                              flushBottomSheet();
                                                              Navigator.of(context).pop();
                                                            }

                                                          //  Navigator.of(context).pop();

                                                        ),
                                                      ))
                                                ],
                                              )
                                          )
                                      ),
                                    ) :
                                    Container()
                                  ],
                                ),
                              )
                          );
                        }

                        else{
                          return Center();
                        }
                      },
                    )
                )
            );
          }

          ));
        }


    );
  }


  int increment_counter(int index){
    int init_index=index;
    init_index++;
    return init_index;
  }

  Color convert_string_to_color(String strcolor){
    List<String> initial_string=strcolor.split(',');
    int red_value=int.parse(initial_string[0]);
    int green_value=int.parse(initial_string[1]);
    int blue_value=int.parse(initial_string[2]);
    int opacity_value=1;

    return Color.fromRGBO(red_value,green_value,blue_value,1);
  }

  addToCart(Product userProduct,String product_size){
     // setState((){
        CartItemsData cartItemsData=new CartItemsData(orderNo: '0000001',pId: userProduct.id,pName:userProduct.name,
            price:userProduct.price,size: product_size,color: selected_color,quantity: '1');
        Provider.of<Cart>(context,listen: false).increaseCartSize(cartItemsData);
        print('The new size is '+ Provider.of<Cart>(context,listen: false).cart_size.toString());
     // });


  }

  /*selectCategory(int size,int index,Product product){
    for(int i=0;i<size;i++){
      if(i==index){
    //    setState(() {
          button_status[index]=!button_status[index];
          current_category=categories.name;
          print('The selected category is ' + current_category);
   //     });
      }
      else{
    //    setState(() {
          button_status[i]=false;
     //   });
      }
    }
  }*/
  flushBottomSheet(){
   // setState(() {
      sizes_selected=[];
      selected_color="";
      selected_product_size="";
   // });
  }

}