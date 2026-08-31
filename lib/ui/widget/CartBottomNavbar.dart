import 'package:flutter/material.dart';

class CartBottomNavbar extends StatelessWidget {
  const CartBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 140,

      color: Colors.white,

      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Color(0xFF1E3A5F),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                Text(
                  "\$29.00",
                  style: TextStyle(
                    color: Color(0xFF1E3A5F),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),

            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,

              decoration: BoxDecoration(
                color: Color(0xFF1E3A5F),
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}