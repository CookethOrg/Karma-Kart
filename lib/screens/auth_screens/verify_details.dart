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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              'Verify Your Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  width: 50,
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color:
                        index <= auth.pageIndex
                            ? Colors.white
                            : const Color(0xFF0F1120),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Page 4 of 4',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildProfilePicture() {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Color(0xFF0F1120),
        backgroundImage: auth.image != null ? FileImage(auth.image!) : null,
        child:
            auth.image == null
                ? Icon(Icons.person, size: 50, color: Color(0xFF656678))
                : null,
      );
    }

    Widget buildDetailRow(
      String label,
      TextEditingController controller,
      String defaultValue,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                defaultValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                'Generated skill tags',
                style: TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 12,
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
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0F1120),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                'Bio',
                style: TextStyle(
                  color: Color(0xFF656678),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                auth.bioController.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
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
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF101123), width: 1),
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
                SizedBox(width: 12),
                Expanded(
                  child: buildButton(
                    text: 'Done',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () async {
                      auth.setLoading(true);
                      String res = await auth.createNewUser(
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
                          padding: const EdgeInsets.symmetric(horizontal: 37),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildHeader(),
                                  SizedBox(height: 20),
                                  buildProfilePicture(),
                                  SizedBox(height: 24),
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
