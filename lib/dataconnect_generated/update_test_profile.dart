// part of 'generated.dart';
//
// class UpdateTestProfileVariablesBuilder {
//   String id;
//   String status;
//
//   final FirebaseDataConnect _dataConnect;
//   UpdateTestProfileVariablesBuilder(this._dataConnect, {required  this.id,required  this.status,});
//   Deserializer<UpdateTestProfileData> dataDeserializer = (dynamic json)  => UpdateTestProfileData.fromJson(jsonDecode(json));
//   Serializer<UpdateTestProfileVariables> varsSerializer = (UpdateTestProfileVariables vars) => jsonEncode(vars.toJson());
//   Future<OperationResult<UpdateTestProfileData, UpdateTestProfileVariables>> execute() {
//     return ref().execute();
//   }
//
//   MutationRef<UpdateTestProfileData, UpdateTestProfileVariables> ref() {
//     UpdateTestProfileVariables vars= UpdateTestProfileVariables(id: id,status: status,);
//     return _dataConnect.mutation("UpdateTestProfile", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class UpdateTestProfileTestProfileUpdate {
//   final String id;
//   UpdateTestProfileTestProfileUpdate.fromJson(dynamic json):
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
//     final UpdateTestProfileTestProfileUpdate otherTyped = other as UpdateTestProfileTestProfileUpdate;
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
//   UpdateTestProfileTestProfileUpdate({
//     required this.id,
//   });
// }
//
// @immutable
// class UpdateTestProfileData {
//   final UpdateTestProfileTestProfileUpdate? testProfile_update;
//   UpdateTestProfileData.fromJson(dynamic json):
//
//   testProfile_update = json['testProfile_update'] == null ? null : UpdateTestProfileTestProfileUpdate.fromJson(json['testProfile_update']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final UpdateTestProfileData otherTyped = other as UpdateTestProfileData;
//     return testProfile_update == otherTyped.testProfile_update;
//
//   }
//   @override
//   int get hashCode => testProfile_update.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (testProfile_update != null) {
//       json['testProfile_update'] = testProfile_update!.toJson();
//     }
//     return json;
//   }
//
//   UpdateTestProfileData({
//     this.testProfile_update,
//   });
// }
//
// @immutable
// class UpdateTestProfileVariables {
//   final String id;
//   final String status;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   UpdateTestProfileVariables.fromJson(Map<String, dynamic> json):
//
//   id = nativeFromJson<String>(json['id']),
//   status = nativeFromJson<String>(json['status']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final UpdateTestProfileVariables otherTyped = other as UpdateTestProfileVariables;
//     return id == otherTyped.id &&
//     status == otherTyped.status;
//
//   }
//   @override
//   int get hashCode => Object.hashAll([id.hashCode, status.hashCode]);
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['id'] = nativeToJson<String>(id);
//     json['status'] = nativeToJson<String>(status);
//     return json;
//   }
//
//   UpdateTestProfileVariables({
//     required this.id,
//     required this.status,
//   });
// }
//
