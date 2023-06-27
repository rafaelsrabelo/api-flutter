import 'package:api/data/http/exceptions.dart';
import 'package:api/data/models/product_model.dart';
import 'package:api/data/repositories/product_repository.dart';
import 'package:flutter/widgets.dart';

class ProductStore {
  final IProductRepository repository;
  // variavel relativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // variavel relativa para o state
  final ValueNotifier<List<ProductModel>> state = ValueNotifier<List<ProductModel>>([]); 

  // variavel relative para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  ProductStore({required this.repository});

  getProducts()  async {
    isLoading.value = true;

    try {
      final result = await repository.getProducts();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message ;
    } catch(e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}