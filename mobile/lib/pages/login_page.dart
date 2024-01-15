import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/admin_page.dart';
import 'package:mobile/pages/client_page.dart';
import 'package:mobile/services/admin_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AdminService _adminService = AdminService(); // Instance of AdminService

  void _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // After successful login, check if the user is an admin
      bool isAdmin = await _adminService.checkAdminStatus();

      if (isAdmin) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ClientPage()));
      }
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(context, e.message ?? 'Login failed');
    } catch (e) {
// Handle any other errors
      _showErrorSnackBar(context, 'Failed to check admin status');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _login(context),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
    );
  }
}
