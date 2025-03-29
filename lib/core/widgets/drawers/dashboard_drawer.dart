import 'package:flutter/material.dart';
import 'package:karmakart/core/services/supabase_service.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/auth_screens/log_in.dart';
import 'package:provider/provider.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildDrawerItem(IconData icon, String title) {
      return ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        onTap: () {
          // Handle navigation
        },
      );
    }

    return Consumer2<AuthenticationProvider, SupabaseService>(
      builder: (context, auth, supa, child) {
        return Drawer(
          backgroundColor: Color(0xFF0F1120),
          child: ListView(
            // Ensures proper scrolling
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF0F1120)),
                accountName: Text(
                  auth.firstNameController.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  auth.emailController.text,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF0F1120),
                  backgroundImage:
                      auth.image != null ? FileImage(auth.image!) : null,
                  child:
                      auth.image == null
                          ? Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF656678),
                          )
                          : null,
                ),
                otherAccountsPictures: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),

              buildDrawerItem(Icons.settings, 'Account Settings'),
              buildDrawerItem(Icons.support_agent, 'Help & Support'),
              buildDrawerItem(Icons.privacy_tip, 'Privacy Policy'),
              buildDrawerItem(Icons.article, 'Terms And Conditions'),
              buildDrawerItem(Icons.info, 'About'),

              Spacer(),

              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  supa.logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LogIn(),));
                },
              ),
              SizedBox(height: 16), // Adds some spacing at the bottom
            ],
          ),
        );
      },
    );
  }
}
