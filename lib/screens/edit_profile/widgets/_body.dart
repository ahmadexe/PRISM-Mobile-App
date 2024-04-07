part of '../edit_profile.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.logout is AuthLogoutSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  user.bannerImageUrl == null
                      ? Image.asset(
                          AppStaticData.bannerDef,
                          height: AppDimensions.normalize(65),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          user.bannerImageUrl!,
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
                    top: 60,
                    bottom: 50,
                    left: 130,
                    right: 130,
                    child: GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (_) => const _ImageModal(),
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
                  )
                ],
              ),
              Space.y2!,
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => const _ImageModal(),
                ),
                child: Stack(
                  children: [
                    user.imageUrl != null
                        ? Center(
                            child: CircleAvatar(
                              radius: AppDimensions.normalize(17),
                              backgroundImage: NetworkImage(user.imageUrl!),
                            ),
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
                      validator: FormBuilderValidators.required(),
                      isDarkField: true,
                    ),
                    Space.y2!,
                    Text('Email', style: AppText.l1b),
                    Space.y1!,
                    AppTextField(
                      name: _FormKeys.email,
                      hint: 'Email',
                      initialValue: user.email,
                      validator: FormBuilderValidators.required(),
                      isDarkField: true,
                    ),
                    Space.y2!,
                    Text('About me', style: AppText.l1b),
                    Space.y1!,
                    AppTextField(
                      name: _FormKeys.bio,
                      hint: 'Bio',
                      initialValue: user.bio,
                      validator: FormBuilderValidators.required(),
                      isDarkField: true,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              Space.y2!,
              AppButton(label: 'Update Profile', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
