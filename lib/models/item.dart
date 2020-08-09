/**
 * This class responsible to represent item
 */
class Item {
  String title;
  bool done;

  //constructor
  Item({this.title, this.done});

  //convert json to string
  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  //convert to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }
}
