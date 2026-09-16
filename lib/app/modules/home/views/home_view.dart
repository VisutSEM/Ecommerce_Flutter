// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/home_controller.dart';
//
// class HomeView extends GetView<HomeController> {
//    HomeView({super.key});
//
//   final HomeController controller = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7FA),
//
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Home",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height,
//               ),
//               child: IntrinsicHeight(
//                 child: Column(
//                   children: [
//
//                     /// HEADER
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(20),
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xff4A90E2),
//                             Color(0xff357ABD),
//                           ],
//                         ),
//                       ),
//                       child: Obx(
//                             () => Column(
//                           children: [
//
//                             const CircleAvatar(
//                               radius: 38,
//                               backgroundColor: Colors.white,
//                               child: Icon(
//                                 Icons.person,
//                                 size: 42,
//                                 color: Color(0xff357ABD),
//                               ),
//                             ),
//
//                             const SizedBox(height: 14),
//
//                             Text(
//                               controller.name.value,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//
//                             const SizedBox(height: 4),
//
//                             Text(
//                               controller.email.value,
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     _drawerItem(
//                       icon: Icons.home_rounded,
//                       title: "Home",
//                       onTap: () {
//                         Get.back();
//                       },
//                     ),
//
//                     _drawerItem(
//                       icon: Icons.shopping_bag_rounded,
//                       title: "Products",
//                       onTap: () {
//                         Get.toNamed('/product');
//                       },
//                     ),
//
//                     const Spacer(),
//
//                     const Divider(),
//
//                     _drawerItem(
//                       icon: Icons.logout_rounded,
//                       title: "Logout",
//                       textColor: Colors.red,
//                       iconColor: Colors.red,
//                       onTap: () async {
//                         await controller.logout();
//                         Get.offAllNamed('/login');
//                       },
//                     ),
//
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       body: RefreshIndicator(
//         onRefresh:controller.fetchProducts,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Obx(
//                     () => Text(
//                   "Welcome, ${controller.name.value} 👋",
//                   style: const TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               const Text(
//                 "Explore your dashboard and products.",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               /// CARD
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: const [
//
//                         Text(
//                           "Quick Access",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//
//                         Icon(
//                           Icons.dashboard_customize_rounded,
//                           color: Colors.blue,
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Get.toNamed('/product');
//                         },
//
//                         icon: const Icon(Icons.shopping_cart),
//
//                         label: const Text(
//                           "View Products",
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xff357ABD),
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.circular(14),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _drawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color iconColor = Colors.black87,
//     Color textColor = Colors.black87,
//   }) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: iconColor,
//       ),
//
//       title: Text(
//         title,
//         style: TextStyle(
//           color: textColor,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//
//       onTap: onTap,
//     );
//   }
// }

//===================
import 'package:e_commerce_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:e_commerce_flutter/app/modules/home/widgets/_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_color.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // @override
  // final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;
    return Container(
      decoration: BoxDecoration(gradient: AppColors.gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// ================= HEADER =================
                  Row(
                    children: [
                      // USER PROFILE
                      Obx(() => Avatar(url: controller.user.value?.profilePicture ?? '')),
                      SizedBox(width: 14),

                      /// USER INFO
                      Expanded(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                controller.getGreeting(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),

                              Text(
                                controller.userName.value,

                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// NOTIFICATION
                      Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),

                              blurRadius: 8,
                            ),
                          ],
                        ),

                        child: const Icon(Icons.notifications_none),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// ================= SEARCH =================
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),

                          blurRadius: 8,
                        ),
                      ],
                    ),

                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search products...",

                        prefixIcon: const Icon(Icons.search),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// ================= EVENT BANNER =================
                  // CarouselSlider.builder(
                  //   itemCount:
                  //   controller.banners.length,

                  //   options: CarouselOptions(
                  //     height: 180,
                  //     autoPlay: true,
                  //     enlargeCenterPage: true,
                  //     viewportFraction: 0.92,
                  //   ),

                  //   itemBuilder:
                  //       (context, index, realIndex) {
                  //     final banner =
                  //     controller.banners[index];

                  //     return Container(
                  //       width: double.infinity,

                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //         BorderRadius.circular(
                  //             24),

                  //         gradient: LinearGradient(
                  //           colors: [
                  //             Color(
                  //               banner['color'],
                  //             ),
                  //             Color(
                  //               banner['color'],
                  //             ).withValues(alpha: 0.7),
                  //           ],
                  //         ),
                  //       ),

                  //       child: Stack(
                  //         children: [
                  //           /// TEXT
                  //           Padding(
                  //             padding:
                  //             const EdgeInsets.all(
                  //                 22),

                  //             child: Column(
                  //               crossAxisAlignment:
                  //               CrossAxisAlignment
                  //                   .start,

                  //               mainAxisAlignment:
                  //               MainAxisAlignment
                  //                   .center,

                  //               children: [
                  //                 Text(
                  //                   banner['title'],

                  //                   style:
                  //                   const TextStyle(
                  //                     color:
                  //                     Colors.white,
                  //                     fontSize: 28,
                  //                     fontWeight:
                  //                     FontWeight
                  //                         .bold,
                  //                   ),
                  //                 ),

                  //                 const SizedBox(
                  //                     height: 8),

                  //                 Text(
                  //                   banner[
                  //                   'subtitle'],

                  //                   style:
                  //                   const TextStyle(
                  //                     color:
                  //                     Colors.white,
                  //                     fontSize: 18,
                  //                   ),
                  //                 ),

                  //                 const SizedBox(
                  //                     height: 16),

                  //                 ElevatedButton(
                  //                   onPressed: () {},

                  //                   style:
                  //                   ElevatedButton
                  //                       .styleFrom(
                  //                     backgroundColor:
                  //                     Colors.white,

                  //                     foregroundColor:
                  //                     Colors.black,
                  //                   ),

                  //                   child: const Text(
                  //                       "Shop Now"),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),

                  //           /// IMAGE
                  //           Positioned(
                  //             right: 0,
                  //             bottom: 0,

                  //             child: ClipRRect(
                  //               borderRadius:
                  //               const BorderRadius.only(
                  //                 bottomRight:
                  //                 Radius.circular(
                  //                     24),
                  //               ),

                  //               child: Image.network(
                  //                 banner['image'],
                  //                 width: 160,
                  //                 height: 180,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 30),

                  /// ================= CATEGORIES =================
                  /// Categories
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 50,
                      child: Obx(() {
                        final isSelected =
                            controller.selectedCategory.value == 0;
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.transparent,
                            ),
                          );
                        }
                        return Obx(() {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              final category = controller.categories[index];

                              final categoryId = int.parse(
                                category['id'].toString(),
                              );

                              final selected =
                                  controller.selectedCategory.value ==
                                  categoryId;

                              return GestureDetector(
                                onTap: () {
                                  controller.selectCategory(categoryId);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    // SELECTED
                                    gradient: selected
                                        ? LinearGradient(
                                            colors: [
                                              Colors.blue.shade900,
                                              Colors.red.shade600,
                                            ],
                                          )
                                        // UNSELECTED
                                        : null,

                                    color: selected
                                        ? null
                                        : Colors.white.withValues(alpha: 0.10),

                                    borderRadius: BorderRadius.circular(30),

                                    border: Border.all(
                                      color: selected
                                          ? Colors.transparent
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (selected) ...[
                                        const Icon(
                                          Icons.check_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 6),
                                      ],

                                      Text(
                                        category['name'] ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: selected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                      }),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(height: 30),

                  /// ================= SPECIAL CARD =================
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(22),
                  //
                  //   decoration: BoxDecoration(
                  //     borderRadius:
                  //     BorderRadius.circular(26),
                  //
                  //     gradient: const LinearGradient(
                  //       colors: [
                  //         Color(0xFFFF9966),
                  //         Color(0xFFFF5E62),
                  //       ],
                  //     ),
                  //   ),
                  //
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment:
                  //           CrossAxisAlignment
                  //               .start,
                  //
                  //           children: [
                  //             const Text(
                  //               "Special Offer 🔥",
                  //
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 24,
                  //                 fontWeight:
                  //                 FontWeight.bold,
                  //               ),
                  //             ),
                  //
                  //             const SizedBox(height: 10),
                  //
                  //             const Text(
                  //               "Get discount for your first order.",
                  //
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 15,
                  //               ),
                  //             ),
                  //
                  //             const SizedBox(height: 18),
                  //
                  //             ElevatedButton(
                  //               onPressed: () {},
                  //
                  //               style:
                  //               ElevatedButton
                  //                   .styleFrom(
                  //                 backgroundColor:
                  //                 Colors.white,
                  //
                  //                 foregroundColor:
                  //                 Colors.deepOrange,
                  //               ),
                  //
                  //               child:
                  //               const Text("Buy Now"),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //
                  //       const Icon(
                  //         Icons.local_offer,
                  //         color: Colors.white,
                  //         size: 80,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
