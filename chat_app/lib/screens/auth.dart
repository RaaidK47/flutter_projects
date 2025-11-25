import 'package:flutter/material.dart';

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

  void _submit() {
    final isValid = _formKey.currentState!.validate();

    if(isValid) {
      _formKey.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty || !value.contains('@')){
                                return 'Please Enter a Valid Email Address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            // Hide the Input
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6 ){
                                return 'Password must be atleast 6 Characters Long';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer
                            ),
                            child: Text(_isLogin ? 'Log In' : 'Signup'),
                          ),
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
