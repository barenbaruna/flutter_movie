import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/ui/film/master_film.dart';

import '../../../bloc/user/login/login_user_bloc.dart';
import '../register/register_user.dart';
import 'package:flutter_movie/ui/custom_colors.dart';

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: CustomColors.primary1,
      body: BlocProvider(
        create: (context) => LoginUserBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * .15),
                  const Text(
                    'Welcome,',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white
                    ),
                  ),
                  SizedBox(height: screenHeight * .01),
                  Text(
                    'Sign in to continue!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                  SizedBox(height: screenHeight * .12),
                  TextFormField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * .075),
                  BlocConsumer<LoginUserBloc, LoginUserState>(
                    listener: (context, state) {
                      if (state is LoginUserSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.loginUserResponse.message)));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilmMasterPage()),
                        );
                      } else if (state is LoginUserError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Username atau Password anda salah')));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginUserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginUserBloc>().add(
                                    LoginVisitorsEvent(
                                        username:
                                        usernameController.text.toString(),
                                        password:
                                        passwordController.text.toString()));
                              }
                            },
                            child: Text('Login'),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                              backgroundColor: MaterialStateProperty.all(CustomColors.accentColor),
                            ),
                          ),
                          SizedBox(height: screenHeight * .200),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Belum punya akun?'),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterUserPage()),
                                    );
                                  },
                                  child: Text('Register',
                                  style: TextStyle(
                                    color: Color(0xFF4A5C9B),
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
