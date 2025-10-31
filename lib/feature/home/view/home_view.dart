import 'package:flutter/material.dart';
import 'package:mezmaps/feature/home/view_model/mixin/home_mixin.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:gen/gen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MezMaps')),
        body: Column(
          children: [
            _logo(),
            _mButton(),
            _mkButton(),
            _vfButton(),
            _infoButton(),
            
          ],
        ),
        bottomNavigationBar: _bottomBar(),

        );
  }
}

class _bottomBar extends StatelessWidget {
  const _bottomBar();
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 10,
      height: 88,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [  
            //ANA MENÜ 
          Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.home)),
        SizedBox(height: 2),
        Text('Ana Menü', style: TextStyle(fontSize: 10)),
      ],
    ),
      //MEZARLIKLAR
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: (){},
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
          onPressed: (){},
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
          onPressed: (){},
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

class _logo extends StatelessWidget {
  const _logo();
  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.images.logo.image(package: 'gen',width: 170,));
  }
}

class _mButton extends StatelessWidget {
  const _mButton();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ElevatedButton(
          onPressed: (){}, 
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30)
          ),
          elevation: 10,
          shadowColor: Colors.green.withValues()
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Assets.icons.mLight.image(package: 'gen',height: 25,width: 25),
              SizedBox(width: 20),
              Expanded(child: Text('Mezarlıklar')),
              Icon(Icons.arrow_forward_ios_rounded)
            ],
           )
          ),
    );
  }
}

class _mkButton extends StatelessWidget {
  const _mkButton();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ElevatedButton(
        onPressed: (){}, 
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30)
          ),
          elevation: 10,
          shadowColor: Colors.green.withValues()
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Assets.icons.mkLight.image(package: 'gen',height: 25,width: 25),
            SizedBox(width: 20),
            Expanded(
              child: Text("Mezarlık Konumları")),
                  Icon(Icons.arrow_forward_ios_rounded),
          ],
          )
        ),
    );
  }
}

class _vfButton extends StatelessWidget {
  const _vfButton();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ElevatedButton(
          onPressed: (){}, 
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30)
          ),
          elevation: 10,
          shadowColor: Colors.green.withValues()
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Assets.icons.vfLight.image(package: 'gen',height: 25,width: 25),
              SizedBox(width: 20),
              Expanded(child: Text('Vefat Edenler')),
              Icon(Icons.arrow_forward_ios_rounded)
            ],
           )
          ),
    );
  }
}
class _infoButton extends StatelessWidget {
  const _infoButton();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ElevatedButton(
        onPressed: (){}, 
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30)
          ),
          elevation: 10,
          shadowColor: Colors.green.withValues()
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Assets.icons.infoLight.image(package: 'gen',height: 25,width: 25),
            SizedBox(width: 20),
            Expanded(
              child: Text("Hakkında")),
                  Icon(Icons.arrow_forward_ios_rounded),
          ],
          )
        ),
    );
  }
}