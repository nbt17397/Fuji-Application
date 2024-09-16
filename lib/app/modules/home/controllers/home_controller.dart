import 'dart:convert';

import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../data/response/product.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class HomeController extends GetxController {
  // hold data coming from api
  List<dynamic>? data;
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  var products = <Product>[].obs;

  // getting data from api
  getData() async {
    final basicAuth = 'Basic ' + base64Encode(utf8.encode('${Constants.ckUsername}:${Constants.csPassword}'));
    // *) perform api call
    await BaseClient.safeApiCall(
      Constants.productsApiUrl, // url
      RequestType.get, // request type (get,post,delete,put)
      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response){ // api done successfully
        data = List.from(response.data);
        products.value = data!.map((item) => Product.fromJson(item)).toList();
        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error){
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
      headers: {
        'Authorization': basicAuth
      }
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
