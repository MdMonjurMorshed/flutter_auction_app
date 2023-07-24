# auction_bd24

A new Flutter project.

## Getting Started

## First problem
The first problem i have faced to start this project is Multidex support problem.
because i was using cloud_firestore which supports Multidex support.

# Solve of multidex suppost problem
i have searched in online and found that minsdk 21 will resolve this issue

## Problem of the LoginController
 i was trying to make user logged in thats why i was using inst3ence of the logincontroller. by the way i am using bindings to get register the controllers but in the GetMaterialApp() i have user Spalahwidget. so that 
 the LoginController was not initializing. thats why user logged data was not getting .
 # solve of the problem of LoginController
 i have used Get.put(LoginController()) before the app initialization in the main

## adding the product
while adding product for get into auction, here i have faced the problem with the type of the price field .Price is double type field . while unfortunately add any extra data insteed of number it was showing exception on the model class. because i have made a model to get the data recognized.

# solve of product price problem
To solve the problem in the model call i have parsed the data from other format to double.i also used regx() built in method to do that

## product bidding button and edit button
once user made a bid ,he.she can not add it anymore. so they need to edit it.but when i was making single button to make bid and edit it was working well for the single user . i mean when i logged out and enter the another accout with the same device and enter to make auction bid. i saw there were only edit button for me .but i still even add any yet.

# solve of bidding button and edit button
 to resolve this issue, i have made user model and get the user data . along with the user data i have passed a RxBool type observeable variavle and set the default value as false. Now when i click on the button to make bid i have change that bool value false to true for  the specific user. so now after adding a bid then we have only option to edit in the hand.