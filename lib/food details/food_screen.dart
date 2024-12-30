import 'package:calories_coach/food%20details/custom_food_widget.dart';
import 'package:calories_coach/food%20details/meal.dart.dart';
import 'package:calories_coach/food%20details/FoodDetailsScreen.dart';
import 'package:calories_coach/screens/home_screen.dart';
import 'package:calories_coach/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodScreen extends StatefulWidget {
  static const routeName = "foodScreen";

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  TextEditingController searchController = TextEditingController();
  List<Meal> foodDetails = [];
  List<Meal> filteredFoodDetail = []; // القائمة المفلترة
  String searchName = "";

  @override
  void initState() {
    super.initState();
    readFile();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onChanged: (value) => filterFoodList(value),
          decoration: InputDecoration(
            hintText: "Search Food",
            border: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.titleMedium,
          ),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              searchController.clear();
              filterFoodList('');
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: filteredFoodDetail.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (filteredFoodDetail[index] != null) {
                  Navigator.of(context).pushNamed(
                    FoodDetailsScreen.routeName,
                    arguments: filteredFoodDetail[index],
                  );
                } else {
                  print("Meal not exist");
                }
              },
              child: CustomFoodWidget(
                title: filteredFoodDetail[index].title,
                imageName: filteredFoodDetail[index].imagesName,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: height * 0.005,
            ),
            itemCount: filteredFoodDetail.length,
          ),
        ),
      ),
    );
  }

  readFile() async {
    try {
      print("Starting to read file...");
      final allFoodList = await rootBundle.loadString("assets/files/FoodFile.txt");
      print("File loaded successfully.");
      List<String> foods = allFoodList.trim().split("#");
      print("Number of food items: ${foods.length}");
      for (int i = 0; i < foods.length; i++) {
        List<String> foodLines = foods[i].trim().split("\n");
        print("Food $i: $foodLines");
        if (foodLines.length == 6) {
          String foodTitle = foodLines[0];
          double protein = double.parse(foodLines[1]);
          double fats = double.parse(foodLines[2]);
          double carb = double.parse(foodLines[3]);
          double calories = double.parse(foodLines[4]);
          String image = foodLines[5];
          foodDetails.add(Meal(
            protein: protein,
            fats: fats,
            calories: calories,
            carb: carb,
            title: foodTitle,
            imagesName: image,));
          print("Added food item: $foodTitle");
        } else {
          print("Invalid food block at index $i: ${foodLines.length} lines");
        }
      }
      setState(() {
        filteredFoodDetail = foodDetails;
      });
    } catch (e, stackTrace) {
      print("Error reading file: $e");
      print("StackTrace: $stackTrace");
    }
  }
  void filterFoodList(String searchQuery) {
    setState(() {
      filteredFoodDetail = foodDetails
          .where((food) => food.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }
}
