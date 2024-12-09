part of '../bloc.dart';

class BuyCoinsState extends Equatable {
  static bool match(ChainState a, ChainState b) => a.buy != b.buy;
  final String? message;

  const BuyCoinsState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class BuyCoinsDefault extends BuyCoinsState {
  const BuyCoinsDefault();
}

class BuyCoinsLoading extends BuyCoinsState {
  const BuyCoinsLoading();
}

class BuyCoinsSuccess extends BuyCoinsState {
  const BuyCoinsSuccess();
}

class BuyCoinsFailure extends BuyCoinsState {
  const BuyCoinsFailure({
    required String message,
  }) : super(message: message);
}
