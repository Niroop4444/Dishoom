class ModelInt{
  String name;
  String image;
  String id;

  ModelInt (this.name, this.image, this.id);

  ModelInt.fromJson(Map<String, dynamic> json){
    name = json['intrest'];
    image = json['intrestURL'];
    id = json['intrestID'];
  }
}