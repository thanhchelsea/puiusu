import 'dart:convert';

class PhoneNumberContact{
  String name;
  String phone;
  PhoneNumberContact({this.name, this.phone});
  factory PhoneNumberContact.fromJson(Map<String, dynamic> jsonData) {
    return PhoneNumberContact(
      name: jsonData['name'],
      phone: jsonData['phone'],
    );
  }

  static Map<String, dynamic> toMap(PhoneNumberContact music) => {
    'name': music.name,
    'phone': music.phone,
  };

  static String encodeMusics(List<PhoneNumberContact> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => PhoneNumberContact.toMap(music))
        .toList(),
  );

  static List<PhoneNumberContact> decodeMusics(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<PhoneNumberContact>((item) => PhoneNumberContact.fromJson(item))
          .toList();
}