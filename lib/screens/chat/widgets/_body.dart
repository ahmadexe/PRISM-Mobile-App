part of '../chat.dart';

class _Body extends StatelessWidget {
  final String receiverName;
  final String receiverId;
  final String receiverPic;
  const _Body({
    Key? key,
    required this.receiverName,
    required this.receiverId,
    required this.receiverPic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              if (receiverPic.isNotEmpty) ...[
                Avatar(
                  imageUrl: receiverPic,
                  radius: AppDimensions.normalize(6),
                ),
                Space.x1!,
              ],
              Text(receiverName, style: AppText.h3b),
            ],
          ),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  reverse: true,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return _MessageTile(
                        message: messages[index % messages.length]);
                  },
                  separatorBuilder: (context, index) => Space.y2!,
                ),
              ),
              Space.y2!,
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
                    child: AppTextField(
                      name: _FormKeys.message,
                      hint: 'Message @$receiverName',
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
                  Space.x!,
                  Icon(
                    Iconsax.send_2,
                    size: AppDimensions.normalize(7),
                    color: screenState.isWriting
                        ? AppTheme.c.primary
                        : AppTheme.c.textGrey,
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
