// part of 'generated.dart';
//
// class CreateServiceUserVariablesBuilder {
//   String serviceName;
//   String apiKeyHash;
//
//   final FirebaseDataConnect _dataConnect;
//   CreateServiceUserVariablesBuilder(this._dataConnect, {required  this.serviceName,required  this.apiKeyHash,});
//   Deserializer<CreateServiceUserData> dataDeserializer = (dynamic json)  => CreateServiceUserData.fromJson(jsonDecode(json));
//   Serializer<CreateServiceUserVariables> varsSerializer = (CreateServiceUserVariables vars) => jsonEncode(vars.toJson());
//   Future<OperationResult<CreateServiceUserData, CreateServiceUserVariables>> execute() {
//     return ref().execute();
//   }
//
//   MutationRef<CreateServiceUserData, CreateServiceUserVariables> ref() {
//     CreateServiceUserVariables vars= CreateServiceUserVariables(serviceName: serviceName,apiKeyHash: apiKeyHash,);
//     return _dataConnect.mutation("CreateServiceUser", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class CreateServiceUserServiceUserInsert {
//   final String id;
//   CreateServiceUserServiceUserInsert.fromJson(dynamic json):
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
//     final CreateServiceUserServiceUserInsert otherTyped = other as CreateServiceUserServiceUserInsert;
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
//   CreateServiceUserServiceUserInsert({
//     required this.id,
//   });
// }
//
// @immutable
// class CreateServiceUserData {
//   final CreateServiceUserServiceUserInsert serviceUser_insert;
//   CreateServiceUserData.fromJson(dynamic json):
//
//   serviceUser_insert = CreateServiceUserServiceUserInsert.fromJson(json['serviceUser_insert']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final CreateServiceUserData otherTyped = other as CreateServiceUserData;
//     return serviceUser_insert == otherTyped.serviceUser_insert;
//
//   }
//   @override
//   int get hashCode => serviceUser_insert.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['serviceUser_insert'] = serviceUser_insert.toJson();
//     return json;
//   }
//
//   CreateServiceUserData({
//     required this.serviceUser_insert,
//   });
// }
//
// @immutable
// class CreateServiceUserVariables {
//   final String serviceName;
//   final String apiKeyHash;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   CreateServiceUserVariables.fromJson(Map<String, dynamic> json):
//
//   serviceName = nativeFromJson<String>(json['serviceName']),
//   apiKeyHash = nativeFromJson<String>(json['apiKeyHash']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final CreateServiceUserVariables otherTyped = other as CreateServiceUserVariables;
//     return serviceName == otherTyped.serviceName &&
//     apiKeyHash == otherTyped.apiKeyHash;
//
//   }
//   @override
//   int get hashCode => Object.hashAll([serviceName.hashCode, apiKeyHash.hashCode]);
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['serviceName'] = nativeToJson<String>(serviceName);
//     json['apiKeyHash'] = nativeToJson<String>(apiKeyHash);
//     return json;
//   }
//
//   CreateServiceUserVariables({
//     required this.serviceName,
//     required this.apiKeyHash,
//   });
// }
//
