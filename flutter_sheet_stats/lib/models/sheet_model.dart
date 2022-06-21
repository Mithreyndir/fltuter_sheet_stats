import 'package:json_annotation/json_annotation.dart';


class Sheet {
  int? id;
  String? name;
  List<Rows>? rows;
  List<Columns>? columns;

  Sheet({this.id, this.name, this.rows, this.columns});

  Sheet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(new Columns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    if (this.columns != null) {
      data['columns'] = this.columns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int? id;
  List<Cells>? cells;

  Rows({this.id, this.cells});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cells'] != null) {
      cells = <Cells>[];
      json['cells'].forEach((v) {
        cells!.add(new Cells.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cells != null) {
      data['cells'] = this.cells!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cells {
  int? columnId;
  int? rowId;
  String? value;

  Cells({this.columnId, this.rowId, this.value});

  Cells.fromJson(Map<String, dynamic> json) {
    columnId = json['columnId'];
    rowId = json['rowId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['columnId'] = this.columnId;
    data['rowId'] = this.rowId;
    data['value'] = this.value;
    return data;
  }
}

class Columns {
  int? id;
  String? name;

  Columns({this.id, this.name});

  Columns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}