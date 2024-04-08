part of '../edit_profile.dart';

class _ImageModal extends StatelessWidget {
  final _ScreenState screenState;
  final bool isBanner;
  const _ImageModal({
    Key? key,
    this.isBanner = false,
    required this.screenState,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Container(
      width: double.infinity,
      height: media.height * .3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppTheme.c.fieldLight,
      ),
      child: Padding(
        padding: Space.all(15, 7),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppTheme.c.textGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Space.y2!,
            Center(
              child: Text(
                'Select Image',
                style: AppText.h2b,
              ),
            ),
            Center(
              child: Text(
                "Let's get your pictures set up!",
                style: AppText.l1,
              ),
            ),
            Space.ym!,
            Center(
              child: AppButton(
                onPressed: () {
                  if (isBanner) {
                    screenState.pickBannerImage(ImageSource.camera);
                    return;
                  }
                  screenState.pickProfileImage(ImageSource.camera);
                },
                label: 'Camera',
              ),
            ),
            Space.y2!,
            AppButton(
              backgroundColor: AppTheme.c.accent,
              onPressed: () {
                if (isBanner) {
                  screenState.pickBannerImage(ImageSource.gallery);
                  return;
                }
                screenState.pickProfileImage(ImageSource.gallery);
              },
              label: 'Gallery',
            ),
            Space.y2!,
          ],
        ),
      ),
    );
  }
}
