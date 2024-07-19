part of '../explore.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomBar(),
        appBar: AppBar(
          title: const Text('Explore'),
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: Space.all(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppTextField(
                  name: _FormKeys.query,
                  hint: 'Explore',
                  isDarkField: true,
                  validator: FormBuilderValidators.required(),
                  suffixIcon: const Icon(Iconsax.search_normal),
                  onChanged: (val) {
                    if (val != null && val.isNotEmpty) {
                      authBloc.add(SearchEvent(query: val));
                    }
                  },
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state.search is SearchLoading) {
                      return const _ListPlaceHolder();
                    } else if (state.search is SearchSuccess) {
                      final users = (state.search as SearchSuccess).users;

                      return Column(
                        children: users!
                            .map(
                              (user) => Padding(
                                padding: Space.vf(15),
                                child: _UserTile(user: user),
                              ),
                            )
                            .toList(),
                      );
                    } else if (state.search is SearchFailure) {
                      return const ErrorWarning(
                        title: 'Oops :(',
                        message: 'Something went wrong, we are working on it.',
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
