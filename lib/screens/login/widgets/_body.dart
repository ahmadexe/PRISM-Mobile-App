part of '../login.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final jobsBloc = BlocProvider.of<JobsBloc>(context);
    final notisBloc = BlocProvider.of<NotificationsBloc>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                AppTextField(
                  name: _FormKeys.password,
                  hint: 'Enter password',
                  isPass: true,
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(Icons.lock),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6)
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppRoutes.forgotPassword.push(context);
                      },
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
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.login is AuthLoginFailure) {
                      SnackBars.failure(
                        context,
                        "Looks like you've entered an incorrect email or password. Please try again.",
                      );
                    }
                    if (state.login is AuthLoginSuccess) {
                      final user = state.user!;
                      authBloc.add(UpdateDeviceToken(userId: user.id));

                      final postBloc = BlocProvider.of<PostsBloc>(context);
                      postBloc.add(const PostsFetchEvent());

                      if (user.isBusinessAcc) {
                        jobsBloc.add(FetchMyJobs(userId: user.id));
                      } else if (user.isServiceProvider) {
                        jobsBloc.add(const FetchJobs());
                        jobsBloc
                            .add(FetchApplications(id: user.id, isUser: true));
                      }

                      notisBloc.add(FetchNotifications(uid: user.uid));

                      AppRoutes.generateWallet.pushReplace(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.login is AuthLoginLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AppButton(
                      label: 'Login',
                      onPressed: () {
                        final form = screenState.formKey.currentState;
                        final isValid = form!.saveAndValidate();
                        if (!isValid) return;

                        final email = form.value[_FormKeys.email] as String;
                        final password =
                            form.value[_FormKeys.password] as String;

                        authBloc
                            .add(AuthLogin(email: email, password: password));
                      },
                      buttonType: ButtonType.borderedSecondary,
                    );
                  },
                ),
                const AppDivider(
                  text: 'OR',
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRoutes.register.pushReplace(context);
                            },
                        ),
                      ],
                    ),
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
