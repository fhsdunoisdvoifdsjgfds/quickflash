part of 'reward_bloc.dart';

abstract class RewardState {}

class RewardInitial extends RewardState {}

class RewardClaimedState extends RewardState {}

class RewardClaimingState extends RewardState {}
