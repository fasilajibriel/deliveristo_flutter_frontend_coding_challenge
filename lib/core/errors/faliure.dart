import 'package:equatable/equatable.dart';

abstract class Faliure extends Equatable {
  final String message;
  final int statusCode;

  const Faliure({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}
