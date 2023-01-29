class Rank {
  String id = "";
  int point = 0;
  int done = 0;
  int ranking = 0;
  String name = "";

  Rank fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    name = map["user"] ?? "";
    point = map["point"] ?? 0;
    done = map["done"] ?? 0;
    ranking = map["ranking"] ?? 0;
    return this;
  }
}