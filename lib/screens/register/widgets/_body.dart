part of '../register.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final authBloc = BlocProvider.of<AuthBloc>(context);

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
                Text("Let's get started", style: AppText.h1b),
                Space.y!,
                Text(
                  'Please enter the following information',
                  style: AppText.b1,
                ),
                Space.yf(35),
                AppTextField(
                  name: _FormKeys.name,
                  hint: 'Enter name',
                  textCapitalization: TextCapitalization.sentences,
                  prefixIcon: const Icon(Icons.person),
                  validator: FormBuilderValidators.required(),
                ),
                Space.y2!,
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue fruitTextEditingValue) {
                    if (fruitTextEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }

                    return AppConstants.kUserDomains.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(fruitTextEditingValue.text.toLowerCase());
                    });
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        child: SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final option = options.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  onSelected(option);
                                },
                                child: ListTile(
                                  title: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return AppTextField(
                      controller: textEditingController,
                      node: focusNode,
                      name: _FormKeys.domain,
                      prefixIcon: const Icon(Icons.dynamic_feed_sharp),
                      hint: 'Enter domain e.g. Technology',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Domain cannot be empty',
                        ),
                        (value) {
                          if (value != null) {
                            if (!AppConstants.kUserDomains.contains(value)) {
                              return "Please select a valid domain";
                            }
                            return null;
                          } else {
                            return "Please select a valid domain";
                          }
                        }
                      ]),
                      textInputType: TextInputType.text,
                    );
                  },
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
                AppTextField(
                  name: _FormKeys.password,
                  hint: 'Enter password',
                  isPass: true,
                  textCapitalization: TextCapitalization.none,
                  prefixIcon: const Icon(Icons.lock),
                  validator: FormBuilderValidators.required(),
                ),
                const Spacer(),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state.register is AuthRegisterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AppButton(
                      label: 'Register',
                      onPressed: () {
                        final isValid =
                            screenState.formKey.currentState!.saveAndValidate();
                        if (!isValid) return;

                        final formData =
                            screenState.formKey.currentState!.value;
                        final email = formData[_FormKeys.email] as String;
                        final password = formData[_FormKeys.password] as String;
                        final name = formData[_FormKeys.name] as String;
                        final domain = formData[_FormKeys.domain] as String;
                        final Map<String, dynamic> payload = {
                          'fullname': name,
                          'domain': domain,
                        };

                        authBloc.add(
                          AuthRegister(
                            email: email,
                            password: password,
                            payload: payload,
                          ),
                        );
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
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: AppText.b2!.cl(
                          AppTheme.c.white!.withOpacity(0.5),
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        style: AppText.b2!.cl(
                          AppTheme.c.white!,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppRoutes.login.pushReplace(context);
                          },
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
