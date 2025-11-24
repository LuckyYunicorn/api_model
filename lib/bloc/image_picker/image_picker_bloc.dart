import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerState()) {
    on<PickImageFromGallery>(_pickImageFromGallery);
  }

  Future<void> _pickImageFromGallery(
    PickImageFromGallery event,
    Emitter<ImagePickerState> emit,
  ) async {
    try {
      final picker = ImagePicker();
      final XFile? file;
      file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(ImagePickerState(file: file));
      } else {
        print("Error in selecting image");
      }
    } catch (e) {
      print(e);
    }
  }
}
