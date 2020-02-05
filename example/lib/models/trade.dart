import 'dart:ui';

class Trade {
  final String time;
  final String sym;
  final double bid;
  final double ask;
  final Color color;
  Trade(this.time, this.sym, this.bid, this.ask, this.color);
}