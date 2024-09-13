part of '../create_job.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);
    final lensBloc = BlocProvider.of<LensBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post a Job'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: FormBuilder(
            key: screenState.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: AppText.b1bm,
                  ),
                  Space.y!,
                  AppTextField(
                    name: _FormKeys.jobTitle,
                    hint: 'Title',
                    isDarkField: true,
                    validator: FormBuilderValidators.required(),
                  ),
                  Space.y!,
                  AppTextField(
                    name: _FormKeys.jobDescription,
                    hint: 'Describe the role...',
                    maxLines: 100,
                    minLines: 10,
                    isDarkField: true,
                    validator: FormBuilderValidators.required(),
                  ),
                  Space.y2!,
                  Text(
                    'Budget',
                    style: AppText.b1bm,
                  ),
                  Space.y!,
                  AppTextField(
                    name: _FormKeys.jobBudget,
                    hint: 'Budget',
                    isDarkField: true,
                    validator: FormBuilderValidators.required(),
                  ),
                  Space.y!,
                  FormBuilderDropdown(
                    name: _FormKeys.jobBudgetMeta,
                    dropdownColor: AppTheme.c.fieldLight,
                    items: paymentTypes
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: AppText.b2!.cl(AppTheme.c.white!)),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppTheme.c.fieldDark,
                      hintText: 'When will you pay?',
                      hintStyle: AppText.b2!.cl(AppTheme.c.textGrey!),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppTheme.c.grey!,
                          width: AppDimensions.normalize(.5),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red.withAlpha(200),
                          width: AppDimensions.normalize(0.5),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red.withAlpha(200),
                          width: AppDimensions.normalize(0.5),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: AppDimensions.normalize(0.75),
                          color: AppTheme.c.textLight!.withAlpha(100),
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  Space.y2!,
                  Text(
                    'Select your country',
                    style: AppText.b1bm,
                  ),
                  Space.y!,
                  AppTextField(
                    name: _FormKeys.country,
                    hint: 'Select a country',
                    isDarkField: true,
                    onTap: () =>
                        _buildCountryPicker(context, screenState.formKey),
                    validator: FormBuilderValidators.required(),
                  ),
                  Space.yf(40),
                  AppButton(
                    label: 'Next',
                    onPressed: () {
                      final form = screenState.formKey.currentState!;
                      final isValid = form.saveAndValidate();
                      if (!isValid) return;

                      lensBloc.add(
                        ExtractKeywords(
                          inputText:
                              form.value[_FormKeys.jobDescription] as String,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _buildCountryPicker(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: AppTheme.c.fieldDark,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: MediaQuery.of(context).size.height * .80,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.c.fieldLight,
          hintText: 'Select your contry?',
          hintStyle: AppText.b2!.cl(AppTheme.c.textGrey!),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppTheme.c.grey!,
              width: AppDimensions.normalize(.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red.withAlpha(200),
              width: AppDimensions.normalize(0.5),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red.withAlpha(200),
              width: AppDimensions.normalize(0.5),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: AppTheme.c.textLight!.withAlpha(100),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        formKey.currentState!.fields[_FormKeys.country]!
            .didChange(country.name);
      },
    );
  }
}
