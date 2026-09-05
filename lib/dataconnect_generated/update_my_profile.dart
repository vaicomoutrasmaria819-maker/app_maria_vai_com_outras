// part of 'generated.dart';
//
// class UpdateMyProfileVariablesBuilder {
//   Optional<String> _displayName = Optional.optional(nativeFromJson, nativeToJson);
//
//   final FirebaseDataConnect _dataConnect;
//   UpdateMyProfileVariablesBuilder displayName(String? t) {
//    _displayName.value = t;
//    return this;
//   }
//
//   UpdateMyProfileVariablesBuilder(this._dataConnect, );
//   Deserializer<UpdateMyProfileData> dataDeserializer = (dynamic json)  => UpdateMyProfileData.fromJson(jsonDecode(json));
//   Serializer<UpdateMyProfileVariables> varsSerializer = (UpdateMyProfileVariables vars) => jsonEncode(vars.toJson());
//   Future<OperationResult<UpdateMyProfileData, UpdateMyProfileVariables>> execute() {
//     return ref().execute();
//   }
//
//   MutationRef<UpdateMyProfileData, UpdateMyProfileVariables> ref() {
//     UpdateMyProfileVariables vars= UpdateMyProfileVariables(displayName: _displayName,);
//     return _dataConnect.mutation("UpdateMyProfile", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class UpdateMyProfileUserUpdate {
//   final String id;
//   UpdateMyProfileUserUpdate.fromJson(dynamic json):
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
//     final UpdateMyProfileUserUpdate otherTyped = other as UpdateMyProfileUserUpdate;
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
//   UpdateMyProfileUserUpdate({
//     required this.id,
//   });
// }
//
// @immutable
// class UpdateMyProfileData {
//   final UpdateMyProfileUserUpdate? user_update;
//   UpdateMyProfileData.fromJson(dynamic json):
//
//   user_update = json['user_update'] == null ? null : UpdateMyProfileUserUpdate.fromJson(json['user_update']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final UpdateMyProfileData otherTyped = other as UpdateMyProfileData;
//     return user_update == otherTyped.user_update;
//
//   }
//   @override
//   int get hashCode => user_update.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (user_update != null) {
//       json['user_update'] = user_update!.toJson();
//     }
//     return json;
//   }
//
//   UpdateMyProfileData({
//     this.user_update,
//   });
// }
//
// @immutable
// class UpdateMyProfileVariables {
//   late final Optional<String>displayName;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   UpdateMyProfileVariables.fromJson(Map<String, dynamic> json) {
//
//
//     displayName = Optional.optional(nativeFromJson, nativeToJson);
//     displayName.value = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);
//
//   }
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final UpdateMyProfileVariables otherTyped = other as UpdateMyProfileVariables;
//     return displayName == otherTyped.displayName;
//
//   }
//   @override
//   int get hashCode => displayName.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if(displayName.state == OptionalState.set) {
//       json['displayName'] = displayName.toJson();
//     }
//     return json;
//   }
//
//   UpdateMyProfileVariables({
//     required this.displayName,
//   });
// }
//
