import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/classes/emailNum_indicator.dart';
import 'package:smartrent_upahan/src/components/main_components/login_page.dart';
import '../../classes/landlord.dart';
import '../../classes/property.dart';
import '../../classes/tenant.dart';
import '../../database/firebase_db.dart';
import '../../utils/design/images.dart';
import '../../utils/design/sizes.dart';
import '../../utils/design/text_strings.dart';
import '../form_widget/form_header_widget.dart';

class SignUpFormGoogle extends StatefulWidget {
  const SignUpFormGoogle({
    required this.userEmail,
    super.key,
  });

  final String? userEmail;

  @override
  State<SignUpFormGoogle> createState() => _SignUpFormGoogleState();
}

class _SignUpFormGoogleState extends State<SignUpFormGoogle> {

  FirebaseDB firebase = FirebaseDB();
  final _formkey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _contactinfoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertyAddressController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose(){
    _usernameController.dispose();
    _contactinfoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _propertyNameController.dispose();
    _propertyAddressController.dispose();
    super.dispose();
  }

  String _selectedRole = 'Tenant'; // Default role is Tenant

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -40,
              left: -160,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -120,
              left: -50,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: -150,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 50,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -50,
              left: 170,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),
            Positioned(
              top: -40,
              left: -260,
              child: Container(
                width: MediaQuery.of(context).size.width + 100,
                height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue[200],
                ),
              ),
            ),

            // Cloud shape at the bottom
            Positioned(
              bottom: -150,
              right: -50,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150.0),
                  topRight: Radius.circular(150.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width + 100,
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[200],
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  const FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: tSignUpTitle,
                    subTitle: tSignUpSubTitle2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRole = newValue!;
                              });
                            },
                            items: <String>['Tenant', 'Landlord'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: tFormHeight - 20),

                          if (_selectedRole == 'Tenant')
                            _buildTenantFields(),
                          if (_selectedRole == 'Landlord')
                            _buildLandlordFields(),

                          const SizedBox(height: tFormHeight - 20),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                String name = "", contactInfo = "", email = "", password = "", confPass = "", startDate = "", propertyName = "", propertyAdd = "";
                                EmailNumberIndicator emNumInd;

                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    name = _usernameController.text;
                                    contactInfo = _contactinfoController.text;
                                    email = widget.userEmail!;
                                    password = _passwordController.text;

                                    if(_selectedRole == 'Landlord'){
                                      propertyName = _propertyNameController.text;
                                      propertyAdd = _propertyAddressController.text;
                                    }

                                  });
                                  // Perform sign up based on selected role
                                  // Perform sign up based on selected role
                                  if (_selectedRole == 'Tenant') {
                                    Tenant tenant = Tenant(
                                      name: name,
                                      contactInfo: contactInfo,
                                      email: email,
                                      password: password,
                                      boardingHouse: "",
                                      status: 3,
                                      startDate: DateTime.now(),
                                      currentDate: DateTime.now(),
                                    );

                                    emNumInd = EmailNumberIndicator(email: email, userIndicator: 0);
                                    tenant.createTenantData(emNumInd);

                                  } else if (_selectedRole == 'Landlord') {
                                    Property property = Property(propertyName: propertyName, address: propertyAdd);

                                    Landlord landlord = Landlord(
                                        name: name,
                                        contactInfo: contactInfo,
                                        email: email,
                                        password: password,
                                        property: property
                                    );

                                    emNumInd = EmailNumberIndicator(email: email, userIndicator: 1);
                                    landlord.createLandlordData(emNumInd);
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginPage();
                                        }),
                                  );

                                }
                              },
                              child: Text(tCreateAcc.toUpperCase()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenantFields() {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Tenant Full Name'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),
        // Add other tenant-specific text form fields here
        TextFormField(
          controller: _contactinfoController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value){
            if (value!.isEmpty) {
              return 'Please enter a contact number';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text(tPhoneNo),
            suffixIcon: Icon(Icons.phone_outlined),
          ),
        ),

        const SizedBox(height: tFormHeight - 20),

        // will be automatic since google sign in
        TextFormField(
          enabled: false,
          initialValue: widget.userEmail,
          readOnly: true,
          decoration: InputDecoration(
            label: Text(tEmailAdd),
            suffixIcon: Icon(Icons.email_outlined),
          ),
        ),

        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value){
            if (value!.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: tPassword,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              child: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: _obscurePassword, // Toggle the visibility of the entered text
        ),

        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _confirmPasswordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value){
            if (value!.isEmpty) {
              return 'Please confirm password';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: tConfirmPassword,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              child: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: _obscureConfirmPassword, // Toggle the visibility of the entered text
        ),

        const SizedBox(height: tFormHeight - 20),
      ],
    );
  }

  Widget _buildLandlordFields() {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Landlord Full Name'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),
        // Add other landlord-specific text form fields here
        TextFormField(
          controller: _contactinfoController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value){
            if (value!.isEmpty) {
              return 'Please enter a contact number';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text(tPhoneNo),
            suffixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _propertyNameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter boarding house name';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Boarding House Name'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),

        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _propertyAddressController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter boarding house address';
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text('Boarding House Address'),
            suffixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          initialValue: widget.userEmail,
          enabled: false,
          readOnly: true,
          decoration: InputDecoration(
            label: Text(tEmailAdd),
            suffixIcon: Icon(Icons.email_outlined),
          ),
        ),

        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value){
            if (value!.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: tPassword,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              child: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: _obscurePassword, // Toggle the visibility of the entered text
        ),

        const SizedBox(height: tFormHeight - 20),

        TextFormField(
          controller: _confirmPasswordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value){
            if (value!.isEmpty) {
              return 'Please confirm password';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: tConfirmPassword,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              child: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: _obscureConfirmPassword, // Toggle the visibility of the entered text
        ),

        const SizedBox(height: tFormHeight - 20),
      ],
    );
  }

 /* Future<String?> getUserPassword(String userEmail) async {
    if(await FirebaseDB.getUserSelection(userEmail) == 0){
      final tenantCollection = FirebaseFirestore.instance.collection('tenant');
      final snapshot = await tenantCollection.where('email', isEqualTo: userEmail).get();

      return snapshot.docs.map((e) => Tenant.fromSnapshot(e)).single?.password;
    } else{
      final landlordCollection = FirebaseFirestore.instance.collection('landlord');
      final snapshot = await landlordCollection.where('email', isEqualTo: userEmail).get();

      return snapshot.docs.map((e) => Landlord.fromSnapshot(e)).single?.password;
    }
  }*/
}


