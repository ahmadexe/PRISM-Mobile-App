import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/jobs/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/models/job/job.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/widgets/text_expander.dart';

part '_like_icon.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final currentProfile = authBloc.state.user!;

    return GestureDetector(
      onTap: () => AppRoutes.jobsDetail.push(context, arguments: {
        'job': job,
      }),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.c.fieldDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posted ${DateTime.now().getDifference(job.postedAt)} ago',
                style: AppText.l1!.cl(Colors.grey),
              ),
              Space.y1!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    job.title,
                    style: AppText.b1bm,
                  ),
                  if (currentProfile.id != job.postedBy) ...[
                    _LikeIcon(job: job, userId: currentProfile.id),
                  ],
                ],
              ),
              TextExpander(displayText: job.description),
              Space.y2!,
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  job.keywords.length,
                  (index) {
                    final keyword = job.keywords[index];
                    return ActionChip(
                      label: Text(keyword, style: AppText.l1!.cl(Colors.white)),
                      color: WidgetStatePropertyAll(AppTheme.c.fieldLight!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  },
                ),
              ),
              Space.y1!,
              Row(
                children: [
                  Text(
                    'Budget: ',
                    style: AppText.b2bm,
                  ),
                  Text(
                    "${job.budget} USD ${job.budgetMeta}",
                    style: AppText.b2bm!.cl(Colors.grey),
                  ),
                ],
              ),
              Space.y!,
              Row(
                children: [
                  const Icon(
                    Iconsax.location,
                    size: 14,
                  ),
                  Space.x1!,
                  Text(
                    job.country,
                    style: AppText.b2,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
