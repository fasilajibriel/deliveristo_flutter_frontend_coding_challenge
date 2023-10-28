import 'package:equatable/equatable.dart';

abstract class Faliure extends Equatable {
  final String message;
  final int statusCode;

  const Faliure({
    required this.message,
    this.statusCode = 500,
  });

  @override
  List<Object> get props => [message, statusCode];
}
