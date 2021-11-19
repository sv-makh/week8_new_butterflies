import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("A new Butterflies App"),
          centerTitle: true,
        ),
        body: ButterfliesList(),
      ),
    );
  }
}

class Butterfly {
  String name;
  String description;

  static const List<String> _butterflies = [
    "Аполлон",
    "Павлиноглазка Артемида",
    "Павлиний глаз",
    "Адмирал",
    "Носатка листовидная",
    "Ornithoptera akakeae",
    "Махаон",
    "Мешочницы",
    "Слава Бутана",
    "Морфо Гекуба",
    "Morpho aurora",
    "Морфо киприда"
  ];

  static const List<String> _butterfliesDescription = [
    "Видовое название дано в честь Аполлона (греческая мифология) — сына Зевса и Лето, брата Артемиды, божества красоты и света.",
    "Видовое название дано в честь Артемиды — в греческой мифологии девственная, всегда юная богиня охоты, богиня плодородия, богиня женского целомудрия, покровительница всего живого на Земле.",
    "Латинское биноминальное название происходит от Īnachis — царя Инаха и его дочери Ио в древнегреческой мифологии.",
    "Русское название «адмирал» возникло из-за сходства окраски крыльев бабочки и лампасов на брюках адмирала флота Российской империи",
    "Русское родовое название дано из-за того, что вид характеризуются длинными губными щупиками.",
    "Название дано в честь цветущего жёлтыми цветками растения из рода Акация — Acacia dealbata",
    "Махаон назван шведским натуралистом Карлом Линнеем в честь персонажа греческой мифологии врача Махаона, по преданиям являвшегося сыном Асклепия и Эпионы и принимавшего участие в походе греков на Трою во время Троянской войны (1194—1184 до н. э.)",
    "Отличительной особенностью представителей семейства является сооружение гусеницами чехликов из сплетённых шелковинкой частиц листьев, коры, веточек и комочков почвы — откуда и произошло русское название семейства.",
    "Название рода указывает на страну Бутан, где впервые и был найден данный вид",
    "Видовое название Гекуба дано в честь жены троянского царя Приама, на долю которой выпала трагическая судьба и которая прославилась своей местью",
    "Видовое название Аврора дано в честь Авроры богини зари римской мифологии.",
    "Название бабочки связано с именем древнегреческой богини Афродиты. Считается, что Афродита возникла обнаженной из воздушной морской раковины вблизи Кипра — отсюда прозвище «Киприда» — и на раковине добралась до берега."
  ];

  Butterfly(this.name, this.description);

  //метод возвращает массив всех возможных бабочек с описанием
  static List<Butterfly> getClassList() {
    var _bClassList = <Butterfly>[];
    for (int i = 0; i < _butterflies.length; i++) {
      _bClassList.add(Butterfly(_butterflies[i], _butterfliesDescription[i]));
    }
    return _bClassList;
  }

  //есть ли информация о бабочке с именем name
  static bool isNameValid(String name) {
    return _butterflies.contains(name);
  }

  //возвращает список бабочек для подсказки
  static List<String> getPromptList() {
    return _butterflies;
  }
}

class ButterfliesList extends StatefulWidget {
  @override
  _ButterfliesListState createState() => _ButterfliesListState();
}

class _ButterfliesListState extends State<ButterfliesList> {
  //переменная для массива бабочек
  var _bClassList = <Butterfly>[];

  //что выводится под строчкой для поиска
  String _description = "";

  var _controller = TextEditingController();

  int _selectedIndex = -1;

  //попытка найти индекс бабочки name из массива бабочек
  int _getIndex(String name) {
    if (Butterfly.isNameValid(name)) {
      for (Butterfly b in _bClassList) {
        if (b.name == name) return _bClassList.indexOf(b);
      }
    }
    return -1;
    //return "Такой бабочки нет в списке";
  }

  @override
  void initState() {
    //массив бабочек инициализируется на старте
    _bClassList = Butterfly.getClassList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration:
              InputDecoration(
                  hintText: "Введите название бабочки",
              //при нажатии на иконку в конце поля ввода появляется
              //список подсказок-названий бабочек
              suffixIcon: PopupMenuButton(
                //при выборе бабочки
                onSelected: (String value) {
                  setState(() {
                    //имя бабочки записывается в поле
                    _controller.text = value;
                    //вычисляется индекс бабочки с выбранным именем
                    _selectedIndex = _getIndex(value);
                    //описание бабочки выводится ниже
                    _description = _bClassList[_selectedIndex].description;
                  });
                },
                icon: const Icon(Icons.help),
                itemBuilder: (BuildContext context) {
                  //получение списка подсказок из класса
                  var _items = Butterfly.getPromptList();
                  //список элементов для PopupMenuButton
                  return _items.map((String value) {
                    return PopupMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();

                },
              )),
            onSubmitted: (String value) {
              setState(() {
                //вычисляется индекс бабочки с введёным именем
                _selectedIndex = _getIndex(value);
                //если имя бабочки введено верно
                if (_selectedIndex != -1) {
                  //переменная заполняется её описанием
                  _description = _bClassList[_selectedIndex].description;
                }
                //если введено не имя бабочки из имеющегося списка
                else {
                  _description = "Такой бабочки нет в списке";
                }
              });
            }
          ),
          const SizedBox(height: 10),
          Container(
            height: 100.0,
            child: ListView.separated(
              padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 100.0, width: 10.0),
              itemCount: _bClassList.length,
              itemBuilder: _createListView,
            ),
          ),
          const SizedBox(height: 10),
          Text(_description,
            style: const TextStyle(fontSize: 20.0))
        ],
      ),
    ));
  }

  Widget _createListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState((){
          //переменная заполняется описанием выбранной бабочки
          _description = _bClassList[index].description;
          //запоминается индекс выбранной бабочки
          _selectedIndex = index;
        });
      },
      child: Container(
        child: Center(
          child: Text("\u{1F98B}"+_bClassList[index].name,
            style: const TextStyle(fontSize: 14.0),),),
        height: 100.0,
        width: 200.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: index == _selectedIndex
                ? Colors.lightBlue
                : Colors.black26,
            width: 3.0
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))
        ),
      ),
    );
  }

}