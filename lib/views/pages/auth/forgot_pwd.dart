import 'package:Organiser/controllers/auth/forgot_pwd_controller.dart';
import 'package:Organiser/views/widgets/common/auth/decorate.dart';
import 'package:flutter/material.dart';
import 'package:Organiser/views/widgets/common/auth/custom_text_field.dart';
import 'package:Organiser/views/widgets/common/auth/auth_buttons.dart';
import 'package:Organiser/views/widgets/common/auth/greet.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  ResetPasswordController _resetPasswordController = ResetPasswordController();

  String? _errorText;

  void _resetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        final result = await _resetPasswordController.resetPassword(
          context,
          _emailController.text,
        );
        result.fold(
          (errorMessage) {
            setState(() {
              _errorText = errorMessage;
            });
          },
          (user) {
            if (user != null) {
             Navigator.pop(context);
            }
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AuthPageDecoration(),
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 500.0,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GreetUser(
                          title: 'Reset Password',
                          subtitle: 'Enter your email',
                        ),
                        SizedBox(height: 50.0),
                        CustomTextField(
                          labelText: 'Email',
                          controller: _emailController,
                          trailingIcon: Icons.mail_outlined,
                          inputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AuthButtonPrimary(
                              text: 'Reset',
                              onPressed: () => _resetPassword(context),
                            ),
                            Text("OR"),
                            AuthButtonSecondary(
                              text: 'Back',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            if (_errorText != null)
                              Text(
                                (_errorText! + " Please try again."),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
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
          ],
        ),
      ),
    );
  }
}
