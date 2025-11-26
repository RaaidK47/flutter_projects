import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  // To toggle between Login or Signup Mode
  var _isLogin = true;

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';

  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      // Validation failed
      return;
    }

    if (!_isLogin && _selectedImage == null) {
      // No Image Provided in Sign-up Mode
      // Might show an Error here
      return;
    }

    _formKey.currentState!.save();

    if (_isLogin) {
      setState(() {
        _isAuthenticating = true;
      });
      // Logic to Log In User
      try {
        print("Trying to Log In");
        print(_enteredEmail);
        print(_enteredPassword);
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        _isAuthenticating = false;
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')),
        );
        setState(() {
          _isAuthenticating = false;
        });
      }
    } else {
      // Signing-up User
      try {
        setState(() {
          _isAuthenticating = true;
        });
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        // Uploading Image
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(_selectedImage!);
        // Get URL of stored Image
        final imageURL = await storageRef.getDownloadURL();
        // Saving user Metadata to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
              'username': _enteredUsername,
              'email': _enteredEmail,
              'image_url': imageURL,
            });
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already in use') {
          // Handle Exception
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')),
        );
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        // If keyboard is open,
        // we want complete form to be reachable
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Chat Image
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              // Authentication Form
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickedImage: (pickedImage) =>
                                  _selectedImage = pickedImage,
                            ),
                          // Email Address Input
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please Enter a Valid Email Address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),

                          // Username Input
                          if (!_isLogin)
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim().length < 4 ){
                                  return 'Please enter at least 4 Characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Username'),
                              enableSuggestions: false,
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),

                          // Password Input
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            // Hide the Input
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be atleast 6 Characters Long';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating) ...[
                            SizedBox(height: 5),
                            CircularProgressIndicator(strokeWidth: 3),
                            SizedBox(height: 5),
                          ],
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Log In' : 'Signup'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  // Switching _isLogin Variable
                                  _isLogin = !_isLogin;
                                  // _isLogin = _isLogin ? false : true;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Create an Account'
                                    : 'Already have an Account, Log In',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
