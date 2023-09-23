import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

//this provider class wil create a object which we can then listen to inside our widgets.
final mealsProvider = Provider((ref) {
  return dummyMeals; // works for static dummy data.
});
