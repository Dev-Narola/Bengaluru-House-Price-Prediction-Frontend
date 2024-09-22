// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:bhpp/constant.dart';
import 'package:bhpp/controller.dart';
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
  String dropdownValue = "Select Location";
  final TextEditingController _squareFeetController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _bhkController = TextEditingController();
  final ApiController _apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(),
            SizedBox(height: 14.h),
            _buildLabel("Square Feet area"),
            _buildTextField(
              controller: _squareFeetController,
              hintText: "Enter square feet",
              icon: const Icon(LineIcons.mapMarker),
            ),
            SizedBox(height: 14.h),
            _buildLabel("No. of Bathrooms"),
            _buildTextField(
              controller: _bathroomsController,
              hintText: "Enter number of Bathrooms",
              icon: const Icon(LineIcons.bath),
            ),
            SizedBox(height: 14.h),
            _buildLabel("Bedroom Hall Kitchen"),
            _buildTextField(
              controller: _bhkController,
              hintText: "Enter number of BHK",
              icon: const Icon(LineIcons.restroom),
            ),
            SizedBox(height: 44.h),
            _buildPredictButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return ReusableText(
      text: text,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Select the Location"),
        SizedBox(height: 14.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.1, color: Kdark),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 2.h),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(LineIcons.mapAlt, color: Kdark),
              dropdownColor: Koffwhite,
              elevation: 16,
              style: const TextStyle(color: Kdark),
              underline: Container(height: 2, color: Colors.transparent),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: locationList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: ReusableText(text: value, fontSize: 14),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Icon icon,
  }) {
    return ReusableTextfield(
      hintText: hintText,
      controller: controller,
      textInputType: TextInputType.number,
      prefixIcon: icon,
    );
  }

  Widget _buildPredictButton(BuildContext context) {
    return ReusableButton(
      onTap: () async {
        if (_isFormValid()) {
          await _handlePrediction(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill all the fields")),
          );
        }
      },
      content: "P R E D I C T",
      textColor: Koffwhite,
      backgroundColor: Kdark,
      btnHeight: 40.h,
    );
  }

  bool _isFormValid() {
    return dropdownValue != "Select Location" &&
        _squareFeetController.text.isNotEmpty &&
        _bathroomsController.text.isNotEmpty &&
        _bhkController.text.isNotEmpty;
  }

  Future<void> _handlePrediction(BuildContext context) async {
    try {
      final prediction = await _apiController.predictHousePrice(
        location: dropdownValue,
        sqft: _squareFeetController.text,
        bhk: _bhkController.text,
        bath: _bathroomsController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Predicted Price: ₹${(prediction['Price']! * 100000).toStringAsFixed(2)}",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
