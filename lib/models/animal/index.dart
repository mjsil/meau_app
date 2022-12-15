class Animal {
  String? _name;
  bool? _calm;
  bool? _castrated;
  bool? _dewormed;

  Animal({String? name, bool? calm, bool? castrated, bool? dewormed}) {
    if (name != null) {
      this._name = name;
    }
    if (calm != null) {
      this._calm = calm;
    }
    if (castrated != null) {
      this._castrated = castrated;
    }
    if (dewormed != null) {
      this._dewormed = dewormed;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  bool? get calm => _calm;
  set calm(bool? calm) => _calm = calm;
  bool? get castrated => _castrated;
  set castrated(bool? castrated) => _castrated = castrated;
  bool? get dewormed => _dewormed;
  set dewormed(bool? dewormed) => _dewormed = dewormed;

  Animal.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _calm = json['calm'];
    _castrated = json['castrated'];
    _dewormed = json['dewormed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['calm'] = this._calm;
    data['castrated'] = this._castrated;
    data['dewormed'] = this._dewormed;
    return data;
  }
}