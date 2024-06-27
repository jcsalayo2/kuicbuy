import 'package:kuicbuy/core/boot/environment.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GenerativeAIService {
  Future<String> getIntro({required String name}) async {
    var model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: Environment.instance.generativeAIKey,
    );

    final content = [
      Content.text(
          'Write a short welcome message for "$name" for logging in in my app KuicBuy. an ECommerce app')
    ];
    final response = await model.generateContent(content);
    print(response.text);

    return response.text ?? 'Nothing';
  }
}
