import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/providers/media_provider.dart';
import 'package:prism/widgets/design/buttons/app_button.dart';

class PickImageModal extends StatelessWidget {
  const PickImageModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final mediaProvider = MediaProvider.s(context);

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
                  mediaProvider.removeMedia();
                  mediaProvider.pickMedia(
                      ImageSource.camera, MediaUsecase.profile);
                  ''.pop(context);
                },
                label: 'Camera',
              ),
            ),
            Space.y2!,
            AppButton(
              backgroundColor: AppTheme.c.accent,
              onPressed: () {
                mediaProvider.removeMedia();
                mediaProvider.pickMedia(
                    ImageSource.gallery, MediaUsecase.profile);
                ''.pop(context);
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
