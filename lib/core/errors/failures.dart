
import 'package:dio/dio.dart';
import 'dart:io';

abstract class Failure {
  final String errMessge;

  const Failure(this.errMessge);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessge);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');
      case DioExceptionType.badResponse:
        print('🔴 Error at ${dioException.requestOptions.path}');
        print('🔴 Status Code: ${dioException.response?.statusCode}');
        print('🔴 Response Data: ${dioException.response?.data}');
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection error with ApiServer');
      case DioExceptionType.unknown:
        if (dioException.error is SocketException) {
          return ServerFailure('No Internet Connection');
        } else {
          return ServerFailure('Unexpected error occurred');
        }
      default:
        return ServerFailure('Oops! There was an Error, please try later');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    String extractMessage(dynamic response) {
      if (response is Map) {
        if (response.containsKey('error')) {
          return response['error'] is Map
              ? response['error']['message'] ?? 'Unknown error'
              : response['error'];
        }
        if (response.containsKey('message')) {
          return response['message'];
        }
        if (response.containsKey('errors')) {
          final errors = response['errors'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first;
          } else if (errors is Map && errors.isNotEmpty) {
            final firstKey = errors.keys.first;
            final messages = errors[firstKey];
            if (messages is List && messages.isNotEmpty) {
              return messages.first;
            }
          }
        }
      }
      return 'Unknown error';
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(extractMessage(response));
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, please try later');
    } else {
      return ServerFailure('Oops! There was an error, please try later');
    }
  }
}
