import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/db/db.dart';
import '../../../core/models/offer.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferInitial()) {
    on<GetOfferEvent>((event, emit) async {
      await getOffers();
      emit(OfferLoadedState(offers: DB.offersList));
    });

    on<AddOfferEvent>((event, emit) async {
      // DB.offersList.insert(0, event.test);
      DB.offersList.add(event.offer);
      await updateOffers();
      emit(OfferLoadedState(offers: DB.offersList));
    });

    on<EditOfferEvent>((event, emit) async {
      for (Offer test in DB.offersList) {
        if (test.id == event.offer.id) {
          test.cost = event.offer.cost;
          test.who = event.offer.who;
          test.paymentPeriod = event.offer.paymentPeriod;
          test.transportType = event.offer.transportType;
          test.note = event.offer.note;
          test.comment = event.offer.comment;
        }
      }
      await updateOffers();
      emit(OfferLoadedState(offers: DB.offersList));
    });

    on<DeleteOfferEvent>((event, emit) async {
      DB.offersList.removeWhere((element) => element.id == event.id);
      await updateOffers();
      emit(OfferLoadedState(offers: DB.offersList));
    });
  }
}
