import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
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
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ScoresScreen(),
    BudgetScreen(),
  ];
  final List<String> _pageTitles = [
    'Главная',
    'Счета',
    'Бюджет',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          _pageTitles[_selectedIndex], // Динамический заголовок
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(237, 245, 225, 1.0),
            fontSize: 32,
          ),
        ),
        backgroundColor: const Color.fromRGBO(5, 56, 107, 0.95),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromRGBO(92, 219, 149, 1.0),
        child: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Главная',
                style: TextStyle(
                  color: Color.fromRGBO(237, 245, 225, 1.0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Счета',
                style: TextStyle(
                  color: Color.fromRGBO(237, 245, 225, 1.0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Бюджет',
                style: TextStyle(
                  color: Color.fromRGBO(237, 245, 225, 1.0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: const Color.fromRGBO(5, 56, 107, 0.95),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _score = 0.0;
  double _plannedBudget = 0.0;
  List<Map<String, dynamic>> _plannedOperations = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController plannedBudgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadScore();
    _loadPlannedBudget();
    _loadPlannedOperations();
  }

  void _loadScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _score = prefs.getDouble('score') ?? 0.0;
    });
  }

  void _saveScore(double score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('score', score);
  }

  void _loadPlannedBudget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _plannedBudget = prefs.getDouble('plannedBudget') ?? 0.0;
    });
  }

  void _savePlannedBudget(double budget) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('plannedBudget', budget);
  }

  void _loadPlannedOperations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? operationsJson = prefs.getString('plannedOperations');
    if (operationsJson != null) {
      setState(() {
        _plannedOperations = List<Map<String, dynamic>>.from(jsonDecode(operationsJson));
      });
    }
  }

  void _savePlannedOperations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String operationsJson = jsonEncode(_plannedOperations);
    await prefs.setString('plannedOperations', operationsJson);
  }

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
                  decoration: const InputDecoration(hintText: 'Сумма'),
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
                  _saveScore(_score);
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
                  _saveScore(_score);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddPlannedOperationDialog(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Добавить запланированную операцию'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Сумма',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
                String description = descriptionController.text;
                double amount = double.tryParse(amountController.text) ?? 0.0;

                if (description.isNotEmpty) {
                  setState(() {
                    _plannedOperations.add({'description': description, 'amount': amount});
                    _savePlannedOperations();
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

  double get _projectedBalance {
    double totalOperations = _plannedOperations.fold(0, (sum, operation) => sum + operation['amount']);
    return _score + totalOperations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(92, 219, 149, 1.0), // Зеленый фон для всего экрана
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          color: const Color.fromRGBO(92, 219, 149, 1.0), // Зеленый фон для контейнера
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Текущий счет в синем прямоугольнике
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(5, 56, 107, 1.0), // Синий фон
                  borderRadius: BorderRadius.circular(10), // Закругленные углы
                ),
                child: Column(
                  children: [
                    Text(
                      'Текущий счёт',
                      style: TextStyle(
                        color: Colors.white, // Белый текст
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '$_score',
                      style: const TextStyle(
                        color: Colors.white, // Белый текст
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _showAdjustBalanceDialog(context),
                      child: const Text('Изменить баланс'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Планируемый бюджет
              Text(
                'Планируемый бюджет',
                style: TextStyle(
                  color: Color.fromRGBO(5, 56, 107, 1.0), // Синий текст
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Белый фон
                  borderRadius: BorderRadius.circular(10), // Закругленные углы
                ),
                child: TextField(
                  controller: plannedBudgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Введите планируемый бюджет',
                    hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold, ),
                    
                    border: InputBorder.none, // Убираем стандартную рамку
                  ),
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20), // Черный текст
                  onChanged: (value) {
                    setState(() {
                      _plannedBudget = double.tryParse(value) ?? 0.0;
                      _savePlannedBudget(_plannedBudget);
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              // Прогнозируемый бюджет
              Text(
                'Прогнозируемый бюджет',
                style: TextStyle(
                  color: Color.fromRGBO(5, 56, 107, 1.0), // Синий текст
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Белый фон
                  borderRadius: BorderRadius.circular(10), // Закругленные углы
                ),
                child: Text(
                  '$_projectedBalance',
                  style: const TextStyle(
                    color: Colors.black, // Черный текст
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Запланированные операции
              Text(
                'Запланированные операции',
                style: TextStyle(
                  color: Color.fromRGBO(5, 56, 107, 1.0), // Синий текст
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ..._plannedOperations.map((operation) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(5, 56, 107, 1.0), // Синий фон
                      borderRadius: BorderRadius.circular(10), // Закругленные углы
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          operation['description'],
                          style: TextStyle(
                            color: Colors.white, // Белый текст
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Сумма: ${operation['amount']}',
                          style: TextStyle(
                            color: Colors.white, // Белый текст
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10), // Зеленый пробел между операциями
                ],
              )).toList(),
              IconButton(
                icon: Icon(Icons.add, color: Color.fromRGBO(5, 56, 107, 1.0)), // Белая иконка
                onPressed: () => _showAddPlannedOperationDialog(context),
              ),
            ],
          ),
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
  final List<Map<String, dynamic>> _accounts = [];

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  void _loadAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountsJson = prefs.getString('accounts');
    if (accountsJson != null) {
      setState(() {
        _accounts.addAll(List<Map<String, dynamic>>.from(
          jsonDecode(accountsJson),
        ));
      });
    }
  }

  void _saveAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountsJson = jsonEncode(_accounts);
    await prefs.setString('accounts', accountsJson);
  }

  void _showAddAccountDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _amountController = TextEditingController(
      text: '0',
    );

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
                      double currentAmount =
                          double.tryParse(_amountController.text) ?? 0;
                      if (currentAmount > 0) {
                        _amountController.text =
                            (currentAmount - 100).toString();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      double currentAmount =
                          double.tryParse(_amountController.text) ?? 0;
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
                    _accounts.add({'name': name, 'amount': amount});
                    _saveAccounts(); // Автоматическое сохранение
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
    final TextEditingController _nameController = TextEditingController(
      text: _accounts[index]['name'],
    );
    final TextEditingController _amountController = TextEditingController(
      text: _accounts[index]['amount'].toString(),
    );

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
                      double currentAmount =
                          double.tryParse(_amountController.text) ?? 0;
                      if (currentAmount > 0) {
                        _amountController.text =
                            (currentAmount - 100).toString();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      double currentAmount =
                          double.tryParse(_amountController.text) ?? 0;
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
                    _saveAccounts(); // Автоматическое сохранение
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Бюджет'),
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
