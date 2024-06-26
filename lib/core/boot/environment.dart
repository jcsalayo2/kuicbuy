import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  String generativeAIKey = '';

  static Environment _instance = Environment._internal();

  static Environment get instance => _instance;

  Environment._internal({
    this.generativeAIKey = '',
  });

  static Future<void> initialize({String filename = '.env'}) async {
    await dotenv.load(fileName: filename);

    final generativeAIKey = _getString('GENERATIVE_LANGUAGE_API_KEY');

    _instance = Environment._internal(
      generativeAIKey: generativeAIKey,
    );
  }

  // Uncomment if need to read int in ENV
  // static int _getInt(String key) {
  //   if (_getString(key).isEmpty) {
  //     return 0;
  //   }

  //   return int.tryParse(_getString(key)) ?? 0;
  // }

  static String _getString(String key) {
    if (!dotenv.env.containsKey(key)) {
      return '';
    }

    return dotenv.env[key] as String;
  }
}
