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
        // "https://jsonplaceholder.typicode.com/photos"
        "https://picsum.photos/v2/list?page=1&limit=20"
    );

    return (response as List).map((e) => RandomImages.fromJson(e)).toList();
  }
}
