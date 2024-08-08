class UniversityModel {
  List<String>? domains;
  String? name;
  String? stateProvince;
  String? country;
  String? alphaTwoCode;
  List<String>? webPages;

  UniversityModel(
      {this.domains,
      this.name,
      this.stateProvince,
      this.country,
      this.alphaTwoCode,
      this.webPages});

  UniversityModel.fromJson(Map<String, dynamic> json) {
    domains = json['domains'].cast<String>();
    name = json['name'];
    stateProvince = json['state-province'];
    country = json['country'];
    alphaTwoCode = json['alpha_two_code'];
    webPages = json['web_pages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domains'] = this.domains;
    data['name'] = this.name;
    data['state-province'] = this.stateProvince;
    data['country'] = this.country;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['web_pages'] = this.webPages;
    return data;
  }


}