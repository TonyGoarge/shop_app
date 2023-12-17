import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(bottomOpacity: 5.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:
               [
                Text(
                  'Find Your \nFavorite Food',
                    style: Theme.of(context).textTheme.headline4?..copyWith(height: 5.0),
                ),
                Spacer(),
                 IconButton(onPressed: (){}, icon:Icon(Icons.notifications_none,size: 40.0,color: Colors.green,) ),
               ]

            ),
          ),

        ],
      ),
    );
  }
}
