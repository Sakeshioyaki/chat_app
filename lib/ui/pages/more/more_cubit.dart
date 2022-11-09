import 'package:bloc/bloc.dart';
import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/models/user/user_entity.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final AppCubit appCubit;

  MoreCubit({required this.appCubit}) : super(MoreState());

  UserEntity? getUser() {
    return appCubit.getUser();
  }
}
