import 'package:flutter/material.dart';
import 'package:main_draft/learning/elements.dart';
import 'package:main_draft/learning/libraryhelper.dart';
class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final List<Elements> _elements=[
    Elements(name:"Aberracy"),
    Elements(name:"AIVR"),
    Elements(name:"Arrythmia"),
    Elements(name:"Ashman's Phenomenon"),
    Elements(name:"Atrial"),
    Elements(name:"AV Block"),
    Elements(name:"AVNRT"),
    Elements(name:"AVRT"),
    Elements(name:"Axis"),
    Elements(name:"Bigeminy"),
    Elements(name:"Biphasic"),
    Elements(name:"Bipolar Pacing"),
    Elements(name:"Brugada Syndrome"),
    Elements(name:"Bundle Branch Block"),
    Elements(name:"Compensatory Pause"),
    Elements(name:"Complete Heart Block"),
    Elements(name:"Concordance"),
    Elements(name:"Cornell Criteria"),
    Elements(name:"Couplet"),
    Elements(name:"Delta Wave"),
    Elements(name:"Dextrocardia"),
    Elements(name:"Digoxin"),
    Elements(name:"Ectopic"),
    Elements(name:"ECG"),
    Elements(name:"Electrode"),
    Elements(name:"Epsilon Waves"),
    Elements(name:"Fascicular Blocks"),
    Elements(name:"FUsion Beats"),
    Elements(name:"Hemiblocks"),
    Elements(name:"Hypercalcemia"),
    Elements(name:"Hyperkalemia"),
    Elements(name:"Hypermagnesemia"),
    Elements(name:"Hypernatremia"),
    Elements(name:"Hypertrophy"),
    Elements(name:"Hypocalcemia"),
    Elements(name:"Hypokalemia"),
    Elements(name:"Hypomagnesemia"),
    Elements(name:"Hyponatremia"),
    Elements(name:"ILBBB"),
    Elements(name:"IRBBB"),
    Elements(name:"ICDs"),
    Elements(name:"Isoelectric"),
    Elements(name:"Junctional"),
    Elements(name:"LAFB"),
    Elements(name:"LAHB"),
    Elements(name:"LBBB"),
    Elements(name:"LPFB"),
    Elements(name:"LPHB"),
    Elements(name:"Monomorphic"),
    Elements(name:"Monophasic"),
    Elements(name:"NADIR"),
    Elements(name:"Noncompensatory Pause"),
    Elements(name:"Osborn Waves"),
    Elements(name:"Pacemaker"),
    Elements(name:"Pericarditis"),
    Elements(name:"PRWP"),
    Elements(name:"Preexcitation"),
    Elements(name:"PACs"),
    Elements(name:"Pseudofusion Beat"),
    Elements(name:"Pulmonary"),
    Elements(name:"PVCs"),
    Elements(name:"QRS"),
    Elements(name:"Rhythm"),
    Elements(name:"RVH"),
    Elements(name:"Sinus"),
    Elements(name:"Sinus Block"),
    Elements(name:"Sinus Node"),
    Elements(name:"Trigeminy"),
    Elements(name:"Triphasic"),
    Elements(name:"Ventricular"),
    Elements(name:"Waveforms"),


  ];
  late List<Elements> _allelements;
  @override
  void initState(){
    _allelements= _elements;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        backgroundColor: Colors.red,
      ),
      body:Padding(
        padding:EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children:[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,10),
              child:TextField(
                decoration: const InputDecoration(
                  hintText: "Search for a term",
                  border:OutlineInputBorder()
                ),
                onChanged: (String input){
                  _allelements=[];
                  for(Elements element in _elements){
                    if (element.name.toLowerCase().contains(input.toLowerCase())){
                      _allelements.add(element);
                    }

                  }
                  setState(() {});
                },

              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 80
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  itemCount: _allelements.length,
                  itemBuilder: (BuildContext context, int index){
                    return LibraryHelper(element: _allelements[index],);
                  }
              ),
            ),
          ]
        )

      )
    );
  }
}
