import 'package:flutter/material.dart';
import 'package:smartrent_upahan/src/utils/design/color_extension.dart';

import '../../components/sub_components/settings_view.dart';
import '../../widgets/common_widget/status_button.dart';


class TenantManagement extends StatefulWidget {
  const TenantManagement({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TenantManagement> createState() => _TenantManagementState();
}

class _TenantManagementState extends State<TenantManagement> {
  List<Tenant> tenants = [
    Tenant(name: 'John Doe', property: 'Apartment A'),
    Tenant(name: 'Jane Smith', property: 'House B'),
    Tenant(name: 'Michael Johnson', property: 'Condo C'),
    // Add more tenants as needed
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "👤  Tenant Management",
                    style: TextStyle(
                      color: TColor.gray80,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsView(),
                        ),
                      );
                    },
                    icon: Image.asset(
                      "assets/img/settings.png",
                      width: 25,
                      height: 25,
                      color: TColor.gray30,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: StatusButton(
                      title: "Total Properties",
                      value: "12",
                      statusColor: TColor.secondary,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: StatusButton(
                      title: "Total Tenants",
                      value: "90",
                      statusColor: TColor.primary10,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: StatusButton(
                      title: "Payment Received",
                      value: "\₱6969.99",
                      statusColor: TColor.secondaryG,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                "Tenants",
                style: TextStyle(
                  color: TColor.gray80,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: tenants.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 3.0,
                    child: ListTile(
                      title: Text(
                        tenants[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Property: ${tenants[index].property}'),
                      trailing: InkWell(
                        onTap: () {
                          _showEditTenantDialog(context, tenants[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditTenantDialog(BuildContext context, Tenant tenant) async {
    TextEditingController nameController = TextEditingController(text: tenant.name);
    TextEditingController propertyController = TextEditingController(text: tenant.property);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var media = MediaQuery.sizeOf(context);
        return AlertDialog(
          title: Text('Edit Tenant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(
                height: media.width * 0.04,
              ),
              TextField(
                controller: propertyController,
                decoration: InputDecoration(labelText: 'Property'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save edited tenant information here
                setState(() {
                  tenant.name = nameController.text;
                  tenant.property = propertyController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Tenant {
  late String name;
  late String property;

  Tenant({required this.name, required this.property});
}
