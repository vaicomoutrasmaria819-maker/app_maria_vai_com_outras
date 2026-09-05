// part of 'generated.dart';
//
// class GetMyUserVariablesBuilder {
//
//   final FirebaseDataConnect _dataConnect;
//   GetMyUserVariablesBuilder(this._dataConnect, );
//   Deserializer<GetMyUserData> dataDeserializer = (dynamic json)  => GetMyUserData.fromJson(jsonDecode(json));
//
//   Future<QueryResult<GetMyUserData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
//     return ref().execute(fetchPolicy: fetchPolicy);
//   }
//
//   QueryRef<GetMyUserData, void> ref() {
//
//     return _dataConnect.query("GetMyUser", dataDeserializer, emptySerializer, null);
//   }
// }
//
// @immutable
// class GetMyUserUser {
//   final String email;
//   final String? displayName;
//   GetMyUserUser.fromJson(dynamic json):
//
//   email = nativeFromJson<String>(json['email']),
//   displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final GetMyUserUser otherTyped = other as GetMyUserUser;
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
//     if (displayName != null) {
//       json['displayName'] = nativeToJson<String?>(displayName);
//     }
//     return json;
//   }
//
//   GetMyUserUser({
//     required this.email,
//     this.displayName,
//   });
// }
//
// @immutable
// class GetMyUserData {
//   final GetMyUserUser? user;
//   GetMyUserData.fromJson(dynamic json):
//
//   user = json['user'] == null ? null : GetMyUserUser.fromJson(json['user']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final GetMyUserData otherTyped = other as GetMyUserData;
//     return user == otherTyped.user;
//
//   }
//   @override
//   int get hashCode => user.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (user != null) {
//       json['user'] = user!.toJson();
//     }
//     return json;
//   }
//
//   GetMyUserData({
//     this.user,
//   });
// }
//
