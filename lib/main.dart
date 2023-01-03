import 'package:flutter/material.dart';
import 'package:form_validation_with_mixin/mixins/validations.dart';
import 'package:lottie/lottie.dart';

void main(){
  runApp(
      const MaterialApp(
        title: 'Forms',
        home: CreateForm(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> with ValidationsMixin {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _name, _phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Lottie.asset(
                      'assets/lotties/background.json',
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              SafeArea(
                child: Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Lottie.asset(
                            'assets/lotties/form_validation.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 2,
                                MediaQuery.of(context).size.height / 14
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)
                            ),
                          ),
                            onPressed: (){
                            showModalBottomSheet(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.9,
                                maxHeight: MediaQuery.of(context).size.height / 2.7
                              ),
                              backgroundColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                context: context,
                                builder: (context){
                                  return Form(
                                    key: _formKey,
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: TextFormField(
                                          controller: _nameController,
                                          onSaved: (valor) {
                                            _name = valor;
                                          },
                                          decoration: const InputDecoration(
                                              icon: Icon(Icons.person),
                                              hintText: "Enter your name",
                                              labelText: 'name'
                                          ),
                                          validator: (val) => combine([
                                              () => isNotEmpty(val),
                                              () => hasFiveChars(val),
                                            ]
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30,
                                            0,
                                            30,
                                            20
                                        ),
                                        child: TextFormField(
                                          controller: _phoneController,
                                          onSaved: (value) {
                                            _phone = value;
                                          },
                                          decoration: const InputDecoration(
                                              icon: Icon(Icons.phone),
                                              hintText: "Enter your phone",
                                              labelText: 'phone'
                                          ),
                                          validator: (value) => isNotEmpty(value, 'Enter your phone'),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(40)
                                          ),
                                          minimumSize: Size(
                                              MediaQuery.of(context).size.width / 2,
                                              MediaQuery.of(context).size.height / 14
                                          ),
                                        ),
                                        onPressed: (){
                                          if (_formKey.currentState?.validate() == true){
                                            _formKey.currentState?.save();
                                          }
                                        },
                                        child: const Text("Submit"),
                                      ),
                                    ],
                                    ),
                                  );
                                }
                            );
                            },
                            child: const Text(
                              "Open",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

