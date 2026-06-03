import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

File? selectedImage;

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController(
    text: "Noura Vallen",
  );

  final TextEditingController usernameController = TextEditingController(
    text: "@aluna.id",
  );

  final TextEditingController genderController = TextEditingController(
    text: "Female",
  );

  final TextEditingController phoneController = TextEditingController(
    text: "+44 2345 7896",
  );

  final TextEditingController emailController = TextEditingController(
    text: "elinara@gmail.com",
  );

  final TextEditingController passwordController = TextEditingController(
    text: "123456",
  );

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pilih dari Galeri"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Ambil dari Kamera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FF),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color(0xFF3B5EDF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: const Color(0xFFE9D9F8),
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!)
                      : null,
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: showImagePickerOptions,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B5EDF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            _buildField("Name", nameController),

            _buildField("Username", usernameController),

            _buildField("Gender", genderController),

            _buildField("Phone Number", phoneController),

            _buildField("Email", emailController),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: passwordController,
              obscureText: isHidden,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B5EDF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),

          const SizedBox(height: 8),

          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
