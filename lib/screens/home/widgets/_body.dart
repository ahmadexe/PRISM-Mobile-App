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
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            children: [
              Row(
                children: [
                  Avatar(
                    imageUrl: user.imageUrl,
                  ),
                  Space.x1!,
                  const Expanded(
                    child: AppTextField(
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
                itemBuilder: (context, index) => _Post(post: posts[index]),
                separatorBuilder: (context, index) => Space.y1!,
                itemCount: posts.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
