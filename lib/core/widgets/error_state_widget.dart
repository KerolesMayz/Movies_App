import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/result/result.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({super.key, this.serverError, this.exception});

  final ServerError? serverError;
  final Exception? exception;

  String extractErrorMessage() {
    String message = 'Error';
    if (serverError != null) {
      message = serverError!.message;
    } else {
      if ((exception as Exception) is SocketException) {
        message = 'No Internet Connection';
      } else if ((exception as Exception) is HttpException) {
        message = 'Could not find the post';
      } else if ((exception as Exception) is FormatException) {
        message = 'Bad response format';
      }
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        extractErrorMessage(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
