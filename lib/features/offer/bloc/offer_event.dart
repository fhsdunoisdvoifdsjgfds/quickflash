part of 'offer_bloc.dart';

abstract class OfferEvent {}

class GetOfferEvent extends OfferEvent {}

class AddOfferEvent extends OfferEvent {
  final Offer offer;
  AddOfferEvent({required this.offer});
}

class EditOfferEvent extends OfferEvent {
  final Offer offer;
  EditOfferEvent({required this.offer});
}

class DeleteOfferEvent extends OfferEvent {
  final int id;
  DeleteOfferEvent({required this.id});
}
