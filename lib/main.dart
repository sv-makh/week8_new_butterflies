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

  //попытка получить описание бабочки name из массива бабочек
  String _getDescription(String name) {
    if (Butterfly.isNameValid(name)) {
      for (Butterfly b in _bClassList) {
        if (b.name == name) return b.description;
      }
    }
    return "Такой бабочки нет в списке";
  }

  @override
  void initState() {
    //массив бабочек инициализируется на старте
    _bClassList = Butterfly.getClassList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            decoration:
              const InputDecoration(hintText: "Введите название бабочки"),
            onSubmitted: (String name) {
              setState(() {
                _description = _getDescription(name);
              });
            }
          ),
          const SizedBox(height: 50),
          SingleChildScrollView(
            child: Text(_description,
              style: const TextStyle(fontSize: 20.0))
          )
        ],
      ),
    );
  }

}