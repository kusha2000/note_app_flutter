// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/views/forgotPasswordScreen.dart';
import 'package:note_app_flutter/views/homeScreen.dart';
import 'package:note_app_flutter/views/signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    var loginEmail = loginEmailController.text.trim();
    var loginPassword = loginPasswordController.text.trim();

    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: loginEmail, password: loginPassword))
          .user;
      if (firebaseUser != null) {
        Get.off(() => const HomeScreen());
      } else {
        setState(() {
          _errorMessage = "Invalid email or password";
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e.code);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Lottie.asset(
                  "assets/Animation - 1708493774305.json",
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign in to continue",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: loginPasswordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPasswordScreen());
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// // ignore: file_names
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:note_app_flutter/views/forgotPasswordScreen.dart';
// import 'package:note_app_flutter/views/homeScreen.dart';
// import 'package:note_app_flutter/views/signUpScreen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController loginEmailController = TextEditingController();
//   TextEditingController loginPasswordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     loginEmailController.dispose();
//     loginPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleLogin() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     var loginEmail = loginEmailController.text.trim();
//     var loginPassword = loginPasswordController.text.trim();

//     try {
//       final User? firebaseUser = (await FirebaseAuth.instance
//               .signInWithEmailAndPassword(
//                   email: loginEmail, password: loginPassword))
//           .user;
//       if (firebaseUser != null) {
//         Get.off(() => const HomeScreen());
//       } else {
//         setState(() {
//           _errorMessage = "Invalid email or password";
//         });
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = _getErrorMessage(e.code);
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   String _getErrorMessage(String code) {
//     switch (code) {
//       case 'user-not-found':
//         return 'No user found with this email.';
//       case 'wrong-password':
//         return 'Incorrect password. Please try again.';
//       case 'invalid-email':
//         return 'The email address is invalid.';
//       case 'user-disabled':
//         return 'This user account has been disabled.';
//       default:
//         return 'An error occurred. Please try again.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Theme.of(context).colorScheme.primary.withOpacity(0.1),
//               Theme.of(context).colorScheme.secondary.withOpacity(0.1),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 40),
//                 Lottie.asset(
//                   "assets/Animation - 1708493774305.json",
//                   height: 200,
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(height: 32),
//                 Text(
//                   "Welcome Back",
//                   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Sign in to continue",
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: Theme.of(context).colorScheme.onSurfaceVariant,
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 32),
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: loginEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             labelText: "Email",
//                             prefixIcon: Icon(
//                               Icons.email_outlined,
//                               color: Theme.of(context).colorScheme.primary,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 Theme.of(context).colorScheme.surfaceContainer,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: loginPasswordController,
//                           obscureText: !_isPasswordVisible,
//                           decoration: InputDecoration(
//                             labelText: "Password",
//                             prefixIcon: Icon(
//                               Icons.lock_outline,
//                               color: Theme.of(context).colorScheme.primary,
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPasswordVisible = !_isPasswordVisible;
//                                 });
//                               },
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 Theme.of(context).colorScheme.surfaceContainer,
//                           ),
//                         ),
//                         if (_errorMessage != null) ...[
//                           const SizedBox(height: 12),
//                           Text(
//                             _errorMessage!,
//                             style: TextStyle(
//                               color: Theme.of(context).colorScheme.error,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _handleLogin,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 2,
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator()
//                       : const Text(
//                           "Sign In",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextButton(
//                   onPressed: () {
//                     Get.to(() => const ForgotPasswordScreen());
//                   },
//                   child: Text(
//                     "Forgot Password?",
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account? ",
//                       style: TextStyle(
//                         color: Theme.of(context).colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => const SignUpScreen());
//                       },
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.primary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore: file_names
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:note_app_flutter/views/forgotPasswordScreen.dart';
// import 'package:note_app_flutter/views/homeScreen.dart';
// import 'package:note_app_flutter/views/signUpScreen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController loginEmailController = TextEditingController();
//   TextEditingController loginPasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: const Text("Login Screen"),
//         // actions: const [Icon(Icons.more_vert)],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: 250,
//                 child: Lottie.asset("assets/Animation - 1708493774305.json"),
//               ),
//               const SizedBox(height: 50.0),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: loginEmailController,
//                   decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.email),
//                       hintText: "Email",
//                       enabledBorder: OutlineInputBorder()),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: loginPasswordController,
//                   decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.password),
//                       suffixIcon: Icon(Icons.visibility),
//                       hintText: "Password",
//                       enabledBorder: OutlineInputBorder()),
//                 ),
//               ),
//               const SizedBox(height: 15.0),
//               ElevatedButton(
//                   onPressed: () async {
//                     var loginEmail = loginEmailController.text.trim();
//                     var loginPassword = loginPasswordController.text.trim();

//                     try {
//                       final User? firebaseUser = (await FirebaseAuth.instance
//                               .signInWithEmailAndPassword(
//                                   email: loginEmail, password: loginPassword))
//                           .user;
//                       if (firebaseUser != null) {
//                         Get.to(() => const HomeScreen());
//                       } else {
//                         print("Check Email & Password");
//                       }
//                     } on FirebaseAuthException catch (e) {
//                       print("Error $e");
//                     }
//                   },
//                   child: const Text("Login")),
//               const SizedBox(height: 10.0),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(() => const ForgotPasswordScreen());
//                 },
//                 child: Container(
//                   child: const Card(
//                       child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Text("Forgot Password"),
//                   )),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(() => const SignUpScreen());
//                 },
//                 child: Container(
//                   child: const Card(
//                       child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Text("Don't have an account SignUp"),
//                   )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
