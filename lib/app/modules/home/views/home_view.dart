import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),

      drawer: Drawer(
        child: Column(
          children: [

            Obx(
                  () => UserAccountsDrawerHeader(
                accountName: Text(controller.name.value),
                accountEmail: Text(controller.email.value),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Get.back();
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {

                await controller.logout();

                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),

      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
