import 'package:ShoeShop/bloc/cart/cart_bloc.dart';
import 'package:ShoeShop/bloc/product/product_bloc.dart';
import 'package:ShoeShop/screen/cart_screen.dart';
import 'package:ShoeShop/screen/product_screen.dart';
import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:ShoeShop/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;
  PageController _pageController;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override

  void initState() {
    super.initState();
    _pageController = PageController();
  }
  
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF20232A),
      appBar: PreferredSize(child: Container(),preferredSize: Size.fromHeight(0.0)),
      body:  SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index){
            setState(() => _currentIndex = index);
          },
          children: [
            Container(
              child: ProductScreen()
            ),
            Container(
              child: CartScreen()
            ),
          ],
        )
      ),
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.center,
          containerHeight: 56.0,
          backgroundColor: Style.Colors.backgroundColor,
          selectedIndex: _currentIndex,
          onItemSelected: (index){
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items:<BottomNavyBarItem>[
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: Color(0xFF010101),
              title: Text(' PRODUCTS',style: TextStyle(
                color:Style.Colors.mainColor,fontSize: 13.0
              )),
              icon: Padding(
                padding: EdgeInsets.only(left:5.0),
                child: Icon(
                  SimpleLineIcons.menu,
                  size:18.0,
                  color:_currentIndex == 0 ? Style.Colors.mainColor:Colors.white
                ),
              )
            ),
            BottomNavyBarItem(
              textAlign: TextAlign.center,
              activeColor: Color(0xFF010101),
              title: Text(' CART',style: TextStyle(
                color:Style.Colors.mainColor,fontSize: 13.0
              )),
              icon: Padding(
                padding: EdgeInsets.only(left:5.0),
                child: Badge(
                    badgeColor: Style.Colors.mainColor,
                    badgeContent: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if(state is CartSuccess){
                          return Text(state.carts.length.toString(),style: TextStyle(fontWeight: FontWeight.bold),);
                        }
                        return Text('0',style: TextStyle(fontWeight: FontWeight.bold),);
                      }
                    ),
                   child: Icon(
                      SimpleLineIcons.basket,
                      size:18.0,
                      color:_currentIndex == 1 ? Style.Colors.mainColor:Colors.white
                    ),
                )
              )
            ),
          ]
        ),
      ),
    );
  }
}