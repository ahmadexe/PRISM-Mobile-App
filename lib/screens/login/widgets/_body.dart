part of '../login.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: Space.all(),
          child: FormBuilder(
            key: screenState.formKey,
            initialValue: _FormData.initialValues(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppStaticData.logoSvg,
                  height: AppDimensions.normalize(45),
                  width: AppDimensions.normalize(45),
                ),
                Space.yf(70),
                Text('Welcome back', style: AppText.h1b),
                Space.y!,
                Text(
                  'Please enter the following information',
                  style: AppText.b1,
                ),
                Space.yf(35),
                AppTextField(
                  name: 'email',
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
                AppTextField(
                  name: 'password',
                  hint: 'Enter password',
                  isPass: true,
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(Icons.lock),
                  validator: FormBuilderValidators.required(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: AppText.b2!.cl(
                          AppTheme.c.white!.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  label: 'Login',
                  onPressed: () {
                    final form = screenState.formKey.currentState!;
                    if (!form.saveAndValidate()) return;
                    print(form.value);
                  },
                  buttonType: ButtonType.borderedSecondary,
                ),
                const AppDivider(
                  text: 'OR',
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: AppText.b2!.cl(
                          AppTheme.c.white!.withOpacity(0.5),
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: AppText.b2!.cl(
                          AppTheme.c.white!,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
