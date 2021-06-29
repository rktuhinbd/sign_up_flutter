import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_flutter/src/bloc/sign_up_bloc.dart';
import 'package:sign_up_flutter/src/bloc/sign_up_event.dart';
import 'package:sign_up_flutter/src/bloc/sign_up_state.dart';
import 'package:sign_up_flutter/src/utils/toast.dart';
import 'package:sign_up_flutter/src/utils/validator.dart';

class SignUpScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String name;
  String email;
  String phone;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("My Flutter"),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (BuildContext context, SignUpState state) {
                if (state is LoadingSignUpState) {
                  return sign_up_widget(context);
                }
                return sign_up_widget(context);
              }),
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget sign_up_widget(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: nameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          validator: (value) => validateName(value),
          onChanged: (value) => {name = value},
          onSaved: (String value) {
            name = value;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_box_sharp),
              labelText: 'Full Name',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0)),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) => validateEmail(value),
          onChanged: (value) => {email = value},
          onSaved: (String value) {
            email = value;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              labelText: 'Email Address',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0)),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: (value) => validatePhone(value),
          onChanged: (value) => {phone = value},
          onSaved: (String value) {
            phone = value;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
              labelText: 'Phone Number',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0)),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: (value) => {password = value},
          onSaved: (String value) {
            password = value;
          },
          validator: (value) => validatePassword(value, null, false),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0)),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          obscureText: true,
          controller: confirmPasswordController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          onChanged: (value) => {confirmPassword = value},
          onSaved: (String value) {
            confirmPassword = value;
          },
          validator: (value) => validatePassword(value, password, true),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              labelText: 'Confirm Password',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0)),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
            width: double.infinity,
            height: 48,
            child: new MaterialButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  print("Name: " + nameController.text);
                  print("Email: " + emailController.text);
                  print("Phone: " + phoneController.text);
                  print("Password 1: " + passwordController.text);
                  print("Password 2: " + confirmPasswordController.text);

                  BlocProvider.of<SignUpBloc>(context).add(UserSignUpEvent());

                  showToast("Validation Completed.");
                } else
                  showToast("Validation Incomplete!");
              },
              color: Colors.amberAccent,
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ))
      ],
    ));
  }
}
