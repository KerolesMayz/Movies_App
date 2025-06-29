// import 'package:flutter/cupertino.dart';
// import 'package:movies/data/api_services/api_services.dart';
// import 'package:movies/data/models/register_response/Register_response.dart';
// import '../data/result/result.dart';
//
// class RegisterProvider extends ChangeNotifier {
//   // void emit(RegisterState newState) {
//   //   registerState = newState;
//   //   ChangeNotifier;
//   // }
//
//   Future<void> registerUser({
//     required String name,
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String phoneNumber,
//     required int avatarId,
//     required BuildContext context,
//   }) async {
//     Result<RegisterResponse> response = await ApiServices.registerUserApi(
//       name: name,
//       email: email,
//       password: password,
//       confirmPassword: confirmPassword,
//       phoneNumber: phoneNumber,
//       avatarId: avatarId,
//     );
//   }
// }
//
// sealed class RegisterState {}
//
// class RegisterSuccessState extends RegisterState {}
//
// class RegisterLoadingState extends RegisterState {
//   String? loadingMsg;
//
//   RegisterLoadingState({this.loadingMsg});
// }
//
// class RegisterErrorState extends RegisterState {
//   ServerError? serverError;
//   Exception? exception;
//
//   RegisterErrorState({this.serverError, this.exception});
// }
