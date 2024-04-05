import 'package:flutter/material.dart';

class TicketDetailsTile extends StatelessWidget {
  final void Function()? onTap;
  //Todo: have a ticket object
  const TicketDetailsTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(40),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.blue.shade300,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTileData("Date and Time", "30/03/24-9:00AM"),
            _buildTileData("Memebers ", "5"),
          ],
        ),
      ),
    );
  }

  Widget _buildTileData(String key, String val) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
