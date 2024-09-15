part of 'job_card.dart';

class _LikeIcon extends StatefulWidget {
  final String userId;
  final Job job;
  const _LikeIcon({required this.job, required this.userId});

  @override
  State<_LikeIcon> createState() => __LikeIconState();
}

class __LikeIconState extends State<_LikeIcon> {
  late bool isLiked = widget.job.likedBy.contains(widget.userId);

  @override
  Widget build(BuildContext context) {
    final jobBloc = BlocProvider.of<JobsBloc>(context);

    return isLiked
        ? IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              color: [AppTheme.c.accent, AppTheme.c.primary]
                  .elementAt(Random().nextInt(2)),
            ),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });

              jobBloc.add(
                LikeUnlikeJob(
                  jobId: widget.job.id,
                  userId: widget.userId,
                ),
              );
            },
          )
        : IconButton(
            icon: Icon(
              Icons.favorite_border_rounded,
              color: [AppTheme.c.accent, AppTheme.c.primary]
                  .elementAt(Random().nextInt(2)),
            ),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });

              jobBloc.add(
                LikeUnlikeJob(
                  jobId: widget.job.id,
                  userId: widget.userId,
                ),
              );
            },
          );
  }
}
