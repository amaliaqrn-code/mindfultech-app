import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(const HomepageState(userLevel: 1, mascotGreeting: 'Yuk mulai hari produktif bareng Mindy!')) {
    _updateMascotText();
  }

  void _updateMascotText() {
    final config = HomepageState.levelConfigs[state.userLevel];
    if (config != null) {
      emit(state.copyWith(mascotGreeting: config.mascotText));
    }
  }

  void setUserLevel(int level) {
    if (level >= 1 && level <= 6) {
      emit(state.copyWith(userLevel: level));
      _updateMascotText();
    }
  }
}
