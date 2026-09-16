import 'dart:ui';

import 'package:e_commerce_flutter/app/modules/profile/data/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_color.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  @override
  final ProfileController controller = Get.put(ProfileController());
  UserModel? user;

  static const Color primary = Color(0xff6C63FF);
  static const Color secondary = Color(0xff8E7CFF);
  static const Color background = Color(0xffF5F7FB);
  static const Color card = Colors.white;
  static const Color textDark = Color(0xff1F2937);
  static const Color danger = Color(0xffFF4D67);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: RefreshIndicator(
            color: primary,
            onRefresh: controller.refreshProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),

                  const SizedBox(height: 24),

                  const _ProfileCard(),

                  const SizedBox(height: 24),

                  const _SectionTitle(title: "Account"),

                  const SizedBox(height: 12),

                  _MenuContainer(
                    children: [
                      _MenuTile(
                        icon: Icons.shopping_bag_outlined,
                        title: "My Orders",
                        color: Colors.orange,
                        onTap: () {},
                      ),
                      _MenuTile(
                        icon: Icons.favorite_border_rounded,
                        title: "Wishlist",
                        color: Colors.pink,
                        onTap: () {},
                      ),
                      _MenuTile(
                        icon: Icons.location_on_outlined,
                        title: "Address",
                        color: Colors.green,
                        onTap: () {},
                      ),
                      _MenuTile(
                        icon: Icons.notifications_none_rounded,
                        title: "Notifications",
                        color: Colors.blue,
                        onTap: () {},
                      ),
                      _MenuTile(
                        icon: Icons.lock_outline_rounded,
                        title: "Change Password",
                        color: Colors.purple,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const _SectionTitle(title: "Setting"),

                  const SizedBox(height: 12),

                  _MenuContainer(
                    children: [
                      _MenuTile(
                        icon: Icons.dark_mode_outlined,
                        title: 'Dark/Light mode ',
                        color: Colors.yellow,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SwipeLogoutButton(onLogout: controller.logout),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ProfileView.card,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends GetView<ProfileController> {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user.value;
      // print('USER: $user');
      // print('PROFILE PICTURE: ${user?.profilePicture}');
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: controller.pickAndUploadProfilePicture,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.45),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: _Avatar(url: user?.profilePicture ?? ''),
                      ),

                      // Camera button
                      Obx(
                        () => Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.9),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: controller.isUploadingPicture.value
                              ? const Padding(
                                  padding: EdgeInsets.all(7),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black87,
                                  ),
                                )
                              : const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 16,
                                  color: Colors.black87,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user?.name.isNotEmpty == true
                                  ? user!.name
                                  : 'Guest User',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 6),

                          const Icon(
                            Icons.verified_rounded,
                            color: Colors.white,
                            size: 17,
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        user?.email.isNotEmpty == true
                            ? user!.email
                            : 'No email',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.white,
                              size: 16,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              controller.role.value.isNotEmpty
                                  ? controller.role.value
                                  : 'Member',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _Avatar extends StatelessWidget {
  final String url;

  const _Avatar({required this.url});

  @override
  Widget build(BuildContext context) {
    // print('AVATAR URL: "$url"');

    return ClipOval(
      child: SizedBox(
        width: 76,
        height: 76,
        child: url.trim().isNotEmpty
            ? Image.network(
                url.trim(),
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const _AvatarPlaceholder(loading: true);
                },
                errorBuilder: (context, error, stackTrace) {
                  print('AVATAR IMAGE ERROR: $error');
                  print('AVATAR IMAGE URL: $url');

                  return const _AvatarPlaceholder();
                },
              )
            : const _AvatarPlaceholder(),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  final bool loading;

  const _AvatarPlaceholder({this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      color: Colors.white.withValues(alpha: 0.08),
      child: loading
          ? const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            )
          : const Icon(Icons.person_rounded, color: Colors.white, size: 38),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ProfileView.card,
      ),
    );
  }
}

class _MenuContainer extends StatelessWidget {
  final List<Widget> children;

  const _MenuContainer({required this.children});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: ProfileView.card.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: List.generate(
              children.length,
              (index) => Column(
                children: [
                  children[index],

                  if (index != children.length - 1)
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: color.withValues(alpha: 0.20),
        highlightColor: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 4,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class SwipeLogoutButton extends StatefulWidget {
  final Future<void> Function() onLogout;

  const SwipeLogoutButton({super.key, required this.onLogout});

  @override
  State<SwipeLogoutButton> createState() => _SwipeLogoutButtonState();
}

class _SwipeLogoutButtonState extends State<SwipeLogoutButton> {
  double drag = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          drag += details.delta.dx / width;
          drag = drag.clamp(0.0, 1.0);
        });
      },
      onHorizontalDragEnd: (_) async {
        if (drag > 0.85) {
          await widget.onLogout();
        }

        setState(() {
          drag = 0;
        });
      },
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ProfileView.danger.withValues(alpha: 0.15),
              ProfileView.danger.withValues(alpha: 0.25),
            ],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            const Center(
              child: Text(
                "Swipe to Logout",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: drag * (width - 95),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.gradientV2,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Icon(Icons.logout_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
