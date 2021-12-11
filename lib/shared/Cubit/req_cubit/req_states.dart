abstract class ReqStates {}

class initialState extends ReqStates {}
class CheckState extends ReqStates {}
///add to reqModel
class AddDataSuccess extends ReqStates {}
class AddDataError extends ReqStates {}
///Listen to reqModel
  class ListenDataSuccess extends ReqStates {}
class ListenDataLoading extends ReqStates {}
///delete to reqModel
class DeleteDataSuccess extends ReqStates {}
class DeleteDataLoading extends ReqStates {}
class DeleteDataError extends ReqStates {}

class DeleteAllDataSuccess extends ReqStates {}
class DeleteAllDataLoading extends ReqStates {}
class DeleteAllDataError extends ReqStates {}
///Update to reqModel
class UpdateDataSuccess extends ReqStates {}
class UpdateDataError extends ReqStates {}
///Hamada to reqModel
class HamadaDataSuccess extends ReqStates {}
class HamadaDataError extends ReqStates {}
