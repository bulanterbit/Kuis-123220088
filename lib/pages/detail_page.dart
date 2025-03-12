import 'package:flutter/material.dart';
import '../models/clothes_model.dart';

class DetailPage extends StatefulWidget {
  final ClothesModel clothes;

  const DetailPage({Key? key, required this.clothes}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.clothes.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Image.network(
                  widget.clothes.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.error)),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand instead of Location
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        widget.clothes.brand,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("kategori: ${widget.clothes.category}")
                        ],
                      ),
                      Row(
                        children: [
                          Text("Rating: ${widget.clothes.rating}/5.0")
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              "Harga: \$${widget.clothes.price.toStringAsFixed(2)}")
                        ],
                      ),
                    ],
                  ),

                  const Text(
                    'Ukuran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.clothes.sizes.map((size) {
                      return Chip(
                        label: Text(size),
                        backgroundColor: Colors.blue[100],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Warna',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.clothes.colors.map((color) {
                      return Chip(
                        label: Text(color),
                        backgroundColor: Colors.green[100],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add to cart instead of favorite
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Menambah ${widget.clothes.name} ke keranjang'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
