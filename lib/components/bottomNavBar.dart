import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterApp/components/customAlert.dart';
import 'package:flutterApp/components/eventsCard.dart';
import 'package:flutterApp/components/newsCard.dart';
import 'package:flutterApp/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  String _title;
  List<String> _user = [];
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  initState() {
    _title = 'Notícias';
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    NewsCard(),
    EventsCard(),
    Text(
      'Index 2: Conta',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) async {
    await getUser();
    setState(() {
      index == 2
          ? _drawerKey.currentState.openEndDrawer()
          : setState(() {
              _selectedIndex = index;
            });

      switch (_selectedIndex) {
        case 0:
          {
            _title = 'Notícias';
          }
          break;
        case 1:
          {
            _title = 'Eventos';
          }
          break;
      }
    });
  }

  Future getUser() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      _user = prefs.getStringList("user") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      endDrawer: renderDrawer(),
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[Container()],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Notícias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  renderDrawer() {
    User user = User(
        name: '',
        email: '',
        photourl:
            'https://lh3.googleusercontent.com/ogw/ADGmqu-gTc02TlI0SjAaHFtHe57mqlpXKCpPt0FIoeZT0A=s83-c-mo');
    if (_user.isNotEmpty) {
      user = User(name: _user[0], email: _user[1], photourl: _user[2]);
    }
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(
              child: Image.network(
                user.photourl,
                fit: BoxFit.fill,
              ),
            ),
            accountName: Text(user.name),
            accountEmail: Text(user.email),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30,
                ),
                title: Text('Logout'),
                subtitle: Text('Finalizar sessão'),
                onTap: () {
                  setState(() {
                    logout(context);
                    Navigator.of(context).pop();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  logout(context) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("user") != null) {
      prefs.clear();
      setState(() {
        _selectedIndex = 0;
      });
      alert(context, 'Você foi deslogado');
    } else {
      alert(context, 'Você não está logado');
    }
  }
}
