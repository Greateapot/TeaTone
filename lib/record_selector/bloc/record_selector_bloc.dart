import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'record_selector_event.dart';
part 'record_selector_state.dart';

class RecordSelectorBloc extends Bloc<RecordSelectorEvent, RecordSelectorState> {
  RecordSelectorBloc() : super(RecordSelectorInitial()) {
    on<RecordSelectorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
