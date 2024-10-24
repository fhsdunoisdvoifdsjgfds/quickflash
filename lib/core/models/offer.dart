import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Offer {
  @HiveField(0)
  final int id;
  @HiveField(1)
  int cost;
  @HiveField(2)
  String who;
  @HiveField(3)
  String paymentPeriod;
  @HiveField(4)
  String transportType;
  @HiveField(5)
  String note;
  @HiveField(6)
  String comment;

  Offer({
    required this.id,
    required this.cost,
    required this.who,
    required this.paymentPeriod,
    required this.transportType,
    this.note = '',
    this.comment = '',
  });
}

class OfferAdapter extends TypeAdapter<Offer> {
  @override
  final typeId = 0;

  @override
  Offer read(BinaryReader reader) {
    return Offer(
      id: reader.read(),
      cost: reader.read(),
      who: reader.read(),
      paymentPeriod: reader.read(),
      transportType: reader.read(),
      note: reader.read(),
      comment: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Offer obj) {
    writer.write(obj.id);
    writer.write(obj.cost);
    writer.write(obj.who);
    writer.write(obj.paymentPeriod);
    writer.write(obj.transportType);
    writer.write(obj.note);
    writer.write(obj.comment);
  }
}
