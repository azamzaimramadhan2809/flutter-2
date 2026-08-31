import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      color: Colors.white,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),

      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child: const Icon(
              Icons.arrow_back,

              size: 30,

              color:
                  Color(0xFF1E3A5F),
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          const Text(
            '🛒',

            style: TextStyle(
              fontSize: 23,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          const Text(
            'Shopping Cart',

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
              color:
                  Color(0xFF1F2937),
            ),
          ),

          const Spacer(),

          const Icon(
            Icons.more_vert,

            size: 28,

            color:
                Color(0xFF4F6D8A),
          ),
        ],
      ),
    );
  }
}