import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Shop%20App/login/shop_login_screen.dart';
import 'package:shop_app/Shop%20App/login/social_loginscreen2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
var boardcontroller=PageController();

  List<BoardingModel>boarding=[

    BoardingModel(
        image: 'images/onboard_1-.png',
        title: 'Choose your product',
        body: 'There are many brands of men\'s and women\'s and many devices',

    ),
    BoardingModel(
        image: 'images/onboard_2-.png',
        title: 'Pay by card',
        body: 'The order can be paid by credit card or in cash at the time of delivery',

    ),
    BoardingModel(
        image: 'images/onboard_3-.png',
        title: 'Add to favorite',
        body: 'Just click and you can buy all products with home delivery',
      ),
    BoardingModel(
        image: 'images/onboard_4.png',
        title: 'Recommendation System',
        body: 'Recommender systems usually make use of either or both collaborative filtering and content-based filtering (also known as the personality-based approach) as well as other systems such as knowledge-based systems. ',
      ),
  ];
bool isLast=false;

void submit()
{
  CachHelper.saveData(key: 'onBoarding', value: true,).then((value)
  {
  if(value)
    {
      NavigatorandFinish(context,ShopLoginScreen(),);
    }
  });


}
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: defaultboardColor,
      appBar:AppBar(
        actions: [
          defaulttextbutton(
              text: 'skip',
              onpress:submit,
            background: Colors.white,
          ),

      ],
        backgroundColor: defaultboardColor,
    ),

      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(

          children:
          [
            Expanded(
              child: PageView.builder(
                physics:BouncingScrollPhysics(),    //شكلها يبقا بيتمط في القلبه
                onPageChanged: (int index)
                {
                  if(index==boarding.length-1)
                    {
                      setState(()
                      {
                        isLast=true;
                      });

                    }
                  else
                    {

                    setState(()
                    {
                      isLast=false;
                    });
                  }
                },
                controller: boardcontroller,
                itemBuilder: (context,index)=>buildboardingitem(boarding[index]),
                itemCount:boarding.length ,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children:
              [
               SmoothPageIndicator(
                   effect: ExpandingDotsEffect(
                   dotColor: Colors.grey,
                   dotHeight: 10,
                   activeDotColor: Colors.white,
                   expansionFactor: 4,
                   spacing: 5.0,
                   dotWidth: 10,
                 ),
                   controller: boardcontroller,
                   count: boarding.length,
               ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                {
                  if(isLast)
                    {
                      submit();
                    }
                  else
                  {

                boardcontroller.nextPage(duration: Duration(
                milliseconds: 750,
                ),
                curve: Curves.fastLinearToSlowEaseIn,
                );
                }

                  },
                child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: defaultboardColor,
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildboardingitem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
          fit: BoxFit.fitWidth,
        ),
      ),
      SizedBox(
        height:30.0,
      ),
      Text(
        '${model.title}',
        style:TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,

        ),
      ),

      SizedBox(
        height:15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(

          fontSize: 14.0,
        ),
      ),



    ],
  );

}
