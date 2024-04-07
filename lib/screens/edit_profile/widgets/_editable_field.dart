part of '../edit_profile.dart';

class _EditableField extends StatelessWidget {
  final String name;
  final String value;
  final String hint;
  const _EditableField(
      {required this.hint, required this.name, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: _FormKeys.name,
      initialValue: value,
      cursorColor: Colors.white,
      validator: FormBuilderValidators.required(),
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
