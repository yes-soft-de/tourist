import 'package:inject/inject.dart';
import 'package:tourists/module_comment/repository/rating/rating_repository.dart';
import 'package:tourists/module_comment/request/create_rating/create_rating.dart';

@provide
class RatingManager {
  final RatingRepository _ratingRepository;

  RatingManager(this._ratingRepository);

  Future<dynamic> createRating(CreateRatingRequest request) {
    return this._ratingRepository.postRating(request);
  }
}