import 'package:flutter/material.dart';

class StepMenu extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imageUrl;
  StepMenu({this.title, this.subtitle, this.icon, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Step cards tapped"),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Color.fromRGBO(28, 28, 27, 0.9),
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildTitle(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildSubtitle(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: _buildButton(),
            )
          ],
        ),
      ),
    );
  }

  Row _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          color: Colors.white,
          onPressed: () {},
          child: Text(
            "In Progress",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              color: Colors.orange[300],
            ),
          ),
        ),
        Icon(
          Icons.arrow_right_rounded,
          color: Colors.white,
          size: 45.0,
        )
      ],
    );
  }

  Row _buildSubtitle() {
    return Row(
      children: [
        Text(
          subtitle,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              shadows: [
                Shadow(
                  color: Colors.blue.shade900.withOpacity(1.0),
                ),
              ]),
        ),
      ],
    );
  }

  Row _buildTitle() {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
