part of 'offer_bloc.dart';

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferLoadedState extends OfferState {
  final List<Offer> offers;
  OfferLoadedState({required this.offers});
}
