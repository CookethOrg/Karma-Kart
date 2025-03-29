import 'package:flutter/material.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:radix_icons/radix_icons.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF020315),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 60.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildTopBar(),
              SizedBox(height: 30),
              _buildProfileHeader(),
              SizedBox(height: 12),
              _buildProfileSubtitle(),
              SizedBox(height: 30),
              _buildProfilePhoto(),
              SizedBox(height: 16),
              _buildUserName(),
              SizedBox(height: 8),
              _buildEmail(),
              SizedBox(height: 16),
              _buildBioInfo(),
              SizedBox(height: 20),
              _buildWebsites(),
              SizedBox(height: 24),
              _buildSkillTags(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff020315), Color(0xff1d1f2e)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(28.sp),
          child: Icon(RadixIcons.Pencil_2, color: Colors.white, size: 48.sp,),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff020315), Color(0xff1d1f2e)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(28.sp),
          child: Icon(RadixIcons.Exit, color: Colors.white, size: 48.sp,),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Text(
      "Your Profile",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProfileSubtitle() {
    return Text(
      "Find details about your profile",
      style: TextStyle(color: Color(0xFF656678), fontSize: 14),
    );
  }

  Widget _buildProfilePhoto() {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Center(
      child: Text(
        "Daniel Rodri",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Center(
      child: Text(
        "danielrodri@gmail.com",
        style: TextStyle(color: Color(0xFF656678), fontSize: 14),
      ),
    );
  }

  Widget _buildBioInfo() {
    return Center(
      child: Text(
        "Designer • Ex-UI/UX Intern at Kivio • Org @KolkataFOSS • Building @CookethFlow• Building@Note_X_ • Org@Rebase_01",
        textAlign: TextAlign.center,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
      ),
    );
  }

  Widget _buildWebsites() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "danielrodri.framer.website",
          style: TextStyle(color: Color(0xFF874FFF), fontSize: 12),
        ),
        SizedBox(width: 16),
        Text(
          "danielrodri.x.com",
          style: TextStyle(color: Color(0xFF874FFF), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSkillTags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSkillTag("UI/UX"),
        SizedBox(width: 12),
        _buildSkillTag("Development"),
        SizedBox(width: 12),
        _buildSkillTag("Flutter"),
      ],
    );
  }

  Widget _buildSkillTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF0F1120),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}