part of '../view/home_view.dart';

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.images.logo.image(package: 'gen', width: 170));
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({this.logo, required this.text, required this.onPressed});
  final Widget? logo;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.normalPaddingAll(context),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: PaddingManager.buttonContentPadding(context),
              child: logo,
            ),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}

/// Ayarlanacak
class BottomBar extends StatelessWidget {
  const BottomBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      height: 88,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //ANA MENÜ
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  context.replaceNoAnim(const HomeView());
                },
                icon: Icon(Icons.home),
              ),
              SizedBox(height: 2),
              Text('Ana Menü', style: TextStyle(fontSize: 10)),
            ],
          ),
          //MEZARLIKLAR
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  context.pushTo(CemeteriesView());
                },
                icon: Assets.icons.mLight.image(
                  package: 'gen',
                  width: 24,
                  height: 24,
                ),
                iconSize: 20,
              ),
              SizedBox(height: 2),
              Text('Mezarlıklar', style: TextStyle(fontSize: 10)),
            ],
          ),
          //MEZARLIK KONUMLARI
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  context.pushTo(GraveSearchPage());
                },
                icon: Assets.icons.mkLight.image(
                  package: 'gen',
                  width: 24,
                  height: 24,
                ),
                iconSize: 20,
              ),
              SizedBox(height: 2),
              Text('Mezarlık Konumları', style: TextStyle(fontSize: 10)),
            ],
          ),

          // VEFAT EDENLER
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Assets.icons.vfLight.image(
                  package: 'gen',
                  width: 24,
                  height: 24,
                ),
                iconSize: 20,
              ),
              SizedBox(height: 2),
              Text('Vefat Edenler', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
