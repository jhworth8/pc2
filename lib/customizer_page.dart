import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cowbell_model.dart';

class CustomizerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CowbellModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Customizer'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Add customization widgets here
                ElevatedButton(
                  onPressed: () => model.saveCustomization(),
                  child: Text('Save Customization'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
