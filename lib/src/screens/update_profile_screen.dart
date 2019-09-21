import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/validator_util.dart';
import '../providers/user_provider.dart';

class UpdateProfileScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Update profile')),
        body: UpdateProfileScreenContent(),
    );
  }
}

class UpdateProfileScreenContent extends StatefulWidget {
  @override
  _UpdateProfileScreenContentState createState() => _UpdateProfileScreenContentState();
}

class _UpdateProfileScreenContentState extends State<UpdateProfileScreenContent> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _userData = {
    'displayName': '',
    'bio': '',
  };
  User _currentUser;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    _setUserState();

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _currentUser.displayName,
                    decoration: InputDecoration(
                      labelText: 'Username', 
                      hintText: 'Update your username'
                    ),
                    keyboardType: TextInputType.text,
                    validator: Validator.validateName,
                    onSaved: (value) {
                      _userData['displayName'] = value;
                    }
                  ),
                  TextFormField(
                    initialValue: _currentUser.bio,
                    decoration: InputDecoration(
                      labelText: 'Biography', 
                      hintText: 'Update your biography'
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    validator: Validator.validateName,
                    onSaved: (value) {
                      _userData['bio'] = value;
                    }
                  ),
                  RaisedButton(
                    child: Text('Update profile'),
                    onPressed: _submit,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  ),
                ]
              ),
            )
          )
        )
      ]
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      User updatedUser = User(
        userId: _currentUser.userId,
        email: _currentUser.email,
        displayName: _userData['displayName'],
        bio: _userData['bio'],
      );

      UserProvider.updateUserInDatabase(updatedUser);
      UserProvider.setUserOnDevice(updatedUser);

      setState(() {
        _currentUser = updatedUser;
      });

      _showSubmitDialog();
    } on Exception catch (error) {
      throw error;
    }
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success'),
        content: Text('Your profile has been updated succesfully'),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _setUserState() async {
    User user = await UserProvider.getUserFromDevice();
    setState(() {
      _currentUser = user;
    });
  }
}