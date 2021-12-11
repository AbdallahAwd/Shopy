abstract class HomeStates{}

class InitialState extends HomeStates{}
class DarkState extends HomeStates{}
class LangState extends HomeStates{}

class GetImageProductLoadingState extends HomeStates{}
class GetImageProductSuccessState extends HomeStates{}
class GetImageProductErrorState extends HomeStates{}
class SearchIndicator extends HomeStates{}

///upload states
class UploadPriceImageSuccess extends HomeStates{}
class UploadPriceImageError extends HomeStates{}
class UploadPriceImageLoading extends HomeStates{}
///update upload image
class UploadEditImageSuccess extends HomeStates{}
class UploadEditImageError extends HomeStates{}
class UploadEditImageLoading extends HomeStates{}

///set price
class PutPriceDataSuccess extends HomeStates{}
class PutPriceDataError extends HomeStates{}
class SetPriceDataLoading extends HomeStates{}

///get prices
class GetPriceDataSuccess extends HomeStates{}
class GetPriceDataError extends HomeStates{}
class GetPriceDataLoading extends HomeStates{}
///delete item
class DeletePriceDataSuccess extends HomeStates{}
class DeletePriceDataError extends HomeStates{}
///Update item
class UpdatePriceDataSuccess extends HomeStates{}
class UpdatePriceDataError extends HomeStates{}
class UpdateImageProductSuccessState extends HomeStates{}
class UpdateImageProductErrorState extends HomeStates{}

///Search item
class SearchPriceDataSuccess extends HomeStates{}
class SearchPriceDataError extends HomeStates{}