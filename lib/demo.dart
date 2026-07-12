import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

double result = 0;
final TextEditingController textEditingController = TextEditingController();

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text(
          "Currency Calculator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,

          child: Container(
            height: 500,
            width: 200,

            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 77, 77, 77),
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(30),

              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.asset(
                        "assets/images/back.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 125,
                      child: Text(
                        result.toString(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 105, 105, 105),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 250,
                      left: 20,
                      right: 20,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter money to Convert INR into USD",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            
                          )
                        ),
                        keyboardType: TextInputType.number,
                        controller: textEditingController,
                      ),
                    ),

                    Positioned(
                      top: 300,
                      left: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          result =
                              double.parse(textEditingController.text) * 91;
                          setState(() {});
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 6, 187),
                          foregroundColor:const Color.fromARGB(255, 105, 105, 105),
                        ),
                        child: Text("Click Me"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
