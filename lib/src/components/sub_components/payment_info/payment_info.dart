import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../widgets/common_widget/secondary_button.dart';

import '../../../utils/design/color_extension.dart';
import '../../../widgets/common_widget/item_row.dart';

class PaymentInfo extends StatefulWidget {
  final Map sObj;
  const PaymentInfo({super.key, required this.sObj});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.secondaryG,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff282833).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: 
                    Column(
                      children: [
                        Container(
                          height: media.width * 0.9,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Image.asset("assets/img/dorp_down.png",
                                        width: 20,
                                        height: 20,
                                        color: TColor.gray),
                                  ),
                                  Text(
                                    "Payment info",
                                    style: TextStyle(
                                        color: TColor.gray, fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Image.asset("assets/img/Trash.png",
                                        width: 25,
                                        height: 25,
                                        color: TColor.gray),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Image.asset(
                                widget.sObj["icon"],
                                width: media.width * 0.25,
                                height: media.width * 0.25,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.sObj["name"],
                                style: TextStyle(
                                    color: TColor.gray70,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "\$${widget.sObj["price"]}",
                                style: TextStyle(
                                    color: TColor.gray60,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                   border: Border.all(
                                color: TColor.border.withOpacity(0.1),
                              ),
                                  color: TColor.gray60.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    ItemRow(
                                      title: "Name",
                                      value: widget.sObj["name"],
                                    ),
                                    ItemRow(
                                      title: "Description",
                                      value: "Music app",
                                    ),
                                    ItemRow(
                                      title: "Category",
                                      value: "Entertainment",
                                    ),
                                    ItemRow(
                                      title: "First payment",
                                      value: "08.07.2023",
                                    ),
                                    ItemRow(
                                      title: "Reminder",
                                      value: "Never",
                                    ),
                                    ItemRow(
                                      title: "Currency",
                                      value: "Php (\₱)",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SecondaryButton(title: "Save", onPressed: () {})
                            ],
                          ),
                        )
                      ],
                    ),
                    
                 
              ),

              Container(
                margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
                height: media.width * 0.9 + 15,
                alignment: Alignment.bottomCenter,
                child: Row(children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: TColor.secondaryG,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Expanded(
                      child: DottedBorder(
                    dashPattern: const [5, 10],
                    padding: EdgeInsets.zero,
                    strokeWidth: 3,
                    child: SizedBox(
                      height: 0,
                    ),
                    radius: const Radius.circular(16),
                    color: TColor.gray,
                  )),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: TColor.secondaryG,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
