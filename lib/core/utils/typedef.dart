import 'package:dartz/dartz.dart';
import 'package:tdd_flutter_sample/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;