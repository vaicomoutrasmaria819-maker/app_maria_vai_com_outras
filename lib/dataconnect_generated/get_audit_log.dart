// part of 'generated.dart';
//
// class GetAuditLogVariablesBuilder {
//   String id;
//
//   final FirebaseDataConnect _dataConnect;
//   GetAuditLogVariablesBuilder(this._dataConnect, {required  this.id,});
//   Deserializer<GetAuditLogData> dataDeserializer = (dynamic json)  => GetAuditLogData.fromJson(jsonDecode(json));
//   Serializer<GetAuditLogVariables> varsSerializer = (GetAuditLogVariables vars) => jsonEncode(vars.toJson());
//   Future<QueryResult<GetAuditLogData, GetAuditLogVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
//     return ref().execute(fetchPolicy: fetchPolicy);
//   }
//
//   QueryRef<GetAuditLogData, GetAuditLogVariables> ref() {
//     GetAuditLogVariables vars= GetAuditLogVariables(id: id,);
//     return _dataConnect.query("GetAuditLog", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class GetAuditLogAuditLog {
//   final String actionType;
//   final Timestamp timestamp;
//   GetAuditLogAuditLog.fromJson(dynamic json):
//
//   actionType = nativeFromJson<String>(json['actionType']),
//   timestamp = Timestamp.fromJson(json['timestamp']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final GetAuditLogAuditLog otherTyped = other as GetAuditLogAuditLog;
//     return actionType == otherTyped.actionType &&
//     timestamp == otherTyped.timestamp;
//
//   }
//   @override
//   int get hashCode => Object.hashAll([actionType.hashCode, timestamp.hashCode]);
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['actionType'] = nativeToJson<String>(actionType);
//     json['timestamp'] = timestamp.toJson();
//     return json;
//   }
//
//   GetAuditLogAuditLog({
//     required this.actionType,
//     required this.timestamp,
//   });
// }
//
// @immutable
// class GetAuditLogData {
//   final GetAuditLogAuditLog? auditLog;
//   GetAuditLogData.fromJson(dynamic json):
//
//   auditLog = json['auditLog'] == null ? null : GetAuditLogAuditLog.fromJson(json['auditLog']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final GetAuditLogData otherTyped = other as GetAuditLogData;
//     return auditLog == otherTyped.auditLog;
//
//   }
//   @override
//   int get hashCode => auditLog.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (auditLog != null) {
//       json['auditLog'] = auditLog!.toJson();
//     }
//     return json;
//   }
//
//   GetAuditLogData({
//     this.auditLog,
//   });
// }
//
// @immutable
// class GetAuditLogVariables {
//   final String id;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   GetAuditLogVariables.fromJson(Map<String, dynamic> json):
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
//     final GetAuditLogVariables otherTyped = other as GetAuditLogVariables;
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
//   GetAuditLogVariables({
//     required this.id,
//   });
// }
//
