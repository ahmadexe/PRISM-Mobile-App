part of '../chatbot.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lens'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            children: [
              // const Expanded(child: _NoMessages()),
              Expanded(
                child: ListView.separated(
                  padding: Space.all(),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _MessageBubble(message: message);
                  },
                  separatorBuilder: (context, index) => Space.y2!,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Iconsax.export_1,
                      size: AppDimensions.normalize(7),
                      color: AppTheme.c.textGrey,
                    ),
                  ),
                  Space.x!,
                  Expanded(
                    child: FormBuilder(
                      key: screenState.formKey,
                      child: AppTextField(
                        name: _FormKeys.message,
                        hint: 'Message Lens',
                        type: FieldType.secondary,
                        isDarkField: true,
                        onChanged: (v) {
                          if (v != null && v.isNotEmpty) {
                            screenState.setWriting(true);
                          } else {
                            screenState.setWriting(false);
                          }
                        },
                      ),
                    ),
                  ),
                  Space.x!,
                  GestureDetector(
                    onTap: () {
                      if (!screenState.isWriting) return;
                      final form = screenState.formKey.currentState!;
                      form.save();
                      // final message = form.value[_FormKeys.message] as String;

                      form.reset();
                    },
                    child: Icon(
                      Iconsax.send_2,
                      size: AppDimensions.normalize(7),
                      color: screenState.isWriting
                          ? AppTheme.c.primary
                          : AppTheme.c.textGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
