part of '../edit_profile.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
    final screenState = _ScreenState.s(context, true);

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.update is AuthUpdateSuccess) {
              SnackBars.success(context, 'Profile updated successfully.');
            }
            if (state.update is AuthUpdateFailure) {
              SnackBars.failure(
                  context, 'Failed to update profile, try again later.');
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                FormBuilder(
                  key: screenState.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            if (screenState.bannerImage != null)
                              Image.file(
                                File(screenState.bannerImage!.path),
                                height: AppDimensions.normalize(65),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            else
                              user.bannerImageUrl == null
                                  ? Image.asset(
                                      AppStaticData.bannerDef,
                                      height: AppDimensions.normalize(65),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: user.bannerImageUrl!,
                                      height: AppDimensions.normalize(65),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            Container(
                              height: AppDimensions.normalize(65),
                              width: double.infinity,
                              color: Colors.black.withOpacity(.5),
                            ),
                            Positioned(
                              top: AppDimensions.normalize(28),
                              bottom: AppDimensions.normalize(20),
                              left: AppDimensions.normalize(50),
                              right: AppDimensions.normalize(50),
                              child: GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (_) => _ImageModal(
                                    screenState: screenState,
                                    isBanner: true,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit Banner Image',
                                      style: AppText.b1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Space.y2!,
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => _ImageModal(
                              screenState: screenState,
                            ),
                          ),
                          child: Stack(
                            children: [
                              if (screenState.profileImage != null)
                                Center(
                                  child: CircleAvatar(
                                    radius: AppDimensions.normalize(17),
                                    backgroundImage: FileImage(
                                      File(screenState.profileImage!.path),
                                    ),
                                  ),
                                )
                              else
                                user.imageUrl != null
                                    ? Center(
                                        child: CircleAvatar(
                                            radius: AppDimensions.normalize(17),
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              user.imageUrl!,
                                            )),
                                      )
                                    : Center(
                                        child: CircleAvatar(
                                          radius: AppDimensions.normalize(17),
                                          backgroundImage: const AssetImage(
                                            AppStaticData.dpDef,
                                          ),
                                        ),
                                      ),
                              Center(
                                child: CircleAvatar(
                                  radius: AppDimensions.normalize(17),
                                  backgroundColor: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Space.y2!,
                        Center(
                          child: Text(
                            'Edit Profile',
                            style: AppText.h2b,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Let's make your profile look better!",
                            style: AppText.l1,
                          ),
                        ),
                        Padding(
                          padding: Space.all(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name', style: AppText.l1b),
                              Space.y1!,
                              AppTextField(
                                name: _FormKeys.name,
                                hint: 'Name',
                                initialValue: user.fullname,
                                isDarkField: true,
                                validator: FormBuilderValidators.required(),
                              ),
                              Space.y2!,
                              Text('Email', style: AppText.l1b),
                              Space.y1!,
                              AppTextField(
                                name: _FormKeys.email,
                                hint: 'Email',
                                initialValue: user.email,
                                isDarkField: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              Space.y2!,
                              Text('About me', style: AppText.l1b),
                              Space.y1!,
                              AppTextField(
                                name: _FormKeys.bio,
                                hint: 'Bio',
                                initialValue: user.bio,
                                isDarkField: true,
                                maxLines: 4,
                                validator: FormBuilderValidators.required(),
                              ),
                              Space.yf(40),
                              AppButton(
                                label: 'Update Profile',
                                onPressed: () {
                                  final form =
                                      screenState.formKey.currentState!;
                                  final isValid = form.saveAndValidate();
                                  if (!isValid) return;

                                  final data = form.value;
                                  final updatedUser = user.copyWith(
                                    fullname: data[_FormKeys.name],
                                    email: data[_FormKeys.email],
                                    bio: data[_FormKeys.bio],
                                  );

                                  authBloc.add(
                                    AuthUpdate(
                                      userData: updatedUser,
                                      bannerImage: screenState.bannerImage,
                                      profileImage: screenState.profileImage,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.update is AuthUpdateLoading) const FullScreenLoader(),
              ],
            );
          },
        ),
      ),
    );
  }
}
