part of '../explore.dart';

class _UserTile extends StatelessWidget {
  final AuthData user;
  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final currentProfile = authBloc.state.user!;

    return GestureDetector(
      onTap: () {
        if (currentProfile.id == user.id) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.profile,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.profile,
            arguments: {
              'userId': user.id,
            },
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Avatar(
                  imageUrl: user.imageUrl,
                ),
                Space.x2!,
                Text(
                  user.fullname,
                  style: AppText.b1bm,
                ),
              ],
            ),
          ),
          InfoTile(
            domain: user.domain,
            iconOnly: true,
          ),
          Space.x!,
          const Icon(Icons.more_vert)
        ],
      ),
    );
  }
}
