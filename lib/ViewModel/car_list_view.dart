class CarListView {
  final String car_uuid;
  final String car_code;
  final String car_name;
  final String band_name;

  CarListView({this.car_uuid, this.car_code, this.car_name, this.band_name});
  factory CarListView.fromJson(Map<String, dynamic> json) {
    return CarListView(
      car_uuid: json['car_uuid'],
      car_code: json['car_code'],
      car_name: json['car_name'],
      band_name: json['band_name'],
    );
  }
}
