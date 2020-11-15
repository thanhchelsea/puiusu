import 'dart:convert';

class PhoneNumber{
  String name;
  String phone;
  PhoneNumber({this.name, this.phone});
  factory PhoneNumber.fromJson(Map<String, dynamic> jsonData) {
    return PhoneNumber(
      name: jsonData['name'],
      phone: jsonData['phone'],
    );
  }

  static Map<String, dynamic> toMap(PhoneNumber music) => {
    'name': music.name,
    'phone': music.phone,
  };

  static String encodeMusics(List<PhoneNumber> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => PhoneNumber.toMap(music))
        .toList(),
  );

  static List<PhoneNumber> decodeMusics(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<PhoneNumber>((item) => PhoneNumber.fromJson(item))
          .toList();
}