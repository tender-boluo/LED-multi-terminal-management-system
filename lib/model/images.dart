class Images{
  String imageName;

  Images(this.imageName);

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['imageName'] = imageName;
    return map;
  }
}