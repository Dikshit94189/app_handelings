import 'package:flutter/cupertino.dart';
import 'package:new_tasks/models/quote_response.dart';
import 'package:new_tasks/repository/quote_repository.dart';
import 'package:new_tasks/utils/api_response.dart';

import '../models/home_images.dart';

class QuoteViewModel extends ChangeNotifier {
  final QuoteRepository _repository = QuoteRepository();

  ApiResponse<QuoteModel> quoteResponse = ApiResponse.loading();
  Future<void> getRandomQuote() async {
    quoteResponse = ApiResponse.loading();
    notifyListeners();
    try {
      final quote = await _repository.fetchRandomQuote();
      quoteResponse = ApiResponse.complete(quote);
    } catch (e) {
      quoteResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }


  /// *****************   Home Images  Api   *************************  ///////////

  ApiResponse<RandomImages> imagesResponse = ApiResponse.loading();
  Future<void> getRandomImages() async {
    quoteResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final images = await _repository.fetchImages();
      imagesResponse = ApiResponse.complete(images);
    } catch (e) {
      imagesResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }


}
