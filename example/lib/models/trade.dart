import 'dart:ui';

class Trade {
  final String sym;
  final double bid;
  final double ask;
  final Color color;
  final DateTime dateTime;
  Trade(this.sym, this.bid, this.ask, this.color, this.dateTime);
}