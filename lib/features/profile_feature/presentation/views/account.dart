import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books/custom/custom_textField.dart';
import 'package:books/features/profile_feature/presentation/manager/profile_cubit.dart';
import 'package:books/features/profile_feature/presentation/manager/profile_state.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController password = TextEditingController();

    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: height * 0.12,
          title: Center(
            child: Text(
              'My Account',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w700,
                fontSize: width * 0.05,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final cubit = context.watch<ProfileCubit>();
                    File? image;

                    if (state is ProfileImageChanged) {
                      image = state.image;
                    } else {
                      image = cubit.image;
                    }

                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: image != null
                              ? Image.file(
                                  image,
                                  width: width * 0.35,
                                  height: width * 0.35,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/account.png',
                                  width: width * 0.35,
                                  height: width * 0.35,
                                ),
                        ),
                        SizedBox(height: height * 0.001),
                        InkWell(
                          onTap: () => cubit.pickImage(),
                          child: Text(
                            'Change Picture',
                            style: GoogleFonts.roboto(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w800,
                              color: const Color(0XFF54408C),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: height * 0.05),
                CustomTextfield(
                  controller: name,
                  hintText: 'John',
                  labelText: 'Name',
                ),
                CustomTextfield(
                  controller: email,
                  hintText: 'johndoe@gmail.com',
                  labelText: 'Email',
                ),
                CustomTextfield(
                  controller: phone,
                  hintText: '(+1) 234 567 890',
                  labelText: 'Phone Number',
                  prefixIcon: Icons.call_outlined,
                ),
                CustomTextfield(
                  controller: password,
                  hintText: 'your password',
                  labelText: 'Password',
                  obscureText: true,
                  suffixIcon: Icons.visibility_off_outlined,
                ),
                SizedBox(height: height * 0.03),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF54408C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
