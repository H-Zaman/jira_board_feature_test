import 'package:dio/dio.dart';
import 'package:ordermanagement/src/merchant/controller/auth_controller.dart';
import 'package:ordermanagement/src/utilities/logger.dart';

import '_api.dart';

class Api{

  Api._();

  static final _dio = Dio();

  static const int _connectTimeout = 30000;
  static const int _receiveTimeout = 30000;

  static final Map<String, dynamic> _headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static final BaseOptions _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout
  );

  static Dio _baseClient([String? baseUrl]){
    _headers.update(
      'Authorization', (existingValue) => AuthController.get.token,
      ifAbsent: () => AuthController.get.token,
    );

    _dio.options = _options..headers = _headers;

    _dio.options = _options..baseUrl = baseUrl ?? Endpoints.baseUrl;

    return _dio;
  }

  static AResponse _processData(String route, Response apiResponse){

    /// checking status code
    /// making sure it request was a success
    if(apiResponse.statusCode! >= 200 || apiResponse.statusCode! < 300){

      /// logging result
      Log.i('------------DATA------------\n$route', apiResponse.data);

      String? authToken;
      if(apiResponse.data['response_data'] is Map && apiResponse.data['response_data'].containsKey('basicAuth')){
        authToken = apiResponse.data['response_data']['basicAuth'];
      }

      return AResponse(
        error: apiResponse.data['response_status'] != 1,
        message: apiResponse.data['response_message'],
        data: apiResponse.data['response_data'] == null ? apiResponse.data : apiResponse.data['response_data'],
        token: authToken
      );

    }else{
      /// logging result
      Log.e(route, apiResponse.statusMessage);
      return AResponse(
        error: true,
        message: apiResponse.data['response_message'],
      );
    }
  }

  static String _processErrorMessage(dynamic error){

    String errorMsg = '';

    if(error is DioError){
      if(error.type == DioErrorType.response){
        return error.error;
      }else if(error.response!.statusCode == 503){
        errorMsg += 'Server maintenance';
        return errorMsg;
      }else if(error.type == DioErrorType.connectTimeout){
        errorMsg += 'Request timed out';
      } else if(error.response!.statusCode! >= 400){
        try{
          errorMsg += error.response!.data['detail'];
        }catch(e){
          errorMsg += error.response!.toString();
        }
      }

      return errorMsg;
    }

    return error.toString();
  }

  static Future<AResponse> get(
    String endpoint,
    {
      Map<String, dynamic> queryParams = const {},
      String? baseUrl
    }
  )async{

    /// logging route and data
    final route  = 'GET $endpoint';
    Log.w(route, queryParams);

    try{

      /// adding the authorization token base to requirements
      final client = _baseClient(baseUrl);
      final apiResponse = await client.get(
        endpoint,
        queryParameters: queryParams
      );

      return _processData(route, apiResponse);

    }catch(e){
      final errorMsg = _processErrorMessage(e);
      Log.e(errorMsg, '**********$route FAILED**********');
      return AResponse(error: true,message: errorMsg);
    }
  }

  static Future<AResponse> post(
    String endpoint,
    {
      Map<String, dynamic>? queryParams,
      dynamic data,
      String? baseUrl
    }
  )async{

    /// logging route and data
    final route  = 'POST $endpoint';
    Log.w(route, queryParams ?? data);

    try{

      /// adding the authorization token base to requirements
      final client = _baseClient(baseUrl);

      final apiResponse = await client.post(
        endpoint,
        queryParameters: queryParams,
        data: data
      );

      return _processData(route, apiResponse);

    }catch(e){
      final errorMsg = _processErrorMessage(e);
      Log.e(errorMsg, '**********$route FAILED**********');
      return AResponse(error: true,message: errorMsg);
    }
  }

  static Future<AResponse> put(
    String endpoint,
    {
      Map<String, dynamic>? queryParams,
      Map<String, dynamic> data = const {},
      String? baseUrl
    }
  )async{

    /// logging route and data
    final route  = 'PUT $endpoint';
    Log.w(route, queryParams ?? data);

    try{

      /// adding the authorization token base to requirements
      final client = _baseClient(baseUrl);

      final apiResponse = await client.put(
          endpoint,
          queryParameters: queryParams,
          data: data
      );

      return _processData(route,apiResponse);

    }catch(e){
      final errorMsg = _processErrorMessage(e);
      Log.e(errorMsg, '**********$route FAILED**********');
      return AResponse(error: true,message: errorMsg);
    }
  }

  static Future<AResponse> patch(
    String endpoint,
    {
      Map<String, dynamic>? queryParams,
      Map<String, dynamic> data = const {},
      String? baseUrl
    }
  )async{

    /// logging route and data
    final route  = 'PATCH $endpoint';
    Log.w(route, queryParams ?? data);

    try{

      /// adding the authorization token base to requirements
      final client = _baseClient(baseUrl);

      final apiResponse = await client.patch(
        endpoint,
        queryParameters: queryParams,
        data: data
      );

      return _processData(route,apiResponse);

    }catch(e){
      final errorMsg = _processErrorMessage(e);
      Log.e(errorMsg, '**********$route FAILED**********');
      return AResponse(error: true,message: errorMsg);
    }
  }

  static Future<AResponse> delete(
    String endpoint,
    {
      Map<String, dynamic>? queryParams,
      Map<String, dynamic> data = const {},
      String? baseUrl
    }
  )async{

    /// logging route and data
    final route  = 'DELETE $endpoint';
    Log.w(route, queryParams ?? data);

    try{

      /// adding the authorization token base to requirements
      final client = _baseClient(baseUrl);

      final apiResponse = await client.delete(
        endpoint,
        queryParameters: queryParams,
        data: data
      );

      return _processData(route, apiResponse);

    }catch(e){
      final errorMsg = _processErrorMessage(e);
      Log.e(errorMsg, '**********$route FAILED**********');
      return AResponse(error: true,message: errorMsg);
    }
  }
}