import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => InfoViewState();
}

class InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    final inf = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.about, 
        widget: Assets.icons.infoLight.image(package: 'gen',height: 20)),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // burası hoş durdu temadan çağırmadım.
                  colors: [Colors.grey[800]!, Colors.grey[600]!],
                ),
              ),
              padding: PaddingManager.morePaddingSymmetricVertical(context),
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 80,
                    color: inf.onPrimary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    ProjectString.aboutTop,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      //Theme dan çekemiyorum 
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ProjectString.aboutTop1,
                    style: TextStyle(
                      fontSize: 16,
                      color: inf.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Ana İçerik
            Padding(
              padding: PaddingManager.morePaddingAll(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Misyon Bölümü
                  _buildSection(
                    title: ProjectString.aboutM,
                    content:ProjectString.aboutTopM1,
                  ),

                  const SizedBox(height: 24),

                  // Sorun ve Çözüm
                  _buildSection(
                    
                    title: ProjectString.aboutTopC,
                    content:ProjectString.aboutTopC1,
                  ),

                  const SizedBox(height: 24),

                  // Özellikler
                  _buildFeatureCard(
                    //İconlar genden çekilebilir beceremedim 
                    icon: Icons.navigation,
                    title: ProjectString.aboutN,
                    description:ProjectString.aboutN1,
                  ),

                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    icon: Icons.search,
                    title: ProjectString.aboutA,
                    description:ProjectString.aboutA1,
                  ),

                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    icon: Icons.map,
                    title: ProjectString.aboutH,
                    description:ProjectString.aboutH1,
                  ),

                  const SizedBox(height: 32),

                  // Kapanış Mesajı
                  Container(
                    width: double.infinity,
                    padding: PaddingManager.normalPaddingAll(context),
                    decoration: BoxDecoration(
                      color: inf.surfaceDim,
                      borderRadius: BorderRadius.circular(30),
                      
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_florist,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ProjectString.aboutAni,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: inf.onSurface
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ProjectString.aboutAni1,
                          style: TextStyle(
                            fontSize: 14,
                            color:inf.inverseSurface,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // İletişim
                  Center(
                    child: Column(
                      children: [
                        Text(
                         ProjectString.aboutDs,
                          style: TextStyle(
                            fontSize: 14,
                            color: inf.inverseSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            // E-posta veya iletişim fonksiyonu
                          },
                          icon: const Icon(Icons.email),
                          label: const Text(ProjectString.aboutDs1),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                //Theme dan çekilmiyor
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            //Themedan çekilmiyor
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: PaddingManager.normalPaddingAll(context),
      decoration: BoxDecoration(
        //Themedan çekilmiyor
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: PaddingManager.normalPaddingAll(context),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.grey[700],
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}