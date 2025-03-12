import 'package:flutter/material.dart';

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
      home: HomeScreen(), // home page
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  double _score = 0.0;
  TextEditingController amountController = TextEditingController();

  void _showAdjustBalanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Изменить баланс'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Сумма',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Убавить'),
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                setState(() {
                  _score -= amount;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Прибавить'),
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                setState(() {
                  _score += amount;
                });
                Navigator.of(context).pop();
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
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 219, 149, 1.0)),
        leading: IconButton(icon: Icon(Icons.notifications), tooltip: 'Уведомления', onPressed: () {}),
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
        color: const Color.fromRGBO(5, 56, 107, 0.95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Текущий счёт', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 24)),
            Text('$_score', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showAdjustBalanceDialog(context),
              child: const Text('Изменить баланс'),
            ),
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

class _ScoresScreenState extends State<ScoresScreen> {
  final List<Map<String, dynamic>> _accounts = []; // Список счетов

  void _showAddAccountDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _amountController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Добавить счет'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Название счета',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Сумма',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      double currentAmount = double.tryParse(_amountController.text) ?? 0;
                      if (currentAmount > 0) {
                        _amountController.text = (currentAmount - 100).toString();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      double currentAmount = double.tryParse(_amountController.text) ?? 0;
                      _amountController.text = (currentAmount + 100).toString();
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                String name = _nameController.text;
                double amount = double.tryParse(_amountController.text) ?? 0;

                if (name.isNotEmpty) {
                  setState(() {
                    _accounts.add({
                      'name': name,
                      'amount': amount,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Добавить'),
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
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 219, 149, 1.0)),
        leading: IconButton(
          icon: Icon(Icons.notifications),
          tooltip: 'Уведомления',
          onPressed: () {},
        ),
        toolbarHeight: 100,
        title: Text(
          'Cчета',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromRGBO(237, 245, 225, 1.0), fontSize: 32),
        ),
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
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
      body: ListView.builder(
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          final account = _accounts[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Color.fromRGBO(5, 56, 107, 0.95),
            child: ListTile(
              title: Text(
                account['name'],
                style: TextStyle(
                  color: Color.fromRGBO(237, 245, 225, 1.0),
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                'Сумма: ${account['amount']}',
                style: TextStyle(
                  color: Color.fromRGBO(237, 245, 225, 1.0),
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  _showEditAccountDialog(context, index);
                },
              ),
            ),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAccountDialog(context),
        tooltip: 'Добавить счет',
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(5, 56, 107, 0.95),
      ),
    );
  }

  void _showEditAccountDialog(BuildContext context, int index) {
    final TextEditingController _nameController = TextEditingController(text: _accounts[index]['name']);
    final TextEditingController _amountController = TextEditingController(text: _accounts[index]['amount'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Редактировать счет'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Название счета',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Сумма',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      double currentAmount = double.tryParse(_amountController.text) ?? 0;
                      if (currentAmount > 0) {
                        _amountController.text = (currentAmount - 100).toString();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      double currentAmount = double.tryParse(_amountController.text) ?? 0;
                      _amountController.text = (currentAmount + 100).toString();
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                String name = _nameController.text;
                double amount = double.tryParse(_amountController.text) ?? 0;

                if (name.isNotEmpty) {
                  setState(() {
                    _accounts[index]['name'] = name;
                    _accounts[index]['amount'] = amount;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
      
    );
  }
}

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('!'),
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