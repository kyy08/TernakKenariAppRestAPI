import 'package:bloc/bloc.dart';
import 'package:canary_101/data/model/response/burung_semua_tersedia_model.dart';
import 'package:canary_101/data/repository/get_all_burung_tersedia_repository.dart';

part 'get_burung_tersedia_event.dart';
part 'get_burung_tersedia_state.dart';

class GetBurungTersediaBloc
    extends Bloc<GetBurungTersediaEvent, GetBurungTersediaState> {
  final GetAllBurungTersediaRepository getAllBurungTersediaRepository;

  GetBurungTersediaBloc(this.getAllBurungTersediaRepository)
    : super(GetBurungTersediaInitial()) {
    on<GetAllBurungTersediaEvent>(_getAllBurungTersedia);
  }

  Future<void> _getAllBurungTersedia(
    GetAllBurungTersediaEvent event,
    Emitter<GetBurungTersediaState> emit,
  ) async {
    emit(GetBurungTersediaLoading());
    final result = await getAllBurungTersediaRepository.getAllBurungTersedia();
    result.fold(
      (error) => emit(GetBurungTersediaError(message: error)),
      (burungTersedia) =>
          emit(GetBurungTersediaLoaded(burungTersedia: burungTersedia)),
    );
  }
}
