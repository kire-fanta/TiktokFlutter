import 'package:flutter/material.dart';
// l'importation des dependances est obligatoire pour pouvoir les utiliser par la suite
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_tiktodc/Profil.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}
// la creation d'un widget statique  sans etat

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Tiktok',
      debugShowCheckedModeBanner: false,
      //SCALFOD(l'architecture de notre appli et est retourne dans la creation de notre appbar ,BottomNavigationBar, FloatingActionButton, il prend tout l'espace disponible)
      home: MyStatefulWidget(),
    ); // la widget  pour la creation d'une application
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    HomePage(),
    Text('search'),
    Text('Add'),
    Text('Comment'),
    Text('profil'),
    Essai()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // le widget home page pour la creation de la classe de swipe des videos
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // le text qui est affiché en bas de l'icone
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/tiktok_add.png",
              height: 25,
            ),
            label: ' Add',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.comment_outlined),
            label: ' Comment',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF141518),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        //enlever le texte qui est sur l'icone du moment ou ceci à ete sélectione
        showSelectedLabels: false,
        //retirer tout les icones qui ne marche pas, Afficher les étiquettes non sélectionnées: non
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // la creation de la liste qui va contenir toutes les information de la video
  final List<Map> tiktokItems = [
    {
      "video": 'assets/videos/blacnk.mp4',
    },
    {
      "video": 'assets/videos/damon.mp4',
    },
    {
      "video": 'assets/videos/motivation.mp4',
    },
    {
      "video": 'assets/videos/olivia.mp4',
    },
    {
      "video": 'assets/videos/wakanda.mp4',
    },
    {
      "video": 'assets/videos/zendaya.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // le code qui a ete pris dans le fichier carousel apres que ce dernier à ete ajouter comme dependances dans le yaml, et importer dans le main.dart
    return CarouselSlider(
      options: CarouselOptions(
        // prendre toute la largeur de l'ecran
        height: double.infinity,
        // le swipe se fait à la verticale
        scrollDirection: Axis.vertical,
        // prendre 100/100 de l'espace
        viewportFraction: 1.0,
      ),
      // pose la questions
      items: tiktokItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              color: const Color(0xFF141518),
              //Cette classe est utile si vous souhaitez superposer plusieurs enfants de manière simple, par exemple en ayant du texte et une image, superposés avec un dégradé et un bouton attaché en bas.
              child: Stack(
                children: [
                  VideoWidget(videoUrl: item['video']),
                  //il represente la classe contenue qui est superpose sur la video
                  const Contenue()
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// la classe qui permet l'utilisation de la video est qui est l'enfant de child(stack)
class VideoWidget extends StatefulWidget {
  //l'obbligation d'utiliser videoUrl dans l'excution de la classe widget
  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);
  //la creation de la valeur videoUrl
  final String videoUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState(this.videoUrl);
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  final String videoUrl;
  _VideoWidgetState(this.videoUrl);

  void initState() {
    super.initState();
    // des paramettre obligatoire
    //lajout de la chaine de caractere videoUrl comme valeurs
    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        // lire la video
        _controller.play();
        // _controller.setVolume(0);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}
// la creation de la contenue des contenues qui se trouve sur l'ecran

class Contenue extends StatelessWidget {
  const Contenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          padding: const EdgeInsets.only(top: 40),
          //color: Colors.blue,
          // le cotenue sur la ligne
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Suivis",
                style: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 90),
              Text("Pour toi",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                  )),
              Icon(
                Icons.search,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(
                width: 90,
              )
            ],
          ),
        ),

        SizedBox(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 80,
                child: Stack(
                  // questions
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      //la creation de l'avatar de profil
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/ZENDAYA.webp'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        //children: [
        SizedBox(
          height: 80,
          child: Column(children: const [
            Icon(
              Icons.favorite,
              color: Colors.white,
              size: 45,
            ),
            Text("25 K",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
        SizedBox(
          height: 80,
          child: Column(children: const [
            Icon(
              Icons.message,
              color: Colors.white,
              size: 45,
            ),
            Text(
              "300",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )
          ]),
        ),
        SizedBox(
          height: 80,
          child: Column(children: const [
            Icon(
              Icons.favorite,
              color: Colors.white,
              size: 45,
            ),
            Text(
              '100',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )
          ]),
        ),
        SizedBox(
          height: 80,
          child: Column(children: const [
            Icon(
              Icons.share,
              size: 45,
            ),
            Text(
              "Partager",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )
          ]),
        ),
        Container(
          height: 80,
        ),
        Container(
          height: 80,
        )
      ],
    );
  }
}
