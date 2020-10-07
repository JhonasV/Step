import 'package:flutter/material.dart';

class CompentenciesScreen extends StatefulWidget {
  static final String id = "compentencies_screen";
  @override
  _CompentenciesState createState() => _CompentenciesState();
}

class _CompentenciesState extends State<CompentenciesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 50.0),
            padding: EdgeInsets.all(20.0),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 40.0),
                    child: Text(
                      "Compentencias",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                          decorationColor: Colors.orange[400]),
                    ),
                  ),
                  _buildTextFieldTitle("Identificador"),
                  _buildTextField(""),
                  _buildTextFieldTitle("Descripción"),
                  _buildTextField(""),
                  _buildTextFieldTitle("Estado"),
                  _buildDropDown(),
                  _buildFlatButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTextFieldTitle(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }

  Container _buildFlatButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: Colors.blue),
      height: 45.0,
      width: double.infinity,
      child: FlatButton(
        onPressed: null,
        child: Text(
          "Guardar",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.white, fontSize: 23.0),
        ),
      ),
    );
  }

  Container _buildDropDown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(border: InputBorder.none),
        value: 'activo',
        items: [
          DropdownMenuItem<String>(
            child: Text('Activo'),
            value: 'activo',
          ),
          DropdownMenuItem<String>(
            child: Text('Inactivo'),
            value: 'inactivo',
          ),
        ],
        onChanged: (String newValue) => print(newValue),
      ),
    );
  }

  Container _buildTextField(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
