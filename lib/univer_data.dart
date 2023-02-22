
import 'package:hive/hive.dart';
part 'univer_data.g.dart';

@HiveType(typeId: 1)
class UniverResponse extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Univer> univers;

  UniverResponse({required this.univers,required this.name, });

  factory UniverResponse.fromJson(dynamic data,String name) {
    List<Univer> listOfUniver = [];
    data?.forEach((value) {
      listOfUniver.add(Univer.fromJson(value));
    });
    return UniverResponse(univers: listOfUniver, name: name);
  }
}


@HiveType(typeId: 2)
class Univer extends HiveObject{
  @HiveField(0)
  List<String>? domains;
  @HiveField(1)
  String? country;
  @HiveField(2)
  String? alphaTwoCode;
  @HiveField(3)
  List<String>? webPages;
  @HiveField(4)
  String? name;

  Univer(
      {this.domains,
        this.country,
        this.alphaTwoCode,
        this.webPages,
        this.name});

  Univer.fromJson(Map<String, dynamic> json) {
    domains = json['domains'].cast<String>();
    country = json['country'];
    alphaTwoCode = json['alpha_two_code'];
    webPages = json['web_pages'].cast<String>();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domains'] = domains;
    data['country'] = country;
    data['alpha_two_code'] = alphaTwoCode;
    data['web_pages'] = webPages;
    data['name'] = name;
    return data;
  }
}