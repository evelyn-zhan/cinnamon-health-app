class IngredientModel {

  IngredientModel({
    required this.name,
    required this.quantity,
    this.unit
  });

  String name, quantity;
  String? unit;
}