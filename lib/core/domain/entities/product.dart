class Product {
  final String id;
  final String name;
  final String filename;

  Product({
    required this.id,
    required this.name,
    required this.filename,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      filename: map['filename'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'filename': filename,
    };
  }
}
