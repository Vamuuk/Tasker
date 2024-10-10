import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Настраиваемый экран',
      home: CustomScreen(),
    );
  }
}

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  // Текущий индекс активной иконки
  int _selectedIndex = 0;

  // Цвет интерфейса
  final Color _activeColor = Color(0xFFE74C3C);
  final Color _inactiveColor = Colors.black;

  // Список задач
  List<String> tasks = [];

  // Метод для добавления задачи
  void _addTask() {
    setState(() {
      tasks.add('Новая Задача ${tasks.length + 1}'); // Добавляем новую задачу
    });
  }

  @override
  Widget build(BuildContext context) {
    // Получаем текущую дату
    DateTime now = DateTime.now();

    // Получаем имя дня недели и месяца
    List<String> weekdays = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'];
    List<String> months = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
    ];

    String formattedDate = '${weekdays[now.weekday % 7]}, ${months[now.month - 1]} ${now.day}';

    return Scaffold(
      backgroundColor: Colors.white, // Белый фон
      body: Stack(
        children: [
          // Серый кружок в верхнем левом углу
          Positioned(
            top: 30,
            left: 20,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Дата и текст "Эта неделя"
          Positioned(
            top: 65,
            left: 60,
            right: 60,
            child: Column(
              children: [
                // Текущая дата
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54, // Цвет текста
                  ),
                ),
                SizedBox(height: 10), // Отступ между датой и текстом
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Левая стрелочка в очертании
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Очертание
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    // Отступ между стрелкой и текстом
                    SizedBox(width: 10), // Отступ между стрелкой и текстом
                    // Текст "Эта неделя"
                    Text(
                      'Эта Неделя',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold, // Жирный текст
                      ),
                    ),
                    // Отступ между текстом и стрелкой
                    SizedBox(width: 10), // Отступ между текстом и стрелкой
                    // Правая стрелочка в очертании
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Очертание
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Прямоугольник с круглыми углами
          Positioned(
            top: 180, // Позиция прямоугольника
            left: 45,
            right: 45,
            child: Container(
              height: 200, // Высота прямоугольника
              decoration: BoxDecoration(
                color: _activeColor, // Цвет интерфейса
                borderRadius: BorderRadius.circular(30), // Круглые углы
              ),
            ),
          ),
          Positioned(
            top: 400, // Позиция надписи (220 + 175 + 20)
            left: 30,
            right: 20,
            child: Text(
              'Все Задачи',
              style: TextStyle(
                fontSize: 24, // Размер шрифта
                fontWeight: FontWeight.bold, // Жирный текст
                color: Colors.black, // Цвет текста
              ),
              textAlign: TextAlign.left, // Центрируем текст
            ),
          ),
          // Список задач
          Positioned(
            top: 410, // Позиция списка задач (415 + 20)
            left: 45,
            right: 45,
            bottom: 105, // Отступ от низа, чтобы учесть панель
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10), // Увеличенный отступ между задачами
                  height: 160, // Высота серого прямоугольника
                  decoration: BoxDecoration(
                    color: Color(0xFFC2C2C2), // Установлен цвет #C2C2C2
                    borderRadius: BorderRadius.circular(30), // Круглые углы
                  ),
                  child: Center( // Центрируем текст
                    child: Text(
                      tasks[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          // Серая панель внизу
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey,
              height: 80, // Высота панели
              width: double.infinity, // Полная ширина
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Черный круг с белым плюсом
                  GestureDetector(
                    onTap: () {
                      _addTask(); // Добавляем задачу
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Container(
                      width: 60, // Увеличенный размер иконки
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black, // Плюсик остается черным
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add, // Плюс
                          color: Colors.white,
                          size: 30, // Увеличенный размер иконки
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Icon(
                      Icons.home,
                      color: _selectedIndex == 1 ? _activeColor : _inactiveColor,
                      size: 30, // Увеличенный размер иконки
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: Icon(
                      Icons.message,
                      color: _selectedIndex == 2 ? _activeColor : _inactiveColor,
                      size: 30, // Увеличенный размер иконки
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    child: Icon(
                      Icons.settings,
                      color: _selectedIndex == 3 ? _activeColor : _inactiveColor,
                      size: 30, // Увеличенный размер иконки
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
