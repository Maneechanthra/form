import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form/model/profile.dart';
import 'package:form/screen/home.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  Profile profile = new Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text("error")),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(
              "สมัครสมาชิก",
              style: TextStyle(fontSize: 18),
            )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "อีเมล",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'กรุณาป้อนอีเมล'),
                            EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง')
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) {
                            profile.email = email;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "รหัสผ่าน",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: 'กรุณาป้อนรหัสผ่าน'),
                        obscureText: true,
                        onSaved: (password) {
                          profile.password = password;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          formkey.currentState!.save();

                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: profile.email.toString(),
                                      password: profile.password.toString())
                                  .then(
                                    (value) => {
                                      formkey.currentState!.reset(),
                                      Fluttertoast.showToast(
                                          msg: "สร้างบัญชีสำเร็จ"),
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePgae()))
                                    },
                                  );
                            } on FirebaseAuthException catch (e) {
                              String msg = "";
                              if (e.code == 'email-already-in-use') {
                                msg = "อีเมลซ้ำ่ไม่สามารถใช้งานได่";
                              } else if (e.code == 'weak-password') {
                                msg =
                                    "รหัสผ่านต้องมีความยาวเกิน 6 ตัวอักษรขึ้นไป";
                              } else {
                                msg = e.message.toString();
                                Fluttertoast.showToast(msg: msg);
                              }
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Text(
                              "ลงทะเบียน",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
