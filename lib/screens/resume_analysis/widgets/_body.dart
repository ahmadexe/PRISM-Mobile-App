part of '../resume_analysis.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Resume"),
          scrolledUnderElevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: Space.all(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lens has analyzed your resume!',
                    style: AppText.h3b,
                    textAlign: TextAlign.center,
                  ),
                  Space.y!,
                  Text(
                    'Lens has indentified the following skills in your resume, we will use this information to find the best job for you.',
                    style: AppText.l1,
                    textAlign: TextAlign.center,
                  ),
                  Space.y2!,
                  Wrap(
                    children: [
                      Chip(
                        label: const Text('Python'),
                        backgroundColor: AppTheme.c.primary,
                      ),
                      Space.x!,
                      Chip(
                        label: const Text('Django'),
                        backgroundColor: AppTheme.c.primary,
                      ),
                      Space.x!,
                      Chip(
                        label: const Text('React'),
                        backgroundColor: AppTheme.c.primary,
                      ),
                      Space.x!,
                      Chip(
                        label: const Text('Flutter'),
                        backgroundColor: AppTheme.c.primary,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
