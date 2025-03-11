import 'package:flutter/material.dart';


/*void main() => runApp(new MaterialApp(
      home: new Scaffold(
        backgroundColor: const Color.fromARGB(255, 159, 245, 125),
        appBar: new AppBar(leading: new Icon(Icons.menu), title: new Text('Главная', style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 239, 255, 167)),), backgroundColor: Color.fromARGB(255, 0, 85, 64),
    ),
    body: Center(child: Score()),
    )
    )
    );

class Score extends StatefulWidget{
  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  double score = 0;

  

  @override
  Widget build(BuildContext context){
    return Container( 
      color: Color.fromARGB(255, 0, 92, 38),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children:
        [
        Text('$score', style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 239, 255, 167)),),
        FloatingActionButton(
          onPressed: () {
          setState(() {
            score += 100;
          });
          }),
        ],
        ),
      );
  }
}*/
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChequeCheck',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(92, 219, 149, 0.7),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // nasledovanie superkey
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 219, 149, 1.0)),
        leading:IconButton(icon:Icon(Icons.notifications),tooltip:'Уведомления', onPressed: () {}),
        toolbarHeight: 100,
        title: Text('Главная', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 32)),
        backgroundColor: const Color.fromRGBO(5, 56, 107, 0.95),
      ),
       endDrawer: Drawer(
        backgroundColor: const Color.fromRGBO(92, 219, 149, 1.0),
        child: ListView(
          padding:EdgeInsets.all(15),
          children: <Widget>[
            SizedBox(height: 20),
            ListTile(
              title: Text('Главная', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                  Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Счета', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => ScoresScreen()),);
              },
            ),
            SizedBox(height:20),
            ListTile(
              title: Text('Бюджет', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => BudgetScreen()),);
              },
            ),
            SizedBox(height:20),
            ListTile(
              title: Text('График', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
              },
            ),
             SizedBox(height:20),
             ListTile(
              title: Text('Регулярные', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
              },
            ),
             SizedBox(height:20),
             ListTile(
              title: Text('Справка', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
              },
            ),
             SizedBox(height:20),
             ListTile(
              title: Text('Связь', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16,fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
              },
            ),
             SizedBox(height:20),
             ListTile(
              title: Text('Категории', style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 16, fontWeight: FontWeight.bold)),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
              },
             ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 50),
          width: double.infinity,
          height: 156,
          color:  const Color.fromRGBO(5, 56, 107, 0.95),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Текущий счёт', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 24)),
                  //поле с текущей суммой денег
                ],
              ),
            ),
      );
        }    
  }


class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key});
  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen>{
  final List<String> _scores = [];
  final TextEditingController _controller = TextEditingController();
  int _selectedIndex = -1;

  void _showDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Добавить счёт'),
            content: Container(
              width: 200,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите название счета',
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (text) {
                  // Do something with the text input
                },
                onSubmitted: (text) {
                  // Do something when the user submits the text input
                },
                maxLength: 20,
                obscureText: false,
              )),
            actions: <Widget>[
              TextButton(
                child: Text('Добавить'),
                onPressed: () {
                  String value = _controller.text;
                  setState(() {
                  _scores.add(value); // Добавляем новый счет
                });
                   Navigator.pop(context);
                   _controller.clear();
                },
              ),
            ],
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text('Счета', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 32)),
        backgroundColor: const Color.fromRGBO(5, 56, 107, 0.95),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: ListView.builder(
              itemCount:_scores.length,
              itemBuilder:(BuildContext context, int index) =>
              ListTile(
                onTap: (){
                  setState((){
                    _selectedIndex = index;
                  });
                },
                title: Text(_scores[index], style: TextStyle(fontSize:24)),
                selected: index == _selectedIndex,
                selectedTileColor: Colors.black12,
              ),
            ),
          ),
        ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        tooltip: 'Добавить счёт',
        child: const Icon(Icons.add)),
    );
  }
}

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О нас'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Это экран "О нас"!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Возврат на предыдущий экран
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}