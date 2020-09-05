import 'package:Step/widgets/step_menu_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "My Steps",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                StepMenu(
                  title: "Competencias",
                  subtitle: "Cuéntanos de tus conocimientos",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/competencies.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Idiomas",
                  subtitle: "¿Qué idiomas hablas?",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/languages.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Capacitaciones",
                  subtitle: "¿Cuales capacitaciones tienes?",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/trainings.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Puestos",
                  subtitle: "¿Cuáles puestos haz desempeñado?",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/job_roles.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Candidatos",
                  subtitle: "Completa tu información de candidato",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/competencies.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Experiencia laboral",
                  subtitle: "Hablános de tu experiencia",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/competencies.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Selección candidato",
                  subtitle: "Gestiona tus candidatos",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/competencies.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Consultas",
                  subtitle: "Consulta información de los candidatos",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/competencies.jpg",
                ),
                SizedBox(
                  height: 3.0,
                ),
                StepMenu(
                  title: "Reportes",
                  subtitle: "Estadísticas de la gestión de candidatos",
                  icon: Icons.arrow_right,
                  imageUrl: "assets/images/competencies.jpg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
