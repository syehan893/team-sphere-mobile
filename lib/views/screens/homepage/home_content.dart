import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';
import 'package:action_slider/action_slider.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ActionSlider.standard(
                toggleColor: TSColors.background.b100,
                backgroundColor: TSColors.secondary.s50,
                icon: const Icon(Icons.arrow_forward_rounded),
                backgroundBorderRadius: BorderRadius.circular(8),
                foregroundBorderRadius: BorderRadius.circular(8),
                child: const Body1.regular('Swipe to check in', fontSize: 18),
                action: (controller) async {
                  controller.loading();
                  await Future.delayed(const Duration(seconds: 3));
                  controller.success();
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubHeadline.regular('Selamat pagi,',
                            color: TSColors.primary.p100),
                        H1('Muhammad Syehan', color: TSColors.primary.p100),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: TSColors.secondary.s30,
                      child: Image.asset(Assets.icons.notifications.path,
                          color: TSColors.primary.p100, height: 20, width: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const RollCallCard(),
                const SizedBox(height: 20),
                const Text('Features',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureIcon(Assets.icons.earthAirplane.path, 'Leave',
                        () {
                      context.go('/leave');
                    }),
                    _buildFeatureIcon(Assets.icons.dollarCoin.path, 'Reimburse',
                        () {
                      context.go('/reimburse');
                    }),
                    _buildFeatureIcon(
                        Assets.icons.userMultipleGroup.path, 'Member', () {}),
                    _buildFeatureIcon(
                        Assets.icons.newsPaper.path, 'News', () {}),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('News',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  ImageCarousel(
                    images: const [
                      'https://gqrrkswdhnhahfvgjzkj.supabase.co/storage/v1/object/public/company_news/news-1.png',
                      'https://gqrrkswdhnhahfvgjzkj.supabase.co/storage/v1/object/public/company_news/news-2.png'
                    ],
                    onTap: (index) {
                      context.go('/news');
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    H3('Colleagues'),
                  ],
                ),
                const SizedBox(height: 10),
                _buildCollaguesCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCollaguesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: TSColors.secondary.s70),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          EmployeeAvatar(email: 'syehan@gmail.com', radius: 24),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H3('Muhammad Syehan'),
              Body1.regular('Software Engineer'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(String path, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            minRadius: 35,
            backgroundColor: TSColors.secondary.s30,
            child: Image.asset(path, height: 35, width: 35),
          ),
          const SizedBox(height: 5),
          Body1.bold(label),
        ],
      ),
    );
  }
}

class RollCallCard extends StatelessWidget {
  const RollCallCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TSColors.secondary.s30,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(Assets.images.locationDynamicColor.path,
              height: 64, width: 64),
          const SizedBox(width: 21),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H3('Wednesday, 23 Jan 2024'),
              H3('10:20 pm'),
            ],
          ),
        ],
      ),
    );
  }
}
