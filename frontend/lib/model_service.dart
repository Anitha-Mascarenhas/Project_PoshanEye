import 'package:tflite_flutter/tflite_flutter.dart';

class ModelService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('model.tflite');
    print("Model loaded");
  }

  List<double> predict(double weight, double height, double age) {
    // Input shape [1,3]
    var input = [
      [weight, height, age],
    ];

    var output = List.filled(3, 0.0).reshape([1, 3]);

    _interpreter.run(input, output);

    return output[0];
  }
}
