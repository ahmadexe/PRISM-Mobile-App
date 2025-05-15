part of '../bloc.dart';

class ServiceProviderToggleState extends Equatable {
  static bool match(AuthState a, AuthState b) =>
      a.serviceProvider != b.serviceProvider;

  final String? message;

  const ServiceProviderToggleState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ServiceProviderToggleDefault extends ServiceProviderToggleState {
  const ServiceProviderToggleDefault();
}

class ServiceProviderToggleLoading extends ServiceProviderToggleState {
  const ServiceProviderToggleLoading();
}

class ServiceProviderToggleSuccess extends ServiceProviderToggleState {
  const ServiceProviderToggleSuccess();
}

class ServiceProviderToggleFailure extends ServiceProviderToggleState {
  const ServiceProviderToggleFailure({
    required String message,
  }) : super(message: message);
}
