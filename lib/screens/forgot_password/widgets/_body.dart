part of '../forgot_password.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Forgot Password'),
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
            initialValue: _FormData.initialValues(),
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
                AppButton(
                  onPressed: () {},
                  label: 'Send Email',
                  buttonType: ButtonType.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
