// part of 'generated.dart';
//
// class DeleteRoleVariablesBuilder {
//   String id;
//
//   final FirebaseDataConnect _dataConnect;
//   DeleteRoleVariablesBuilder(this._dataConnect, {required  this.id,});
//   Deserializer<DeleteRoleData> dataDeserializer = (dynamic json)  => DeleteRoleData.fromJson(jsonDecode(json));
//   Serializer<DeleteRoleVariables> varsSerializer = (DeleteRoleVariables vars) => jsonEncode(vars.toJson());
//   Future<OperationResult<DeleteRoleData, DeleteRoleVariables>> execute() {
//     return ref().execute();
//   }
//
//   MutationRef<DeleteRoleData, DeleteRoleVariables> ref() {
//     DeleteRoleVariables vars= DeleteRoleVariables(id: id,);
//     return _dataConnect.mutation("DeleteRole", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class DeleteRoleRoleDelete {
//   final String id;
//   DeleteRoleRoleDelete.fromJson(dynamic json):
//
//   id = nativeFromJson<String>(json['id']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final DeleteRoleRoleDelete otherTyped = other as DeleteRoleRoleDelete;
//     return id == otherTyped.id;
//
//   }
//   @override
//   int get hashCode => id.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['id'] = nativeToJson<String>(id);
//     return json;
//   }
//
//   DeleteRoleRoleDelete({
//     required this.id,
//   });
// }
//
// @immutable
// class DeleteRoleData {
//   final DeleteRoleRoleDelete? role_delete;
//   DeleteRoleData.fromJson(dynamic json):
//
//   role_delete = json['role_delete'] == null ? null : DeleteRoleRoleDelete.fromJson(json['role_delete']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final DeleteRoleData otherTyped = other as DeleteRoleData;
//     return role_delete == otherTyped.role_delete;
//
//   }
//   @override
//   int get hashCode => role_delete.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (role_delete != null) {
//       json['role_delete'] = role_delete!.toJson();
//     }
//     return json;
//   }
//
//   DeleteRoleData({
//     this.role_delete,
//   });
// }
//
// @immutable
// class DeleteRoleVariables {
//   final String id;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   DeleteRoleVariables.fromJson(Map<String, dynamic> json):
//
//   id = nativeFromJson<String>(json['id']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final DeleteRoleVariables otherTyped = other as DeleteRoleVariables;
//     return id == otherTyped.id;
//
//   }
//   @override
//   int get hashCode => id.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['id'] = nativeToJson<String>(id);
//     return json;
//   }
//
//   DeleteRoleVariables({
//     required this.id,
//   });
// }
//
