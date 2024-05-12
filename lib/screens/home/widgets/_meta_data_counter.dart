part of '../home.dart';

class _MetaDataCounter extends StatefulWidget {
  final Post post;
  final int index;
  const _MetaDataCounter({required this.post, required this.index});

  @override
  State<_MetaDataCounter> createState() => _MetaDataCounterState();
}

class _MetaDataCounterState extends State<_MetaDataCounter> {
  late int upVotes;
  late bool isUpVoted;
  late bool isDownVoted;
  late int comments;

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;
    upVotes = widget.post.upVotes;
    isUpVoted = widget.post.upVotedBy.contains(user.id);
    isDownVoted = widget.post.downVotedBy.contains(user.id);
    comments = widget.post.noOfComments;
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostsBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: Space.all(4, 4),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isUpVoted) {
                      upVotes--;
                      isUpVoted = false;
                    } else {
                      upVotes++;
                      isUpVoted = true;
                      isDownVoted = false;
                    }
                  });

                  postBloc.add(
                    PostVoteEvent(
                      postId: widget.post.id,
                      userId: user.id,
                      isUpVote: true,
                      index: widget.index,
                    ),
                  );
                },
                child: Icon(
                  Iconsax.arrow_up,
                  color: isUpVoted ? AppTheme.c.primary : Colors.white,
                ),
              ),
              Space.x!,
              Text(
                upVotes.toString(),
                style: AppText.b2,
              ),
              Space.x1!,
              Text('|', style: AppText.b2!.cl(Colors.grey)),
              Space.x!,
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isDownVoted) {
                      isDownVoted = false;
                    } else {
                      isDownVoted = true;
                      if (isUpVoted) {
                        isUpVoted = false;
                        upVotes--;
                      }
                    }
                  });

                  postBloc.add(
                    PostVoteEvent(
                      postId: widget.post.id,
                      userId: user.id,
                      isUpVote: false,
                      index: widget.index,
                    ),
                  );
                },
                child: Icon(
                  Iconsax.arrow_bottom,
                  color: isDownVoted ? AppTheme.c.accent : Colors.white,
                ),
              ),
            ],
          ),
        ),
        Space.x2!,
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return _CommentsSheet(post: widget.post);
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.5)),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: Space.all(10, 6),
            child: Row(
              children: [
                const Icon(
                  Iconsax.messages,
                  color: Colors.white,
                  size: 20,
                ),
                Space.x!,
                Text(
                  '$comments Comments',
                  style: AppText.b2bm,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
