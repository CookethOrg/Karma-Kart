import 'package:flutter/material.dart';
import 'package:karmakart/core/widgets/auth_tag_selector.dart';
import 'package:karmakart/models/form_field_data.dart';
import 'package:karmakart/providers/authentication_provider.dart';
import 'package:karmakart/screens/auth_screens/bio_profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillSelection extends StatelessWidget {
  // final int pageIndex;
  SkillSelection({super.key});
  final _formKey = GlobalKey<FormState>();

  final List<String> skillTags = [
    "Social Media Management",
    "SEO",
    "Google Ads",
    "Facebook Ads",
    "Instagram Marketing",
    "LinkedIn Marketing",
    "TikTok Ads",
    "Email Marketing",
    "Content Marketing",
    "Influencer Marketing",
    "PPC Advertising",
    "Marketing Strategy",
    "YouTube SEO",
    "Social Media Advertising",
    "Copywriting",
    "Copywriting",
    "Blog Writing",
    "Article Writing",
    "Technical Writing",
    "Proofreading",
    "Editing",
    "Resume Writing",
    "Cover Letter Writing",
    "Translation",
    "Spanish Translation",
    "French Translation",
    "German Translation",
    "Content Writing",
    "Ghostwriting",
    "Ebook Writing",
    "Logo Design",
    "Brand Identity",
    "Business Card Design",
    "Social Media Graphics",
    "Infographic Design",
    "Illustration",
    "Vector Art",
    "Poster Design",
    "Flyer Design",
    "Brochure Design",
    "Packaging Design",
    "UI/UX Design",
    "Web Design",
    "App Design",
    "T-Shirt Design",
    "Book Cover Design",
    "Character Design",
    "NFT Art",
    "Digital Art",
    "Explainer Video",
    "Whiteboard Animation",
    "2D Animation",
    "3D Animation",
    "Video Editing",
    "YouTube Video Editing",
    "TikTok Video Editing",
    "Video Ads",
    "Motion Graphics",
    "After Effects",
    "Premiere Pro",
    "Short-Form Video",
    "Animated Logo",
    "Cartoon Animation",
    "VFX",
    "Film Editing",
    "Commercial Video",
    "Product Video",
    "Drone Videography",
    "WordPress Development",
    "Shopify Development",
    "E-Commerce Website",
    "Frontend Development",
    "Backend Development",
    "React",
    "Vue.js",
    "JavaScript",
    "PHP",
    "Python Django",
    "Node.js",
    "Mobile App Development",
    "iOS App",
    "Android App",
    "Flutter",
    "Web App",
    "Bug Fixing",
    "Website Maintenance",
    "API Integration",
    "MERN Stack",
    "Laravel",
    "HTML CSS",
    "Responsive Design",
    "Web Hosting",
    "Database Management",
    "Business Plan",
    "Financial Consulting",
    "Market Research",
    "Virtual Assistant",
    "HR Consulting",
    "Recruitment",
    "Startup Consulting",
    "Sales Funnel",
    "Lead Generation",
    "Business Strategy",
    "Project Management",
    "Scrum Master",
    "Agile Coaching",
    "CRM Setup",
    "Zoho CRM",
    "Salesforce",
    "Process Automation",
    "Business Analysis",
    "Data Analysis",
    "Voiceover",
    "Commercial Voiceover",
    "Audiobook Narration",
    "Podcast Editing",
    "Audio Production",
    "Music Production",
    "Jingle Creation",
    "Sound Design",
    "Audio Mixing",
    "Audio Editing",
    "ASMR Voice",
    "IVR Recording",
    "Video Game Voice Acting",
    "Dubbing",
    "Data Entry",
    "Excel",
    "Google Sheets",
    "Web Research",
    "CRM Management",
    "Transcription",
    "Medical Transcription",
    "PDF to Word",
    "Data Scraping",
    "Data Cleaning",
    "Virtual Assistant",
    "Email Management",
    "Calendar Management",
    "Customer Support",
    "Chat Support",
    "AI Chatbot",
    "ChatGPT",
    "AI Content Writing",
    "AI Automation",
    "Zapier",
    "Make.com",
    "Python Automation",
    "Machine Learning",
    "Data Science",
    "AI Consulting",
    "Natural Language Processing",
    "AI Voice Cloning",
    "AI Image Generation",
    "Midjourney",
    "Stable Diffusion",
    "AI Business Solutions",
    "Predictive Analytics",
    "AI Integration",
    "Legal Consulting",
    "Contract Drafting",
    "Contract Review",
    "Bookkeeping",
    "QuickBooks",
    "Xero",
    "Tax Preparation",
    "Financial Audit",
    "Payroll Management",
    "Business Registration",
    "Trademark Registration",
    "Copyright Law",
    "Legal Writing",
    "Corporate Law",
    "Immigration Law",
    "Game Development",
    "Unity",
    "Unreal Engine",
    "3D Modeling",
    "Game Design",
    "AR Development",
    "VR Development",
    "Metaverse",
    "NFT Game",
    "Mobile Game",
    "Character Modeling",
    "Game Testing",
    "Level Design",
    "Pixel Art",
    "Roblox Development",
    "Amazon FBA",
    "Shopify Store",
    "Dropshipping",
    "Product Listing",
    "E-Commerce SEO",
    "WooCommerce",
    "Print on Demand",
    "Etsy Seller",
    "eBay Listing",
    "Inventory Management",
    "Order Fulfillment",
    "Product Photography",
    "E-Commerce Marketing",
    "Google Shopping Ads",
    "Facebook Shop Setup",
    "Shopify Automation",
    "POS System",
    "BigCommerce",
    "Cybersecurity",
    "Penetration Testing",
    "Ethical Hacking",
    "Network Security",
    "VPN Setup",
    "Firewall Configuration",
    "IT Support",
    "Tech Support",
    "System Administration",
    "Cloud Computing",
    "AWS",
    "Azure",
    "Google Cloud",
    "Linux Administration",
    "Blockchain Security",
    "Data Encryption",
    "Malware Removal",
    "Cyber Risk Assessment",
    "Incident Response",
    "Security Audit",
    "3D Floor Plan",
    "Architectural Rendering",
    "CAD Design",
    "Interior Design",
    "Home Staging",
    "Furniture Design",
    "Landscape Design",
    "Building Design",
    "Renovation Planning",
    "SketchUp",
    "AutoCAD",
    "Revit",
    "3D Modeling",
    "Real Estate Rendering",
    "HVAC Design",
    "Lighting Design",
    "Life Coaching",
    "Career Coaching",
    "Dating Profile Optimization",
    "Astrology",
    "Tarot Reading",
    "Fitness Coaching",
    "Nutritionist",
    "Meal Planning",
    "Personal Stylist",
    "Travel Planning",
    "Event Planning",
    "Wedding Planning",
    "Parenting Advice",
    "Meditation Coaching",
    "Holistic Healing",
    "Language Tutoring",
    "Math Tutoring",
    "CV Writing",
    "Interview Coaching",
    "Public Speaking",
  ];

  final List<FormFieldData> formFields = const [
    FormFieldData(
      id: 'skills',
      label: 'Skill Tags',
      required: true,
      placeholder: '',
    ),
    FormFieldData(
      id: 'links',
      label: 'Add links to your social media, portfolio etc.',
      required: false,
      placeholder: 'Enter link',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationProvider>(context, listen: false);
    Widget buildHeader() {
      return Column(
        children: [
          Text(
            'Skill Selection', // Fixed typo
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 364.w,
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Container(
                        height: 8.h,
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        decoration: BoxDecoration(
                          color:
                              index <= auth.pageIndex
                                  ? Colors.white
                                  : const Color(0xFF0F1120),
                          borderRadius: BorderRadius.circular(19.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Page ${auth.pageIndex + 1} of 4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
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
          height: 48.h,
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

    Widget buildFieldLabel(FormFieldData field) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: field.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (field.required)
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFF24822),
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      );
    }

    Widget buildTextField({
      required TextEditingController controller,
      required String placeholder,
      bool isPassword = false,
      String? Function(String?)? validator,
    }) {
      return TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          color: Colors.white,
          fontSize: 27.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Color(0xFF656678),
            fontSize: 27.sp,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color(0xFF0F1120),
          contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(color: Color(0xFFF24822), fontSize: 20.sp),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Color(0xFFF24822), width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Color(0xFFF24822), width: 1.w),
          ),
        ),
        validator: validator,
        textAlign: TextAlign.left,
      );
    }

    Widget buildFormFields() {
      return Column(
        children: [
          // Skills field
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldLabel(formFields[0]),
                SizedBox(height: 8.h),
                AuthTagSelector(
                  availableTags: skillTags,
                  onTagsChanged: (tags) {
                    // Handle the updated tags list
                    print('Selected tags: $tags');
                  },
                ),
              ],
            ),
          ),
          // Links section
          Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldLabel(formFields[1]),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.link1Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.link2Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
                SizedBox(height: 8.h),
                buildTextField(
                  controller: auth.link3Controller,
                  placeholder: formFields[1].placeholder ?? '',
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildBottomSection() {
      return Container(
        height: 45.h, // Fixed height
        color: const Color(0xFF020315),
        child: Column(
          children: [
            Container(height: 1.h, color: const Color(0xFF101123)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildButton(
                        text: 'Back',
                        backgroundColor: const Color(0xFF101123),
                        textColor: Colors.white,
                        onPressed: () {
                          auth.updatePageIndex(auth.pageIndex - 1);
                          Navigator.pop(context, auth.pageIndex);
                        },
                      ),
                    ),
                    SizedBox(width: 12.h),
                    Expanded(
                      child: buildButton(
                        text: 'Next',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Form is valid, proceeding...');
                          }
                          auth.updatePageIndex(auth.pageIndex + 1);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BioProfileSetup(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<AuthenticationProvider>(
      builder: (context, pv, child) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: const Color(0xFF020315),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 828.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildHeader(),
                                SizedBox(height: 20.h),
                                buildFormFields(),
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
        );
      },
    );
  }
}
