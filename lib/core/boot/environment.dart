import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  String generativeAIKey = '';
  String algoliaApplicationID = '';
  String algoliaApiKey = '';
  String algoliaIndexName = '';

  static Environment _instance = Environment._internal();

  static Environment get instance => _instance;

  Environment._internal({
    this.generativeAIKey = '',
    this.algoliaApplicationID = '',
    this.algoliaApiKey = '',
    this.algoliaIndexName = '',
  });

  static Future<void> initialize({String filename = 'dotenv'}) async {
    await dotenv.load(fileName: filename);

    final generativeAIKey = _getString('GENERATIVE_LANGUAGE_API_KEY');
    final algoliaApplicationID = _getString('ALGOLIA_APPLICATION_ID');
    final algoliaApiKey = _getString('ALGOLIA_API_KEY');
    final algoliaIndexName = _getString('ALGOLIA_INDEX_NAME');

    _instance = Environment._internal(
      generativeAIKey: generativeAIKey,
      algoliaApplicationID: algoliaApplicationID,
      algoliaApiKey: algoliaApiKey,
      algoliaIndexName: algoliaIndexName,
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
