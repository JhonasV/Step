import 'package:flutter/material.dart';

List<Map<String, dynamic>> stepMenuItems = [
  {
    "title": "Competencias",
    "subtitle": "Gestion",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/competencies.jpg",
    "color1": Colors.blue,
    "color2": Colors.blue[200],
    "screenPath": "compentencies_screen",
    "access": ["admin"]
  },
  {
    "title": "Idiomas",
    "subtitle": "Gestion",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/languages.jpg",
    "color1": Colors.red,
    "color2": Colors.red[200],
    "screenPath": "",
    "access": ["admin"]
  },
  {
    "title": "Capacitaciones",
    "subtitle": "Gestion",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/trainings.jpg",
    "color1": Colors.green,
    "color2": Colors.green[200],
    "screenPath": "",
    "access": ["admin"]
  },
  {
    "title": "Puestos",
    "subtitle": "Gestion",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/job_roles.jpg",
    "color1": Colors.black,
    "color2": Colors.grey[200],
    "screenPath": "",
    "access": ["admin"]
  },
  {
    "title": "Candidatos",
    "subtitle": "Completa tu información de candidato",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/candidates.jpg",
    "color1": Colors.blue,
    "color2": Colors.blue[200],
    "screenPath": "",
    "access": ["admin", "candidate"]
  },
  {
    "title": "Experiencia laboral",
    "subtitle": "Hablános de tu experiencia",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/experience.jpg",
    "color1": Colors.orange,
    "color2": Colors.orange[200],
    "screenPath": "",
    "access": ["admin", "candidate"]
  },
  {
    "title": "Selección candidato",
    "subtitle": "Gestiona tus candidatos",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/competencies.jpg",
    "color1": Colors.yellow,
    "color2": Colors.yellow[200],
    "screenPath": "",
    "access": ["admin"]
  },
  {
    "title": "Consultas",
    "subtitle": "Información de los candidatos",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/competencies.jpg",
    "color1": Colors.purple,
    "color2": Colors.purple[200],
    "screenPath": "",
    "access": ["admin"]
  },
  {
    "title": "Reportes",
    "subtitle": "Estadísticas de candidatos",
    "icon": Icons.arrow_right,
    "imageUrl": "assets/images/competencies.jpg",
    "color1": Colors.teal,
    "color2": Colors.teal[200],
    "screenPath": "",
    "access": ["admin"]
  },
];
