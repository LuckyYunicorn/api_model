part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PickImageFromGallery extends ImagePickerEvent{}

class PickImageFromCamera extends ImagePickerEvent{}
