import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onboarding_screen_demo/data/onboarding_data.dart';
import 'package:onboarding_screen_demo/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;


  gotoNextPage(){

    if(currentPage+1<onboardingData.length){

      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);


    }

    else{

      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));


    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
          
              Expanded(child: PageView.builder(
                itemCount: onboardingData.length,
                controller: _pageController,
                onPageChanged: (pageNumber){

                  setState(() {
                    
                    currentPage = pageNumber;
                  });

                  log(pageNumber.toString());

                },
                itemBuilder: (context, index){
          
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
                  Image(image: AssetImage(onboardingData[index]['imagePath']!)),
                  Text(onboardingData[index]['title']!, 
                  textAlign: TextAlign.center,
                  style: const TextStyle(
          
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
          
                  ),),
          
                  SizedBox(height: 10,)
          ,
          
                   Text(onboardingData[index]['description']!, 
                  textAlign: TextAlign.center,
                  style:  const TextStyle(
          
                    // fontWeight: FontWeight.bold,
                    fontSize: 19,
          
                  ),)
          
          
          
                ],);
              })),
          
              Container(
                width: double.maxFinite,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                
                  InkWell(
                    onTap: (){
                      _pageController.jumpToPage(onboardingData.length-1);
                    },
                    child: const  Text("SKIP", style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo
                    ),),
                  ),
                    Row(
                      children: List.generate(onboardingData.length, (index){
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 10,
                            width: currentPage == index? 25: 10,
                            decoration: BoxDecoration(
                            color: currentPage == index? Colors.indigo: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
          
          
                            ),
                          ),
                        );
                      }),
                    ),
                    InkWell(
                      onTap: (){
                        gotoNextPage();
                      },
                      child: Container(
                        height: height*0.05,
                        width: width*0.18,
                        decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(10)
                      
                          
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Next", style: TextStyle(
                              color: Colors.white
                            ),),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        
                      ),
                    )
                
                  ],
                ),
              )
            ],
          ),
        ),
        
      
      ),
    );
  }
}