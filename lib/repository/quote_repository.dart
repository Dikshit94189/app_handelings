import 'package:new_tasks/models/home_images.dart';
import 'package:new_tasks/models/quote_response.dart';
import 'package:new_tasks/network/api_client.dart';

class QuoteRepository {
  final ApiClient _apiClient = ApiClient();

  Future<QuoteModel> fetchRandomQuote() async {
    final response = await _apiClient.get(
      'https://dummyjson.com/quotes/random',
    );
    return QuoteModel.fromJson(response);
  }

  /// *****************   Home Images  Api   *************************  ///////////

  Future<List<RandomImages>> fetchImages() async {
    final response = await _apiClient.get(
      // 'https://api.thecatapi.com/v1/images/search',
      // 'https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg,png',
      // 'https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg,png&size=small',
        'https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg,png&size=small'

    );

    return (response as List).map((e) => RandomImages.fromJson(e)).toList();
  }
}
