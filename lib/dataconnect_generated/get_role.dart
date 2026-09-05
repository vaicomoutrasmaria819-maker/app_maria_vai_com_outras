// part of 'generated.dart';
//
// class GetRoleVariablesBuilder {
//   String id;
//
//   final FirebaseDataConnect _dataConnect;
//   GetRoleVariablesBuilder(this._dataConnect, {required  this.id,});
//   Deserializer<GetRoleData> dataDeserializer = (dynamic json)  => GetRoleData.fromJson(jsonDecode(json));
//   Serializer<GetRoleVariables> varsSerializer = (GetRoleVariables vars) => jsonEncode(vars.toJson());
//   Future<QueryResult<GetRoleData, GetRoleVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
//     return ref().execute(fetchPolicy: fetchPolicy);
//   }
//
//   QueryRef<GetRoleData, GetRoleVariables> ref() {
//     GetRoleVariables vars= GetRoleVariables(id: id,);
//     return _dataConnect.query("GetRole", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class GetRoleRole {
//   final String roleName;
//   final int permissionLevel;
//   GetRoleRole.fromJson(dynamic json):
//
//   roleName = nativeFromJson<String>(json['roleName']),
//   permissionLevel = nativeFromJson<int>(json['permissionLevel']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final GetRoleRole otherTyped = other as GetRoleRole;
//     return roleName == otherTyped.roleName &&
//     permissionLevel == otherTyped.permissionLevel;
//
//   }
//   @override
//   int get hashCode => Object.hashAll([roleName.hashCode, permissionLevel.hashCode]);
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['roleName'] = nativeToJson<String>(roleName);
//     json['permissionLevel'] = nativeToJson<int>(permissionLevel);
//     return json;
//   }
//
//   GetRoleRole({
//     required this.roleName,
//     required this.permissionLevel,
//   });
// }
//
// @immutable
// class GetRoleData {
//   final GetRoleRole? role;
//   GetRoleData.fromJson(dynamic json):
//
//   role = json['role'] == null ? null : GetRoleRole.fromJson(json['role']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final GetRoleData otherTyped = other as GetRoleData;
//     return role == otherTyped.role;
//
//   }
//   @override
//   int get hashCode => role.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (role != null) {
//       json['role'] = role!.toJson();
//     }
//     return json;
//   }
//
//   GetRoleData({
//     this.role,
//   });
// }
//
// @immutable
// class GetRoleVariables {
//   final String id;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   GetRoleVariables.fromJson(Map<String, dynamic> json):
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
//     final GetRoleVariables otherTyped = other as GetRoleVariables;
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
//   GetRoleVariables({
//     required this.id,
//   });
// }
//
