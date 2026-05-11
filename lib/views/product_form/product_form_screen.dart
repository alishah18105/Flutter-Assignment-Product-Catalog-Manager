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
        backgroundColor: AppColors.screenBackground,
        title: Text(
          _isEditing ? "Edit Product" : "Add Product",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: AppColors.fabBackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "CATALOG MANAGEMENT",
                    style: TextStyle(fontSize: 15, color: AppColors.tileTitle),
                  ),
                  Text(
                    _isEditing ? "Modify Product" : "Define New Product",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Card(
                elevation: 5,
                color: AppColors.whiteColor,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Name",
                              style: TextStyle(
                                color: AppColors.fabBackground,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _nameCtrl,
                              decoration: InputDecoration(
                                filled: true,
        
                                fillColor: AppColors.textFieldBackground,
                                hint: Text(
                                  "eg: Enterprise Cloud Module",
                                  style: TextStyle(color: AppColors.hintText),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Price",
                              style: TextStyle(
                                color: AppColors.fabBackground,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _priceCtrl,
                              keyboardType: TextInputType.number,
        
                              decoration: InputDecoration(
                                hint: Text(
                                  "0.00",
                                  style: TextStyle(color: AppColors.hintText),
                                ),
                                label: Text("Price"),
                                filled: true,
                                fillColor: AppColors.textFieldBackground,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.monetization_on_outlined),
                              ),
                            ),
                            SizedBox(height: 30),
        
                            if (!_isEditing)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.textFieldBackground,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.info_outline,
                                      color: AppColors.fabBackground,
                                    ),
        
                                    const SizedBox(width: 12),
        
                                    Expanded(
                                      child: Text(
                                        "Ensure product pricing aligns with current regional tax regulations and platform fees.",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.hintText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.fabBackground,
                          padding: EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 15,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: AppColors.whiteColor),
                            Text(
                              _isEditing ? "Save Changes" : "Save Product",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF8F8F8),
                          padding: EdgeInsets.symmetric(
                            horizontal: 65,
                            vertical: 15,
                          ),
                        ),
                        child: Text("Cancel",style: TextStyle(
                          color: AppColors.fabBackground,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),)
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
