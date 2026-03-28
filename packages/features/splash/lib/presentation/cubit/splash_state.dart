enum SplashDestination { home, welcome, terms, force_update }

sealed class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashNavigate extends SplashState {
  const SplashNavigate(this.to);
  final SplashDestination to;
}
