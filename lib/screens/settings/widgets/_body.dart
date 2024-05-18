part of '../settings.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  name: 'search',
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    size: AppDimensions.normalize(7),
                  ),
                  hint: 'Search',
                  isDarkField: true,
                  type: FieldType.secondary,
                ),
                _SettingsTile(
                  title: 'Account Settings',
                  data: accountSettingsData,
                ),
                _SettingsTile(
                  title: 'Support',
                  data: support,
                ),
                _SettingsTile(
                  title: 'Logout',
                  data: logout,
                  isProminant: true,
                ),
                _SettingsTile(
                  title: 'Dev Settings',
                  data: devSettings,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
