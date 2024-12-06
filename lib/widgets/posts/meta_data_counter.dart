import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/post/post.dart';
import 'package:prism/utils/media/media_utils.dart';
import 'package:prism/widgets/posts/comments_sheet.dart';

class MetaDataCounter extends StatefulWidget {
  final PostData post;
  final int index;
  const MetaDataCounter({super.key, required this.post, required this.index});

  @override
  State<MetaDataCounter> createState() => _MetaDataCounterState();
}

class _MetaDataCounterState extends State<MetaDataCounter> {
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
    final lensBloc = BlocProvider.of<LensBloc>(context);
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
                onTap: () async {
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

                  if (isUpVoted) {
                    if (widget.post.imageUrl != null) {
                      final inputImage = await MediaUtils.getImageBytes(
                        widget.post.imageUrl!,
                      );
                      if (inputImage != null) {
                        lensBloc.add(AnalyzePost(inputImage: inputImage));
                      }
                    } else if (widget.post.description != null) {
                      lensBloc.add(AnalyzePost(text: widget.post.description!));
                    }
                  }

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
          onTap: () async {
            final res = await showModalBottomSheet<int>(
              isScrollControlled: true,
              enableDrag: false,
              builder: (context) {
                return CommentsSheet(
                  post: widget.post,
                );
              },
              context: context,
            );
            if (res != null && res > 0) {
              setState(() {
                comments += res;
              });
            }
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
