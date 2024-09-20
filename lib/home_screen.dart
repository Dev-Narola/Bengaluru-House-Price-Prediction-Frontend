// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:bhpp/constant.dart'; // Import the constant file
import 'package:bhpp/controller.dart'; // Import the controller
import 'package:bhpp/reusable_button.dart';
import 'package:bhpp/reusable_text.dart';
import 'package:bhpp/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = "Select Location"; // Initial value for the dropdown
  final TextEditingController _squareFeetController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _bhkController = TextEditingController();
  final ApiController _apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          backgroundColor: Koffwhite,
          centerTitle: true,
          title: const ReusableText(
            text: "Bengaluru House Price Prediction",
            color: Kdark,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReusableText(
                text: "Select the Location",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 14.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 1.1, color: Kdark),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 2.h),
                  child: DropdownButton<String>(
                    iconDisabledColor: Kgray,
                    dropdownColor: Koffwhite,
                    value: dropdownValue,
                    icon: const Icon(
                      LineIcons.mapAlt,
                      color: Kdark,
                    ),
                    elevation: 16,
                    style: const TextStyle(color: Kdark),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 8),
                          child: ReusableText(
                            text: value,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              const ReusableText(
                text: "Square Feet area",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 14.h),
              ReusableTextfield(
                hintText: "Enter sqare feet",
                controller: _squareFeetController,
                textInputType: TextInputType.number,
                prefixIcon: const Icon(LineIcons.mapMarker),
              ),
              SizedBox(height: 14.h),
              const ReusableText(
                text: "No. of Bathrooms",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 14.h),
              ReusableTextfield(
                hintText: "Enter number of Bathrooms",
                prefixIcon: const Icon(LineIcons.bath),
                textInputType: TextInputType.number,
                controller: _bathroomsController,
              ),
              SizedBox(height: 14.h),
              const ReusableText(
                text: "Bedroom Hall Kitchen",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 14.h),
              ReusableTextfield(
                hintText: "Enter number of bhk",
                prefixIcon: const Icon(LineIcons.restroom),
                controller: _bhkController,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 44.h),
              ReusableButton(
                onTap: () async {
                  if (dropdownValue != "Select Location" &&
                      _squareFeetController.text.isNotEmpty &&
                      _bathroomsController.text.isNotEmpty &&
                      _bhkController.text.isNotEmpty) {
                    // Make API call
                    try {
                      final prediction = await _apiController.predictHousePrice(
                        location: dropdownValue,
                        sqft: _squareFeetController.text,
                        bhk: _bhkController.text,
                        bath: _bathroomsController.text,
                      );

                      // Show the prediction result
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Predicted Price: ₹${(prediction['Price']! * 100000).toStringAsFixed(2)}"),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: $e"),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all the fields"),
                      ),
                    );
                  }
                },
                content: "P R E D I C T",
                textColor: Koffwhite,
                backgroundColor: Kdark,
                btnHeight: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
