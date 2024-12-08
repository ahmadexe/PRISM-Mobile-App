part of 'settings.dart';

final accountSettingsData = [
  _ListData(icon: const Icon(Iconsax.user), title: 'Account'),
  _ListData(icon: const Icon(Iconsax.chart), title: 'Share Data'),
  _ListData(icon: const Icon(Iconsax.security_safe), title: 'Privacy & Safety'),
  _ListData(icon: const Icon(Iconsax.box_2), title: 'Analytics'),
  _ListData(
    icon: Image.asset(
      AppStaticData.lensIcon,
      height: AppDimensions.normalize(10),
      width: AppDimensions.normalize(10),
      fit: BoxFit.cover,
    ),
    title: 'Lens Support',
  ),
];

final support = [
  _ListData(icon: const Icon(Iconsax.people), title: 'Support'),
  _ListData(icon: const Icon(Iconsax.star), title: 'Acknowledgements'),
  _ListData(
      icon: const Icon(Iconsax.message_question), title: 'Report a Problem'),
];

final logout = [
  _ListData(icon: const Icon(Iconsax.logout), title: 'Logout'),
];

final devSettings = [
  _ListData(icon: const Icon(Iconsax.code), title: 'API Docs'),
  _ListData(icon: const Icon(Iconsax.code), title: 'App Versions'),
  _ListData(icon: const Icon(Iconsax.code), title: 'Clear Cache'),
  _ListData(icon: const Icon(Iconsax.code), title: 'Write Cache'),
];
