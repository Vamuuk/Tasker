import 'package:flutter/material.dart';
import 'dart:async'; // Для таймера
import 'package:intl/intl.dart'; // Для форматирования даты
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: Color(0xFFE74C3C), // Основной цвет кнопок
        scaffoldBackgroundColor: Colors.white, // Фон приложения
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black, // Черный цвет текста
            fontFamily: 'Inter', // Шрифт Inter
            fontSize: 16, // Базовый размер текста для bodyLarge
          ),
          headlineLarge: TextStyle(
            color: Colors.black,
            fontFamily: 'Inter',
            fontSize: 24, // Размер текста для заголовков
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE74C3C), // Красный цвет кнопки
            foregroundColor: Colors.white, // Белый цвет текста кнопки
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Закругленные углы
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Увеличенные размеры кнопки
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Белый фон AppBar
          iconTheme: IconThemeData(color: Color(0xFFE74C3C)), // Цвет кнопки назад
        ),
      ),
      initialRoute: '/', // Стартовый маршрут
      routes: {
        '/': (context) => WelcomeScreen(), // Начальный экран
        '/team': (context) => TeamScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile_setup': (context) => ProfileSetupScreen(),
        '/login': (context) => LoginScreen(),
        '/password': (context) => PasswordScreen(),
      },
    );
  }
}

//экраны


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0), // Отступы для контейнера
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание текста по левому краю
              children: [
                SizedBox(height: 0), // Отступ сверху
                Image.asset('assets/kartinki/image3.png'), // Изображение
                SizedBox(height: 30), // Пространство после картинки
                
                Text(
                  'Работа с задачами',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Толстый текст
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 25), // Отступ
                
                Text(
                  'Давайте же создадим место для вашей работы!',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 35,
                        fontWeight: FontWeight.bold, // Увеличенная жирность текста
                      ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10), // Дополнительный отступ
              ],
            ),
          ),

          // Кнопка за пределами контейнера с текстом и изображением
          Positioned(
            bottom: 100, // Отступ снизу
            right: 0, // Отступ справа
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/team');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, // Цвет кнопки
                padding: EdgeInsets.all(0), // Убираем стандартные отступы кнопки
                shape: const BeveledRectangleBorder( // Треугольная кнопка
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60), // Размер кнопки
                child: Icon(
                  Icons.arrow_forward, // Стрелочка вместо текста
                  size: 30, // Размер иконки
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final PageController _pageController = PageController(); // Контроллер для PageView
  int _currentPage = 0; // Текущая страница
  Timer? _timer; // Таймер для автоматической смены страниц

  final List<String> _texts = [
    'Работайте в команде',
    'Узнавайте про свои задачи',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 6), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Остановить таймер при выходе
    _pageController.dispose(); // Уничтожить контроллер при завершении
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Пустой AppBar
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page; // Обновление текущей страницы при свайпе
                });
              },
              children: [
                _buildImage('assets/kartinki/image1.png'), // Первая картинка
                _buildImage('assets/kartinki/image2.png'), // Вторая картинка
              ],
            ),
          ),
          SizedBox(height: 16), // Отступ между изображениями и текстом
          Text(
            _texts[_currentPage], // Текст, связанный с текущим изображением
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18),
          ),
          SizedBox(height: 16),
          _buildDotsIndicator(),
          SizedBox(height: 20), // Отступ снизу
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text('Зарегистрироваться'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Войти если есть аккаунт'),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // Заполнение изображения
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300), // Анимация при смене страницы
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).primaryColor // Активная точка (цвет основного интерфейса)
                : Colors.black, // Неактивная точка (черный цвет)
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}




class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  // Функция проверки email
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$");
    return emailRegex.hasMatch(email);
  }

  // Функция проверки пароля
  bool _validatePassword(String password) {
    final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$");
    return passwordRegex.hasMatch(password);
  }

  void _validateInputs() {
    setState(() {
      // Валидация email
      if (!_validateEmail(_emailController.text)) {
        _emailError = "Неправильная почта. Email должен быть в формате @gmail.com";
      } else {
        _emailError = null;
      }

      // Валидация пароля
      if (!_validatePassword(_passwordController.text)) {
        _passwordError = "Пароль должен начинаться с заглавной буквы и иметь хотя бы одну цифру";
      } else {
        _passwordError = null;
      }

      // Переход на следующий экран, если ошибок нет
      if (_emailError == null && _passwordError == null) {
        Navigator.pushNamed(context, '/profile_setup');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Введите ваш email и пароль',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailError, // Сообщение об ошибке
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Пароль',
                errorText: _passwordError, // Сообщение об ошибке
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateInputs, // Вызов функции валидации
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileSetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройка профиля')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Настройте свой профиль',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Фамилия',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Действие для завершения настройки
              },
              child: Text('Готово'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE74C3C),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Закругленные углы для кнопки
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  String? _emailError;

  // Валидация email
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$");
    return emailRegex.hasMatch(email);
  }

  void _validateInputs() {
    setState(() {
      if (!_validateEmail(_emailController.text)) {
        _emailError = "Неправильная почта. Email должен быть в формате @gmail.com";
      } else {
        _emailError = null;
        Navigator.pushNamed(context, '/password'); // Переход, если ошибок нет
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Вход', style: TextStyle(fontSize: 24)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailError, // Сообщение об ошибке
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateInputs, // Вызов валидации
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _passwordController = TextEditingController();
  String? _passwordError;

  // Валидация пароля
  bool _validatePassword(String password) {
    final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$");
    return passwordRegex.hasMatch(password);
  }

  void _validateInputs() {
    setState(() {
      if (!_validatePassword(_passwordController.text)) {
        _passwordError = "Пароль должен начинаться с заглавной буквы и иметь хотя бы одну цифру";
      } else {
        _passwordError = null;
        // Переход на домашний экран (пока не реализован)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите пароль', style: TextStyle(fontSize: 24)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Пароль',
                errorText: _passwordError, // Сообщение об ошибке
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateInputs, // Вызов функции валидации
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // По умолчанию выбран домашний экран
  String currentDate = DateFormat('EEEE, MMMM d', 'ru').format(DateTime.now());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildProfileIcon() {
    return IconButton(
      icon: Icon(Icons.account_circle, size: 30),
      onPressed: () {
        // Действие для иконки профиля
      },
    );
  }

  Widget _buildArrowIcon(bool isLeft) {
    return IconButton(
      icon: Icon(
        isLeft ? Icons.arrow_left : Icons.arrow_right,
        size: 30,
        color: Colors.black,
      ),
      onPressed: () {
        // Действие для изменения недели
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 0 ? Icons.add_task : Icons.add_task_outlined),
          label: 'Задача',
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 1 ? Icons.home : Icons.home_outlined),
          label: 'Домой',
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 2 ? Icons.message : Icons.message_outlined),
          label: 'Сообщения',
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 3 ? Icons.settings : Icons.settings_outlined),
          label: 'Настройки',
        ),
      ],
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _buildProfileIcon(),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildArrowIcon(true),
              Column(
                children: [
                  Text(
                    currentDate,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Эта неделя',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              _buildArrowIcon(false),
            ],
          ),
          Spacer(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}
