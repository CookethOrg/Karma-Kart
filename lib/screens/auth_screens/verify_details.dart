import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/dashboard_page.dart';
import 'package:provider/provider.dart';

class VerifyDetails extends StatelessWidget {
  VerifyDetails({super.key});
  final _formKey = GlobalKey<FormState>();

  final List<String> _skillTags = ['UI/UX', 'Development', 'Flutter'];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider>(context, listen: false);
    Widget buildHeader() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            Text(
              'Verify Your Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  width: 100.w,
                  height: 3.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color:
                        index <= auth.pageIndex
                            ? Colors.white
                            : const Color(0xFF0F1120),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Page 4 of 4',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildProfilePicture() {
      return CircleAvatar(
        radius: 100.r,
        backgroundColor: Color(0xFF0F1120),
        backgroundImage: auth.image != null ? FileImage(auth.image!) : null,
        child:
            auth.image == null
                ? Icon(Icons.person, size: 30.h, color: Color(0xFF656678))
                : null,
      );
    }

    Widget buildDetailRow(
      String label,
      TextEditingController controller,
      String defaultValue,
    ) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              child: Text(
                label,
                style: TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                defaultValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildSkillTags() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.w,
              child: Text(
                'Generated skill tags',
                style: TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      _skillTags
                          .map(
                            (tag) => Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.h,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0F1120),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildBioSection() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              child: Text(
                'Bio',
                style: TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                auth.bioController.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildButton({
      required String text,
      required Color backgroundColor,
      required Color textColor,
      required VoidCallback onPressed,
    }) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 25.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    Widget buildBottomSection() {
      return Consumer<AuthenticationProvider>(
        builder: (context, auth, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF101123), width: 1.w),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: buildButton(
                    text: 'Back',
                    backgroundColor: Color(0xFF101123),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: buildButton(
                    text: 'Done',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () async {
                      auth.setLoading(true);
                      String res = await auth.createNewUser(
                        // imageFile: auth.image!,
                        userName: auth.usernameController.text,
                        email: auth.emailController.text,
                        password: auth.passwordController.text,
                        name: auth.firstNameController.text,
                        socialLinks: [
                          auth.link1Controller.text,
                          auth.link2Controller.text,
                          auth.link3Controller.text,
                        ],
                        bio: auth.bioController.text,
                      );
                      auth.setLoading(false);
                      if (res == "Signed Up Successfully") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account created successfully!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                          ),
                        );
                      } else {
                        // Show error message
                        print(res);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $res'),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Consumer<AuthenticationProvider>(
      builder: (context, pv, child) {
        return WillPopScope(
          onWillPop: () async {
            pv.updatePageIndex(2);
            Navigator.pop(context, pv.pageIndex);
            return false;
          },
          child: Scaffold(
            body: SafeArea(
              child: Container(
                color: const Color(0xFF020315),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1000.w), // 428
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55.w),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildHeader(),
                                  SizedBox(height: 20.h),
                                  buildProfilePicture(),
                                  SizedBox(height: 24.h),
                                  buildDetailRow(
                                    'Name',
                                    pv.firstNameController,
                                    pv.firstNameController.text,
                                  ),
                                  buildDetailRow(
                                    'Username',
                                    pv.usernameController,
                                    pv.usernameController.text,
                                  ),
                                  buildDetailRow(
                                    'Email',
                                    pv.emailController,
                                    pv.emailController.text,
                                  ),
                                  buildSkillTags(),
                                  buildDetailRow(
                                    'Links',
                                    pv.link1Controller,
                                    pv.link1Controller.text,
                                  ),
                                  buildBioSection(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        buildBottomSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
