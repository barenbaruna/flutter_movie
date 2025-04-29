import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/bloc/user/register/register_user_bloc.dart';
import 'package:flutter_movie/ui/custom_colors.dart';
import 'package:flutter_movie/ui/user/login/login_user.dart';

class RegisterUserPage extends StatelessWidget {
  RegisterUserPage({super.key});

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecFirstName = TextEditingController();
  TextEditingController tecLastName = TextEditingController();
  TextEditingController tecPassword1 = TextEditingController();
  TextEditingController tecPassword2 = TextEditingController();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterUserBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * .08),
                  const Text(
                    'Create Account,',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white
                    ),
                  ),
                  SizedBox(height: screenHeight * .01),
                  Text(
                    'Sign up to get started!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                  SizedBox(height: screenHeight * .05),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: tecUsername,
                      decoration: InputDecoration(
                        label: Text('Username'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill your Username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: tecEmail,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill an Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: tecFirstName,
                      decoration: InputDecoration(
                        label: Text('First Name'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill your First Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: tecLastName,
                      decoration: InputDecoration(
                        label: Text('Last Name'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill your Last Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: tecPassword1,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill your Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: tecPassword2,
                      decoration: InputDecoration(
                        label: Text('Confirm your Password'),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-fill your Password';
                        } else if (value != tecPassword1.text) {
                          return 'Password not match';
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  BlocConsumer<RegisterUserBloc, RegisterUserState>(
                    listener: (context, state) {
                      if (state is RegisterUserSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.registerUserResponse.message)));
                      } else if (state is RegisterUserError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Username atau Email sudah ada')));
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterUserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is RegisterUserError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formState.currentState!.validate()) {
                              context.read<RegisterUserBloc>().add(
                                  CreateAuthorsEvent(
                                      username: tecUsername.text.toString(),
                                      email: tecEmail.text.toString(),
                                      isActive: true,
                                      isAuthors: true,
                                      firstName: tecFirstName.text.toString(),
                                      lastName: tecLastName.text.toString(),
                                      password1: tecPassword1.text.toString(),
                                      password2: tecPassword2.text.toString()));
                            }
                          },
                          child: Text('Register'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(CustomColors.accentColor),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sudah punya akun?'),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage()),
                            );
                          },
                          child: Text('Login',
                            style: TextStyle(
                              color: Color(0xFF4A5C9B),
                            ),),
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
