import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.32,
                color: const Color(0XFF54408C),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.05),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Color(0xffffffff)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Order History',
                                style: GoogleFonts.openSans(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0XFFFAFAFA),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        'Help Center',
                        style: GoogleFonts.openSans(
                          fontSize: width * 0.055,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Tell us how we can help 👋',
                        style: GoogleFonts.roboto(
                          fontSize: width * 0.04,
                          color: const Color(0XFFCABCEF),
                        ),
                      ),
                      Text(
                        'Chapter are standing by for service & support!',
                        style: GoogleFonts.roboto(
                          fontSize: width * 0.04,
                          color: const Color(0XFFCABCEF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: width * 0.05,
                  runSpacing: height * 0.02,
                  children: [
                    _buildContactCard(
                      width: width,
                      iconPath: 'assets/images/email.svg',
                      title: 'Email',
                      subtitle: 'Send to your email',
                      onTap: () async {
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: 'mariamaldorghamy@gmail.com',  
                        );
                        await _launchUrl(emailUri);
                      },
                    ),
                    _buildContactCard(
                      width: width,
                      iconPath: 'assets/images/Phone-Fill.svg',
                      title: 'Phone Number',
                      subtitle: 'Send to your phone',
                      onTap: () async {
                        final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: '+201271565240',  
                        );
                        await _launchUrl(phoneUri);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required double width,
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.42,
        height: width * 0.42,
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          border: Border.all(width: 2.5, color: const Color(0xffF5F5F5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.04, top: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width * 0.12,
                    height: width * 0.12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(iconPath, width: width * 0.07),
                ],
              ),
              SizedBox(height: width * 0.04),
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w600,
                  color: const Color(0XFF121212),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.roboto(
                  fontSize: width * 0.033,
                  fontWeight: FontWeight.w400,
                  color: const Color(0XFFA6A6A6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint('Could not launch $uri');
    }
  }
}