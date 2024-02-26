import 'package:flutter/material.dart';

import '../shared/data/data.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'All Products',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,

        leading: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
          ),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: Icon(
              Icons.list,
              color: Colors.black,
            ),
          ),
        ),

        actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
          ),
          child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
          ),
        ),
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5 /9,

          ), itemBuilder: (context,index){
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Card(
                  elevation: 0.0,
                  child: Column(
                    children: [
                      Image.network(
                        data[0]['image'],

                      ),
                      Text(
                          data[0]['title'],
                      ),
                      Text(
                        data[0]['price'].toString(),
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            );
      }, itemCount: 10,),
    );
  }
}
