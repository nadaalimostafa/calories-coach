import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  User? user;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user!.displayName ?? '';
      _emailController.text = user!.email ?? '';
    }
  }

  Future<void> reauthenticateUser(String password) async {
    try {
      if (user!.providerData[0].providerId != 'password') {
        throw Exception("email and password not used .");
      }

      final userCredential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user!.reauthenticateWithCredential(userCredential);
    } catch (e) {
      throw Exception("  ${e.toString()}");
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_emailController.text != user!.email) {
          String password = await _showPasswordDialog();

          await reauthenticateUser(password);
        }

        await user!.updateProfile(displayName: _nameController.text);
        if (_emailController.text != user!.email) {
          await user!.updateEmail(_emailController.text);
        }

        await user!.reload();
        user = FirebaseAuth.instance.currentUser;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('profile updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
        );
      }
    }
  }
  Future<String> _showPasswordDialog() async {
    String password = '';
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter your password'),
          content: TextField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            decoration: InputDecoration(hintText: 'Enter password'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(password);
              },
              child: Text('ok'),
            ),
          ],
        );
      },
    ).then((value) => value ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: EdgeInsets.only(
        left: 22,
        right: 22,
        top: 22,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your Name ';
                }
                return null;
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Enter Email';
                }
                return null;
              },
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.01),
            TextButton(
              onPressed: _updateProfile,
              child: Text(
                  'OK',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

