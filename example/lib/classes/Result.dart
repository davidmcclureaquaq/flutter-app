class Result {
  final String time;
  final String sym;
  final double price;
  final int size;
  final String exchange;

  Result({this.time, this.sym, this.price, this.size, this.exchange});

  bool selected = false;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      time: json['time'] as String,
      sym: json['sym'] as String,
      price: json['price'] as double,
      size: json['size'] as int,
      exchange: json['exchange'] as String,
    );
  }
}