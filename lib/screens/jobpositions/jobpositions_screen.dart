import 'dart:io';
import 'package:Step/models/jobpositions.dart';
import 'package:Step/screens/PdfViewerScreen.dart';
import 'package:Step/screens/jobpositions/create_jobpositions.dart';
import 'package:Step/services/jobpositions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'listview_jobpositions.dart';

class JobPositionsScreen extends StatefulWidget {
  static final String id = "jobpositions_screen";
  @override
  _JobPositionsState createState() => _JobPositionsState();
}

class _JobPositionsState extends State<JobPositionsScreen> {
  final pdf = pw.Document();

  List<JobPositions> _jobPositions;

  @override
  initState() {
    super.initState();
    _setupFetchJobPositions();
  }

  _setupFetchJobPositions() async {
    var result = await JobPositionsService.getAll();
    if (result.length > 0) setState(() => _jobPositions = result);
  }

  void _writeOnPdf() {
    List<pw.Widget> widgets = [
      pw.Header(level: 0, child: pw.Text("Posiciones de trabajo")),
      pw.Header(
          level: 1,
          child: pw.Text("Id  Nombre  Salario Minimo  Salario Maximo"))
    ];

    for (var i = 0; i < _jobPositions.length; i++) {
      JobPositions item = _jobPositions[i];
      var paragraph = pw.Paragraph(
          text:
              "${item.id}  ${item.name}  ${item.salaryMinLevel}  ${item.salaryMaxLevel}");

      widgets.add(paragraph);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return widgets;
        },
      ),
    );
  }

  Future _savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text("Gestión de Posiciones de trabajo"),
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22),
            backgroundColor: Colors.blue,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateJobPositionsScreen(),
                    ),
                  );
                },
                label: 'Crear',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blue,
                elevation: 10.0,
              ),
              SpeedDialChild(
                child: Icon(Icons.save),
                backgroundColor: Colors.blue,
                onTap: () async {
                  _writeOnPdf();
                  await _savePdf();
                  Directory documentDirectory =
                      await getApplicationDocumentsDirectory();

                  String documentPath = documentDirectory.path;
                  String path = "$documentPath/example.pdf";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerScreen(
                        path: path,
                      ),
                    ),
                  );
                },
                label: 'Exportar',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blue,
                elevation: 10.0,
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListViewJobPositions(),
        ),
      ),
    );
  }
}
