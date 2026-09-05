// part of 'generated.dart';
//
// class ListAuditLogsVariablesBuilder {
//
//   final FirebaseDataConnect _dataConnect;
//   ListAuditLogsVariablesBuilder(this._dataConnect, );
//   Deserializer<ListAuditLogsData> dataDeserializer = (dynamic json)  => ListAuditLogsData.fromJson(jsonDecode(json));
//
//   Future<QueryResult<ListAuditLogsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
//     return ref().execute(fetchPolicy: fetchPolicy);
//   }
//
//   QueryRef<ListAuditLogsData, void> ref() {
//
//     return _dataConnect.query("ListAuditLogs", dataDeserializer, emptySerializer, null);
//   }
// }
//
// @immutable
// class ListAuditLogsAuditLogs {
//   final String actionType;
//   final ListAuditLogsAuditLogsActorUser? actorUser;
//   ListAuditLogsAuditLogs.fromJson(dynamic json):
//
//   actionType = nativeFromJson<String>(json['actionType']),
//   actorUser = json['actorUser'] == null ? null : ListAuditLogsAuditLogsActorUser.fromJson(json['actorUser']);
//   @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) {
//       return true;
//     }
//     if(other.runtimeType != runtimeType) {
//       return false;
//     }
//
//     final ListAuditLogsAuditLogs otherTyped = other as ListAuditLogsAuditLogs;
//     return actionType == otherTyped.actionType &&
//     actorUser == otherTyped.actorUser;
//
//   }
//   @override
//   int get hashCode => Object.hashAll([actionType.hashCode, actorUser.hashCode]);
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['actionType'] = nativeToJson<String>(actionType);
//     if (actorUser != null) {
//       json['actorUser'] = actorUser!.toJson();
//     }
//     return json;
//   }
//
//   ListAuditLogsAuditLogs({
//     required this.actionType,
//     this.actorUser,
//   });
// }
//
// @immutable
// class ListAuditLogsAuditLogsActorUser {
//   final String? displayName;
//   ListAuditLogsAuditLogsActorUser.fromJson(dynamic json):
//
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
//     final ListAuditLogsAuditLogsActorUser otherTyped = other as ListAuditLogsAuditLogsActorUser;
//     return displayName == otherTyped.displayName;
//
//   }
//   @override
//   int get hashCode => displayName.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (displayName != null) {
//       json['displayName'] = nativeToJson<String?>(displayName);
//     }
//     return json;
//   }
//
//   ListAuditLogsAuditLogsActorUser({
//     this.displayName,
//   });
// }
//
// @immutable
// class ListAuditLogsData {
//   final List<ListAuditLogsAuditLogs> auditLogs;
//   ListAuditLogsData.fromJson(dynamic json):
//
//   auditLogs = (json['auditLogs'] as List<dynamic>)
//         .map((e) => ListAuditLogsAuditLogs.fromJson(e))
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
//     final ListAuditLogsData otherTyped = other as ListAuditLogsData;
//     return auditLogs == otherTyped.auditLogs;
//
//   }
//   @override
//   int get hashCode => auditLogs.hashCode;
//
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['auditLogs'] = auditLogs.map((e) => e.toJson()).toList();
//     return json;
//   }
//
//   ListAuditLogsData({
//     required this.auditLogs,
//   });
// }
//
