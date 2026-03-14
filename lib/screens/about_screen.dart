import 'package:flutter/material.dart';
import '../widgets/animated_sky_background.dart';
import '../services/app_language.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        const AnimatedSkyBackground(),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  Text(
                    AppLanguage.t("about"),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFE53935),
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          color: isDark
                              ? const Color(0xFF2A2A3C)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Developed By",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const Divider(),
                                const SizedBox(height: 20),

                                Column(
                                  children: const [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundImage: AssetImage(
                                        "imgs/thinh.jpg",
                                      ),
                                    ),

                                    SizedBox(height: 12),

                                    Text(
                                      "Nguyễn Tiến Thịnh",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text("MSV: 23010500"),
                                    Text(
                                      "Email: 23010500@st.phenikaa-uni.edu.vn",
                                    ),
                                    Text("Group: 17"),
                                    Text(
                                      "Class: Lập trình cho thiết bị di động (N02)",
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),
                                const Divider(),
                                const SizedBox(height: 20),

                                Column(
                                  children: const [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundImage: AssetImage(
                                        "imgs/linh.jpg",
                                      ),
                                    ),

                                    SizedBox(height: 12),

                                    Text(
                                      "Nguyễn Thị Nhật Linh",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text("MSV: 23010511"),
                                    Text(
                                      "Email: 23010511@st.phenikaa-uni.edu.vn",
                                    ),
                                    Text("Group: 17"),
                                    Text(
                                      "Class: Lập trình cho thiết bị di động (N02)",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 7),

                        Center(
                          child: Text(
                            "Version 1.0.0",
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
