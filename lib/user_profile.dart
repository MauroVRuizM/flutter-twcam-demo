import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.title});

  final String title;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  String _userName = '';

  void saveUserName(String value) {
    setState(() {
      _userName = value;
    });
  }

  @override
  void dispose() {
    //* Clean up the controller when the widget is removed from the
    //* widget tree.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.symmetric(
                vertical: 20
              )),
              Text(
                'Bienvenido ${_userName.isEmpty ? 'Invitado' : _userName}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text('Nombre de usuario'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20)
                  ),
                  controller: textController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor escriba un nombre';
                    }
                    return null;
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(
                vertical: 10
              )),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nombre de usuario actualizado')),
                    );
                    saveUserName(textController.text);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
