import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  //outputing meal item data.

  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });
  final Meal meal;
  final void Function(Meal meal, BuildContext context) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name
            .substring(1); // name gives access to enum value as a string.
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name
            .substring(1); // name gives access to enum value as a string.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior:
          Clip.hardEdge, // will cut off the things going out of the shape.
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal, context);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                // the iamage loaded will be faded.
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, // CUTS OFF THE TEXT WITH THREE DOTS
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label:
                                '${meal.duration}min'), //label: meal.duration.toString(),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.money, label: affordabilityText),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
