import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'di/service_locator.dart';
import 'main_viewmodel.dart';

void main() {
  setupLocator();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GetIt.I.get<MainViewModel>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      /// TODO: move title to string res
      home: const MyHomePage(title: 'Contact Us'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
        builder: (context, myNotifier, child)
    {
      btnOnClick() {
        myNotifier.sendData(onSuccess: (){
          /// TODO: move suc message to string res
          showSuccessMessage(context, "success");
        }, onError: (errorMessage){
          showErrorMessage(context, errorMessage);
        });
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        color: Colors.yellow, // Жовте кільце
                        child: const Icon(
                          Icons.lock_open, // Іконка - відкритий замок
                          size: 24.0, // Розмір іконки
                          color: Colors.orange, // Оранжева іконка
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextField(
                          controller: myNotifier.nameInputController,

                          /// TODO: move title to string res
                          decoration: const InputDecoration(
                            hintText: "Name",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        color: Colors.yellow, // Жовте кільце
                        child: const Icon(
                          Icons.lock_open, // Іконка - відкритий замок
                          size: 24.0, // Розмір іконки
                          color: Colors.orange, // Оранжева іконка
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextField(
                          controller: myNotifier.emailInputController,

                          /// TODO: move title to string res
                          decoration: InputDecoration(
                              hintText: "Email",

                              /// TODO: move error text to string res
                              errorText: myNotifier.isValidEmail
                                  ? null
                                  : 'Please enter a valid email address'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        color: Colors.yellow, // Жовте кільце
                        child: const Icon(
                          Icons.lock_open, // Іконка - відкритий замок
                          size: 24.0, // Розмір іконки
                          color: Colors.orange, // Оранжева іконка
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextField(
                            controller: myNotifier.messageInputController,

                            /// TODO: move title to string res
                            decoration: const InputDecoration(hintText: "Message")),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.purple),
                      ),
                      onPressed: myNotifier.isSendEnabled ? btnOnClick : null,
                      child: Text(
                        /// TODO: move btn text to string res
                        myNotifier.isLoading ? "please wait..." : "Send",
                        style: TextStyle(color: myNotifier.btnTextColor),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
