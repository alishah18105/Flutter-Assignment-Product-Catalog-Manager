import 'package:flutter/material.dart';
import 'package:provicer_api_project/core/theme/app_themes.dart';
import 'package:provicer_api_project/models/product.dart';
import 'package:provicer_api_project/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Products? product;
  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  bool _isSaving = false;
  bool get _isEditing => widget.product != null;
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final item = Products(
      id: widget.product?.id,
      name: _nameCtrl.text,
      price: double.parse(_priceCtrl.text),
    );

    if (_isEditing) {
      await context.read<ProductsProvider>().updateProduct(item);
    } else {
      await context.read<ProductsProvider>().createProduct(item);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.product?.name ?? '');

    _priceCtrl = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(
          _isEditing ? "Edit Product" : "Add Product",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: AppColors.screenTitle,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Card(
          elevation: 5,
          color: AppColors.lavenderTile,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  _isEditing
                      ? "Update Existing Product"
                      : "Create New Product",
                  style: TextStyle(
                    color: AppColors.alternateTitle,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: AppColors.alternateTitle, thickness: 5),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: InputDecoration(
                          label: Text("Name"),
                          filled: true,
                          fillColor: AppColors.textFieldBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.textFieldBorder,
                            ),
                          ),
                          prefixIcon: Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text("Price"),
                          filled: true,
                          fillColor: AppColors.textFieldBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.textFieldBorder,
                            ),
                          ),
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  ),
                  child: Text(
                    _isEditing ? "Save Changes" : "Save Product",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
