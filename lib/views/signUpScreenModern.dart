// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter/services/signUpServices.dart';
import 'package:note_app_flutter/views/signInScreen.dart';
import 'dart:developer';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    userPhoneController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    var userName = userNameController.text.trim();
    var userPhone = userPhoneController.text.trim();
    var userEmail = userEmailController.text.trim();
    var userPassword = userPasswordController.text.trim();

    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
      if (credential.user != null) {
        await signUpUser(userName, userPhone, userEmail, userPassword);
        log("User Created");
        Get.off(() => const LoginScreen());
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
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak. Use at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Lottie.asset(
                    "assets/Animation - 1708497028538.json",
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Join us to get started",
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
                            controller: userNameController,
                            decoration: InputDecoration(
                              labelText: "Username",
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.surfaceContainer,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: userPhoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.surfaceContainer,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a phone number';
                              }
                              if (!RegExp(r'^\+?\d{10,15}$')
                                  .hasMatch(value.trim())) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: userEmailController,
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value.trim())) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: userPasswordController,
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.trim().length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
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
                    onPressed: _isLoading ? null : _handleSignUp,
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
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: Text(
                          "Sign In",
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
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:note_app_flutter/services/signUpServices.dart';
// import 'package:note_app_flutter/views/signInScreen.dart';
// import 'dart:developer';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController userPhoneController = TextEditingController();
//   TextEditingController userEmailController = TextEditingController();
//   TextEditingController userPasswordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;
//   String? _errorMessage;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     userNameController.dispose();
//     userPhoneController.dispose();
//     userEmailController.dispose();
//     userPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignUp() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     var userName = userNameController.text.trim();
//     var userPhone = userPhoneController.text.trim();
//     var userEmail = userEmailController.text.trim();
//     var userPassword = userPasswordController.text.trim();

//     try {
//       final UserCredential credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//               email: userEmail, password: userPassword);
//       if (credential.user != null) {
//         await signUpUser(userName, userPhone, userEmail, userPassword);
//         log("User Created");
//         Get.off(() => const LoginScreen());
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
//       case 'email-already-in-use':
//         return 'This email is already registered.';
//       case 'invalid-email':
//         return 'The email address is invalid.';
//       case 'weak-password':
//         return 'The password is too weak. Use at least 6 characters.';
//       case 'operation-not-allowed':
//         return 'Email/password accounts are not enabled.';
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
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 40),
//                   Lottie.asset(
//                     "assets/Animation - 1708497028538.json",
//                     height: 200,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 32),
//                   Text(
//                     "Create Account",
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Join us to get started",
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           color: Theme.of(context).colorScheme.onSurfaceVariant,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 32),
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: userNameController,
//                             decoration: InputDecoration(
//                               labelText: "Username",
//                               prefixIcon: Icon(
//                                 Icons.person_outline,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor:
//                                   Theme.of(context).colorScheme.surfaceContainer,
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter a username';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: userPhoneController,
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               labelText: "Phone Number",
//                               prefixIcon: Icon(
//                                 Icons.phone_outlined,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor:
//                                   Theme.of(context).colorScheme.surfaceContainer,
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter a phone number';
//                               }
//                               if (!RegExp(r'^\+?\d{10,15}$')
//                                   .hasMatch(value.trim())) {
//                                 return 'Please enter a valid phone number';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: userEmailController,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               labelText: "Email",
//                               prefixIcon: Icon(
//                                 Icons.email_outlined,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor:
//                                   Theme.of(context).colorScheme.surfaceContainer,
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter an email';
//                               }
//                               if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                                   .hasMatch(value.trim())) {
//                                 return 'Please enter a valid email';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: userPasswordController,
//                             obscureText: !_isPasswordVisible,
//                             decoration: InputDecoration(
//                               labelText: "Password",
//                               prefixIcon: Icon(
//                                 Icons.lock_outline,
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _isPasswordVisible
//                                       ? Icons.visibility
//                                       : Icons.visibility_off,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isPasswordVisible = !_isPasswordVisible;
//                                   });
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               filled: true,
//                               fillColor:
//                                   Theme.of(context).colorScheme.surfaceContainer,
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter a password';
//                               }
//                               if (value.trim().length < 6) {
//                                 return 'Password must be at least 6 characters';
//                               }
//                               return null;
//                             },
//                           ),
//                           if (_errorMessage != null) ...[
//                             const SizedBox(height: 12),
//                             Text(
//                               _errorMessage!,
//                               style: TextStyle(
//                                 color: Theme.of(context).colorScheme.error,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: _isLoading ? null : _handleSignUp,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 2,
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator()
//                         : const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account? ",
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Get.to(() => const LoginScreen());
//                         },
//                         child: Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.primary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:note_app_flutter/services/signUpServices.dart';
// import 'package:note_app_flutter/views/signInScreen.dart';
// import 'dart:developer';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController userPhoneController = TextEditingController();
//   TextEditingController userEmailController = TextEditingController();
//   TextEditingController userPasswordController = TextEditingController();

//   User? currentUser = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("SignUp Screen"),
//         // actions: const [Icon(Icons.more_vert)],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: 200,
//                 child: Lottie.asset("assets/Animation - 1708497028538.json"),
//               ),
//               const SizedBox(height: 20.0),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: userNameController,
//                   decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.person),
//                       hintText: "UserName",
//                       enabledBorder: OutlineInputBorder()),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: userPhoneController,
//                   decoration: const InputDecoration(
//                       prefixIcon: Icon(Icons.phone),
//                       hintText: "Phone",
//                       enabledBorder: OutlineInputBorder()),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: TextFormField(
//                   controller: userEmailController,
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
//                   controller: userPasswordController,
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
//                     var userName = userNameController.text.trim();
//                     var userPhone = userPhoneController.text.trim();
//                     var userEmail = userEmailController.text.trim();
//                     var userPassword = userPasswordController.text.trim();

//                     await FirebaseAuth.instance
//                         .createUserWithEmailAndPassword(
//                             email: userEmail, password: userPassword)
//                         .then((value) => {
//                               log("User Created"),
//                               signUpUser(
//                                   userName, userPhone, userEmail, userPassword)
//                             });
//                   },
//                   child: const Text("Sign Up")),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(() => const LoginScreen());
//                 },
//                 child: Container(
//                   child: const Card(
//                       child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Text("Already have an account LoginIn"),
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
