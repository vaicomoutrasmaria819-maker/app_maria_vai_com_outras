// part of 'generated.dart';
//
// class LogActionVariablesBuilder {
//   String actionType;
//
//   final FirebaseDataConnect _dataConnect;
//   LogActionVariablesBuilder(this._dataConnect, {required  this.actionType,});
//   Deserializer<LogActionData> dataDeserializer = (dynamic json)  => LogActionData.fromJson(jsonDecode(json));
//   Serializer<LogActionVariables> varsSerializer = (LogActionVariables vars) => jsonEncode(vars.toJson());
//   Future<OperationResult<LogActionData, LogActionVariables>> execute() {
//     return ref().execute();
//   }
//
//   MutationRef<LogActionData, LogActionVariables> ref() {
//     LogActionVariables vars= LogActionVariables(actionType: actionType,);
//     return _dataConnect.mutation("LogAction", dataDeserializer, varsSerializer, vars);
//   }
// }
//
// @immutable
// class LogActionAuditLogInsert {
//   final String id;
//   LogActionAuditLogInsert.fromJson(dynamic json):
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
//     final LogActionAuditLogInsert otherTyped = other as LogActionAuditLogInsert;
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
//   LogActionAuditLogInsert({
//     required this.id,
//   });
// }
//
// @immutable
// class LogActionData {
//   final LogActionAuditLogInsert auditLog_insert;
//   LogActionData.fromJson(dynamic json):
//
//   auditLog_insert = LogActionAuditLogInsert.fromJson(json['auditLog_insert']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final LogActionData otherTyped = other as LogActionData;
//     return auditLog_insert == otherTyped.auditLog_insert;
//
//   }
//   @override
//   int get hashCode => auditLog_insert.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['auditLog_insert'] = auditLog_insert.toJson();
//     return json;
//   }
//
//   LogActionData({
//     required this.auditLog_insert,
//   });
// }
//
// @immutable
// class LogActionVariables {
//   final String actionType;
//   @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
//   LogActionVariables.fromJson(Map<String, dynamic> json):
//
//   actionType = nativeFromJson<String>(json['actionType']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final LogActionVariables otherTyped = other as LogActionVariables;
//     return actionType == otherTyped.actionType;
//
//   }
//   @override
//   int get hashCode => actionType.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['actionType'] = nativeToJson<String>(actionType);
//     return json;
//   }
//
//   LogActionVariables({
//     required this.actionType,
//   });
// }
//
