class CreateProductReviewModel {
  final String? description;
  final int? productId;
  final String? rating;

  CreateProductReviewModel({this.description, this.productId, this.rating});

  Map<String, dynamic> toJson() {
    return{
      'description': description,
      'product_id': productId.toString(),
      'rating': rating,
    };
  }
}