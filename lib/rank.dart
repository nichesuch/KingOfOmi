class Rank {
  String id = "";
  int point = 0;
  String name = "";

  Rank fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    name = map["user"] ?? "";
    point = map["point"] ?? 0;
    return this;
  }
}