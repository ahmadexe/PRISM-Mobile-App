part of '../forgot_password.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Forgot Password'),
          centerTitle: true,
          scrolledUnderElevation: 0,
          actions: [
            SvgPicture.asset(
              AppStaticData.logoSvg,
              height: AppDimensions.normalize(20),
              width: AppDimensions.normalize(20),
            ),
          ],
        ),
        body: Padding(
          padding: Space.all(),
          child: FormBuilder(
            key: screenState.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.y2!,
                Center(
                  child: Lottie.asset(
                    AppStaticData.forgotPassAnimation,
                    height: AppDimensions.normalize(140),
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover,
                  ),
                ),
                Space.yf(65),
                Text(
                  'Forgot Password?',
                  style: AppText.h1b,
                ),
                Space.y!,
                Text(
                  "Don't worry, we got you covered!",
                  style: AppText.b1,
                ),
                Space.y2!,
                AppTextField(
                  name: _FormKeys.email,
                  hint: 'Enter email address',
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(Icons.mail),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ],
                  ),
                ),
                Space.y2!,
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.forgot is ForgotPasswordSuccess) {
                      SnackBars.success(
                        context,
                        "We've sent you an email to reset your password!",
                      );
                    } else if (state.forgot is ForgotPasswordFailure) {
                      SnackBars.failure(
                        context,
                        "Failed to send email! Please try again.",
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.forgot is ForgotPasswordLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return AppButton(
                      onPressed: () {
                        final form = screenState.formKey.currentState!;
                        final isValid = form.saveAndValidate();
                        if (!isValid) return;

                        final email = form.value[_FormKeys.email] as String;
                        authBloc.add(ForgotPassword(email: email));
                      },
                      label: 'Send Email',
                      buttonType: ButtonType.secondary,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
