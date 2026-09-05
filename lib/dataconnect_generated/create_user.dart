// part of 'generated.dart';
//
// class CreateUserVariablesBuilder {
//   String email;
//   Optional<String> _displayName = Optional.optional(nativeFromJson, nativeToJson);
//
//   final FirebaseDataConnect _dataConnect;  CreateUserVariablesBuilder displayName(String? t) {
//    _displayName.value = t;
//    return this;
//   }
//
//   CreateUserVariablesBuilder(this._dataConnect, {required  this.email,});
//   Deserializer<CreateUserData> dataDeserializer = (dynamic json)  => CreateUserData.fromJson(jsonDecode(json));
//   Serializer<CreateUserVariables> varsSerializer = (CreateUserVariables vars) => jsonEncode(vars.toJson());
//   Future<OperationResult<CreateUserData, CreateUserVariables>> execute() {
//     return ref().execute();
//   }
//
//   MutationRef<CreateUserData, CreateUserVariables> ref() {
//     CreateUserVariables vars= CreateUserVariables(email: email,displayName: _displayName,);
//     return _dataConnect.mutation("CreateUser", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class CreateUserUserInsert {
//   final String id;
//   CreateUserUserInsert.fromJson(dynamic json):
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
//     final CreateUserUserInsert otherTyped = other as CreateUserUserInsert;
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
//   CreateUserUserInsert({
//     required this.id,
//   });
// }
//
// @immutable
// class CreateUserData {
//   final CreateUserUserInsert user_insert;
//   CreateUserData.fromJson(dynamic json):
//
//   user_insert = CreateUserUserInsert.fromJson(json['user_insert']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final CreateUserData otherTyped = other as CreateUserData;
//     return user_insert == otherTyped.user_insert;
//
//   }
//   @override
//   int get hashCode => user_insert.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['user_insert'] = user_insert.toJson();
//     return json;
//   }
//
//   CreateUserData({
//     required this.user_insert,
//   });
// }
//
// @immutable
// class CreateUserVariables {
//   final String email;
//   late final Optional<String>displayName;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   CreateUserVariables.fromJson(Map<String, dynamic> json):
//
//   email = nativeFromJson<String>(json['email']) {
//
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
//     final CreateUserVariables otherTyped = other as CreateUserVariables;
//     return email == otherTyped.email &&
//     displayName == otherTyped.displayName;
//
//   }
//   @override
//   int get hashCode => Object.hashAll([email.hashCode, displayName.hashCode]);
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['email'] = nativeToJson<String>(email);
//     if(displayName.state == OptionalState.set) {
//       json['displayName'] = displayName.toJson();
//     }
//     return json;
//   }
//
//   CreateUserVariables({
//     required this.email,
//     required this.displayName,
//   });
// }
//
