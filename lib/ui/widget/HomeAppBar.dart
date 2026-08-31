import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),

      child: Row(
        children: [
          Icon(
            Icons.sort,
            size: 30,
            color: Color(0xFF1E3A5F),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Appointments",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A5F),
              ),
            ),
          ),

          Spacer(),

          badges.Badge(
            badgeStyle: badges.BadgeStyle(
              badgeColor: Color(0xFFE8B44F),
              padding: EdgeInsets.all(7),
            ),

            badgeContent: Text(
              "7",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'ListChatPage',
                );
              },

              child: Icon(
                Icons.message_sharp,
                size: 32,
                color: Color(0xFF4F6D8A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}