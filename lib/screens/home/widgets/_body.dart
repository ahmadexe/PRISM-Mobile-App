part of '../home.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.sms_tracking),
            ),
          ],
        ),
        drawer: Container(
          width: MediaQuery.sizeOf(context).width * .7,
          color: AppTheme.c.fieldDark,
        ),
        floatingActionButton: GestureDetector(
          onTap: () {},
          child: Image.asset(
            AppStaticData.lensIcon,
            height: AppDimensions.normalize(22),
            width: AppDimensions.normalize(22),
          ),
        ),
        body: Padding(
          padding: Space.all(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Avatar(
                      imageUrl: user.imageUrl,
                    ),
                    Space.x1!,
                    Expanded(
                      child: AppTextField(
                        enabled: false,
                        onTap: () {},
                        name: 'Post',
                        isDarkField: true,
                        type: FieldType.secondary,
                        hint: 'Tell the world a story',
                      ),
                    )
                  ],
                ),
                Space.y2!,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _Post(post: posts[index]),
                  separatorBuilder: (context, index) => Space.y1!,
                  itemCount: posts.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
