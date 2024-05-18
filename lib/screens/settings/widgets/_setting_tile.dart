part of '../settings.dart';

class _SettingsTile extends StatelessWidget {
  final String title;
  final List<_ListData> data;
  final bool isProminant;
  const _SettingsTile(
      {required this.title, required this.data, this.isProminant = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space.y2!,
        Text(
          'Account Settings',
          style: AppText.b2b!.cl(Colors.grey),
        ),
        Space.y!,
        Container(
          decoration: BoxDecoration(
            color: AppTheme.c.fieldLight!.withOpacity(.7),
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: data[index].icon,
                title: Text(
                  data[index].title,
                  style: AppText.b2b!
                      .cl(isProminant ? Colors.red : AppTheme.c.white!),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: isProminant
                    ? () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(const AuthLogout());
                      }
                    : () {},
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        )
      ],
    );
  }
}
