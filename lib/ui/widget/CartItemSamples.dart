import 'package:flutter/material.dart';

class Cartitemsamples extends StatelessWidget {
  const Cartitemsamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 1; i <= 4; i++)
          Container(
            height: 110,

            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Row(
              children: [
                Radio(
                  value: '',
                  groupValue: '',
                  activeColor: Color(0xFF1E3A5F),
                  onChanged: (index) {},
                ),

                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(right: 15),

                  child: Image.asset(
                    'assets/images/cart/$i.png',
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(
                          color: Color(0xFF1E3A5F),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "\$29.00",
                        style: TextStyle(
                          color: Color(0xFF1E3A5F),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),

                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    crossAxisAlignment:
                        CrossAxisAlignment.end,

                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(20),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),

                            child: Text(
                              "01",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Color(0xFF1E3A5F),
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(20),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}