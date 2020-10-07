import 'package:Step/screens/competencies_screen.dart';
import 'package:flutter/material.dart';

class StepMenu extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imageUrl;
  final Color color1, color2;
  StepMenu(
      {this.title,
      this.subtitle,
      this.icon,
      this.imageUrl,
      this.color1,
      this.color2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, CompentenciesScreen.id),
      child: Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [color1, color2],
            begin: Alignment.centerLeft,
            end: Alignment(1.0, 1.0),
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
              child: Column(
                children: [
                  _buildTitle(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _buildSubtitle(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: _buildButton(context),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          color: Colors.white,
          onPressed: () => Navigator.pushNamed(context, CompentenciesScreen.id),
          child: Text(
            "Start",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              color: Colors.green[300],
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
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
          ),
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
