import 'package:flutter/cupertino.dart';
import 'package:new_tasks/models/quote_response.dart';
import 'package:new_tasks/repository/quote_repository.dart';
import 'package:new_tasks/utils/api_response.dart';

class QuoteViewModel extends ChangeNotifier{
  final QuoteRepository _repository = QuoteRepository();

  ApiResponse<QuoteModel> quoteResponse = ApiResponse.loading();
  Future<void> getRandomQuote() async{
    quoteResponse = ApiResponse.loading();
    notifyListeners();

    try{
      final quote = await _repository.fetchRandomQuote();
      quoteResponse = ApiResponse.complete(quote);
    }catch(e){
      quoteResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

}