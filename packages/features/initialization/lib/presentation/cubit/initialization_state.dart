enum InitializationDestination { register, login }

sealed class InitializationState {
  const InitializationState();
}

class InitializationInitial extends InitializationState {
  const InitializationInitial();
}

class InitializationNavigate extends InitializationState {
  const InitializationNavigate(this.to);
  final InitializationDestination to;
}
