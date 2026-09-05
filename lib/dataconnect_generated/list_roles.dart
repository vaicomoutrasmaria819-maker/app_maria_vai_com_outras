// part of 'generated.dart';
//
// class ListRolesVariablesBuilder {
//
//   final FirebaseDataConnect _dataConnect;
//   ListRolesVariablesBuilder(this._dataConnect, );
//   Deserializer<ListRolesData> dataDeserializer = (dynamic json)  => ListRolesData.fromJson(jsonDecode(json));
//
//   Future<QueryResult<ListRolesData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
//     return ref().execute(fetchPolicy: fetchPolicy);
//   }
//
//   QueryRef<ListRolesData, void> ref() {
//
//     return _dataConnect.query("ListRoles", dataDeserializer, emptySerializer, null);
//   }
// }
//
// @immutable
// class ListRolesRoles {
//   final String roleName;
//   ListRolesRoles.fromJson(dynamic json):
//
//   roleName = nativeFromJson<String>(json['roleName']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final ListRolesRoles otherTyped = other as ListRolesRoles;
//     return roleName == otherTyped.roleName;
//
//   }
//   @override
//   int get hashCode => roleName.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['roleName'] = nativeToJson<String>(roleName);
//     return json;
//   }
//
//   ListRolesRoles({
//     required this.roleName,
//   });
// }
//
// @immutable
// class ListRolesData {
//   final List<ListRolesRoles> roles;
//   ListRolesData.fromJson(dynamic json):
//
//   roles = (json['roles'] as List<dynamic>)
//         .map((e) => ListRolesRoles.fromJson(e))
//         .toList();
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final ListRolesData otherTyped = other as ListRolesData;
//     return roles == otherTyped.roles;
//
//   }
//   @override
//   int get hashCode => roles.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['roles'] = roles.map((e) => e.toJson()).toList();
//     return json;
//   }
//
//   ListRolesData({
//     required this.roles,
//   });
// }
//
