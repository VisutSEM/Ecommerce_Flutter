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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
      ),
      child: Scaffold(
      backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: controller.getCategories,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    /// ================= HEADER =================
                    Row(
                      children: [
                        /// USER PROFILE
                        Obx(
                              () => CircleAvatar(
                            radius: 28,

                            backgroundColor: Colors.white,

                            backgroundImage:
                            controller.userImage.value.isNotEmpty
                                ? NetworkImage(
                              controller.userImage.value,
                            )
                                : null,

                            child:
                            controller.userImage.value.isEmpty
                                ? const Icon(
                              Icons.person,
                              size: 30,
                            )
                                : null,
                          ),
                        ),

                        SizedBox(width: 14),

                        /// USER INFO
                        Expanded(
                          child: Obx(
                                () => Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  "Good, Morning",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  controller.userName.value,

                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// NOTIFICATION
                        Container(
                          padding:
                          const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(
                                16),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withValues(alpha: 0.05),

                                blurRadius: 8,
                              ),
                            ],
                          ),

                          child: const Icon(
                            Icons.notifications_none,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// ================= SEARCH =================
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(18),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: 0.05),

                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search products...",

                          prefixIcon:
                          const Icon(Icons.search),

                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                18),

                            borderSide:
                            BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// ================= EVENT BANNER =================
                    CarouselSlider.builder(
                      itemCount:
                      controller.banners.length,

                      options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.92,
                      ),

                      itemBuilder:
                          (context, index, realIndex) {
                        final banner =
                        controller.banners[index];

                        return Container(
                          width: double.infinity,

                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(
                                24),

                            gradient: LinearGradient(
                              colors: [
                                Color(
                                  banner['color'],
                                ),
                                Color(
                                  banner['color'],
                                ).withValues(alpha: 0.7),
                              ],
                            ),
                          ),

                          child: Stack(
                            children: [
                              /// TEXT
                              Padding(
                                padding:
                                const EdgeInsets.all(
                                    22),

                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                                  children: [
                                    Text(
                                      banner['title'],

                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.white,
                                        fontSize: 28,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 8),

                                    Text(
                                      banner[
                                      'subtitle'],

                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 16),

                                    ElevatedButton(
                                      onPressed: () {},

                                      style:
                                      ElevatedButton
                                          .styleFrom(
                                        backgroundColor:
                                        Colors.white,

                                        foregroundColor:
                                        Colors.black,
                                      ),

                                      child: const Text(
                                          "Shop Now"),
                                    ),
                                  ],
                                ),
                              ),

                              /// IMAGE
                              Positioned(
                                right: 0,
                                bottom: 0,

                                child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.only(
                                    bottomRight:
                                    Radius.circular(
                                        24),
                                  ),

                                  child: Image.network(
                                    banner['image'],
                                    width: 160,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    /// ================= CATEGORIES =================
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // GridView.builder(
                    //   shrinkWrap: true,
                    //
                    //   physics:
                    //   const NeverScrollableScrollPhysics(),
                    //
                    //   itemCount:
                    //   controller.categories.length,
                    //
                    //   gridDelegate:
                    //   const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     crossAxisSpacing: 14,
                    //     mainAxisSpacing: 14,
                    //     childAspectRatio: 1,
                    //   ),
                    //
                    //   itemBuilder: (context, index) {
                    //     final category =
                    //     controller.categories[index];
                    //
                    //     return Container(
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius:
                    //         BorderRadius.circular(
                    //             24),
                    //
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black
                    //                 .withOpacity(0.04),
                    //
                    //             blurRadius: 8,
                    //           ),
                    //         ],
                    //       ),
                    //
                    //       child: Column(
                    //         mainAxisAlignment:
                    //         MainAxisAlignment.center,
                    //
                    //         children: [
                    //           Text(
                    //             category['icon'],
                    //             style:
                    //             const TextStyle(
                    //               fontSize: 36,
                    //             ),
                    //           ),
                    //
                    //           const SizedBox(height: 10),
                    //
                    //           Text(
                    //             category['title'],
                    //
                    //             style:
                    //             const TextStyle(
                    //               fontWeight:
                    //               FontWeight.w600,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    Obx(
                          () {
                        if (controller.categories.isEmpty) {
                          return const Center(
                            child: Text('connecting from the server.....'),
                          );
                        }

                        return SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              final category = controller.categories[index];

                              return Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    category['name'], // Change to category.name if using a model
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 30),

                    /// ================= SPECIAL CARD =================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(26),

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF9966),
                            Color(0xFFFF5E62),
                          ],
                        ),
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [
                                const Text(
                                  "Special Offer 🔥",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                const Text(
                                  "Get discount for your first order.",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(height: 18),

                                ElevatedButton(
                                  onPressed: () {},

                                  style:
                                  ElevatedButton
                                      .styleFrom(
                                    backgroundColor:
                                    Colors.white,

                                    foregroundColor:
                                    Colors.deepOrange,
                                  ),

                                  child:
                                  const Text("Buy Now"),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.local_offer,
                            color: Colors.white,
                            size: 80,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}