import 'package:e_commerce_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/features/auth/data/models/req/login_req.model.dart';
import '../../../core/theme/app_color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  /// Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 95,
                          width: 95,
                          decoration: BoxDecoration(
                            gradient: AppColors.gradientV5,
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_person_rounded,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 45),

                  /// Email Field
                  _buildTextField(
                    controller: emailController,
                    hint: "Email Address",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }

                      if (!GetUtils.isEmail(value)) {
                        return "Invalid email address";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  /// Password Field
                  Obx(
                    () => _buildTextField(
                      controller: passwordController,
                      hint: "Password",
                      icon: Icons.lock_outline_rounded,
                      isPassword: isHidden.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          isHidden.value = !isHidden.value;
                        },
                        icon: Icon(
                          isHidden.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: Container(
                      decoration: BoxDecoration(
                      gradient: AppColors.gradientV0,
                      borderRadius: BorderRadius.circular(18),
                    ),
                      child: ElevatedButton(
                        onPressed: ()async {
                          if (_formKey.currentState!.validate()) {
                            final req = LoginReq(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );

                            final success = await controller.login(req);

                            Get.snackbar(
                              "Success",
                              "Login Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey,thickness: 0.3,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey,thickness: 0.3,)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Apple Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: AppColors.gradientV5,
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Container(width: 36,decoration: BoxDecoration(
                           // color: Colors.red.shade600,
                            gradient: AppColors.gradientV7,
                            borderRadius: BorderRadius.circular(10)
                        ),

                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Apple_logo_grey.svg/960px-Apple_logo_grey.svg.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail&_=20220821122206",color: Colors.white,
                              height: 22,
                            ),
                          ),
                        ),
                        label: const Text(
                          "Continue with Apple",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  /// Google Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientV5,
                        borderRadius: BorderRadius.circular(18)
                      ),
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Container(width: 36,decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                            gradient: AppColors.gradientV7,
                          borderRadius: BorderRadius.circular(10)
                        ),

                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.network('https://cdn-icons-png.flaticon.com/512/281/281764.png',color: Colors.white,)
                          ),
                        ),
                        label: const Text(
                          "Continue with Google",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      cursorColor: Colors.white,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withAlpha(50),
        hintText: hint,
        hintStyle:TextStyle(color: Colors.white.withValues(alpha: 0.4),),
        prefixIcon: Icon(icon,color: Colors.white,),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.blueAccent.shade700, width: 1.5),
        ),
      ),
    );
  }
}
