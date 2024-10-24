part of 'reward_bloc.dart';

abstract class RewardEvent {}

class CheckRewardEvent extends RewardEvent {}

class GetRewardEvent extends RewardEvent {}
