import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lesson1_5/core/app_router.dart';
import 'package:lesson1_5/di/injection_container.dart';
import 'package:lesson1_5/ui/bloc/auth_bloc.dart';
import 'package:lesson1_5/ui/bloc/auth_event.dart';
import 'package:lesson1_5/ui/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameControlle = TextEditingController();
  final _passwordControle = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose(){
    _usernameControlle.dispose();
    _passwordControle.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('вход'),),
      body: BlocListener<AuthBloc, Authstate>(
        listener: (context, state){
          if(state is AuthLoaded){
            context.go(AppRouter.home);
          }
          if(state is AuthError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(padding: EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, size: 80, color: Colors.blueGrey),
            SizedBox(height: 32),
            TextField(
              controller: _usernameControlle,
              decoration: InputDecoration(
                labelText: 'johnd',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _passwordControle,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'm38rmF\$',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: ()=> _obscurePassword =! _obscurePassword),
              ),
            ),
            SizedBox(height: 24),
            BlocBuilder<AuthBloc, Authstate>(
              builder: (context, state) {
                if(state is AuhtLoading){
                  return CircularProgressIndicator();
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    context.read<AuthBloc>().add(LoginEvent(
                      username: _usernameControlle.text.trim(), 
                      password: _passwordControle.text.trim()));
                  }, child: Text('войти')),
                );
              },
              ),
              
             
          ],
        ),),
        )  
      ),
    );
  }
}