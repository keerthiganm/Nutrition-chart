import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Nutri extends StatefulWidget {
  @override
  _NutriState createState() => _NutriState();
}

class _NutriState extends State<Nutri> {
  String food = 'Tomato';
  int serving = 100;
  String name;
  double calories, protein, sugar, fiber, cholestrol, fattot;
  String calory, pro, sug, fib, coles, fat;
  Map<String, String> get header =>
      {'X-Api-Key': 'VCss15xNMOAe4yCTSJt2ZA==d4Z7Woo2IFcON66s'};

  @override
  void initState() {
    super.initState();
    getData(food);
  }

  void getData(String food) async {
    http.Response response = await http.get(
        Uri.parse('https://api.calorieninjas.com/v1/nutrition?query=$food'),
        headers: header);
    try {
      //var data = await Display().nutritionalvalues(food);
      setState(() {
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          name = decodedData['items'][0]['name'];
          calories = decodedData['items'][0]['calories'];
          protein = decodedData['items'][0]['protein_g'];
          sugar = decodedData['items'][0]['sugar_g'];
          fiber = decodedData['items'][0]['fiber_g'];
          cholestrol = decodedData['items'][0]['cholesterol_mg'];
          fattot = decodedData['items'][0]['fat_total_g'];
          calory = calories.toString();
          pro = protein.toString();
          sug = sugar.toString();
          fib = fiber.toString();
          coles = cholestrol.toString();
          fat = fattot.toString();
        } else {
          print(response.statusCode);
          return response.statusCode;
        }
        return calory;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nutrition chart'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                icon: Icon(
                  Icons.food_bank,
                  color: Colors.white,
                  size: 60.0,
                ),
                hintText:
                    'Nutritional value of tomato,type the food item you want to know the value',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                food = value;
                print(food);
              },
            ),
          ),
          SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
              getData(food);
            },
            child: Text(
              'Nutrition',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
              //backgroundColor: Colors.black,
              elevation: 20,
              minimumSize: Size(100, 50),
              // side: BorderSide(color: Colors.black, width: 2),
              // padding: EdgeInsets.all(20.0)
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: (Text(
              ' name:$name \n serving:$serving \n calories:$calory \n protein in g:$protein \n sugar in g:$sugar \n fiber in g:$fiber \n cholestrol in mg:$coles \n fat in g:$fat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
