import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/db/prefs.dart';
import '../../../core/utils.dart';

part 'reward_event.dart';
part 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  RewardBloc() : super(RewardInitial()) {
    on<CheckRewardEvent>((event, emit) async {
      logger('LAST REWARD = $lastReward');
      logger('TIMESTAMP = ${getCurrentTimestamp()}');
      logger('${lastReward - getCurrentTimestamp()}');

      await getCoins();
      if (lastReward + 86400 > getCurrentTimestamp()) {
        emit(RewardClaimedState());
      } else {
        emit(RewardClaimingState());
      }
    });

    on<GetRewardEvent>((event, emit) async {
      await saveCoins();
      emit(RewardClaimedState());
    });
  }
}
