// library dataconnect_generated;
// import 'package:firebase_data_connect/firebase_data_connect.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:convert';
//
// part 'create_user.dart';
//
// part 'update_my_profile.dart';
//
// part 'delete_user.dart';
//
// part 'get_my_user.dart';
//
// part 'list_users.dart';
//
// part 'create_role.dart';
//
// part 'update_role.dart';
//
// part 'delete_role.dart';
//
// part 'get_role.dart';
//
// part 'list_roles.dart';
//
// part 'create_test_profile.dart';
//
// part 'update_test_profile.dart';
//
// part 'delete_test_profile.dart';
//
// part 'get_test_profile.dart';
//
// part 'list_my_test_profiles.dart';
//
// part 'create_service_user.dart';
//
// part 'update_service_user.dart';
//
// part 'delete_service_user.dart';
//
// part 'get_service_user.dart';
//
// part 'list_my_service_users.dart';
//
// part 'log_action.dart';
//
// part 'update_audit_log.dart';
//
// part 'delete_audit_log.dart';
//
// part 'get_audit_log.dart';
//
// part 'list_audit_logs.dart';
//
//
//
//
//
//
//
// class ExampleConnector {
//
//
//   CreateUserVariablesBuilder createUser ({required String email, }) {
//     return CreateUserVariablesBuilder(dataConnect, email: email,);
//   }
//
//
//   UpdateMyProfileVariablesBuilder updateMyProfile () {
//     return UpdateMyProfileVariablesBuilder(dataConnect, );
//   }
//
//
//   DeleteUserVariablesBuilder deleteUser () {
//     return DeleteUserVariablesBuilder(dataConnect, );
//   }
//
//
//   GetMyUserVariablesBuilder getMyUser () {
//     return GetMyUserVariablesBuilder(dataConnect, );
//   }
//
//
//   ListUsersVariablesBuilder listUsers () {
//     return ListUsersVariablesBuilder(dataConnect, );
//   }
//
//
//   CreateRoleVariablesBuilder createRole ({required String roleName, required int permissionLevel, }) {
//     return CreateRoleVariablesBuilder(dataConnect, roleName: roleName,permissionLevel: permissionLevel,);
//   }
//
//
//   UpdateRoleVariablesBuilder updateRole ({required String id, required int permissionLevel, }) {
//     return UpdateRoleVariablesBuilder(dataConnect, id: id,permissionLevel: permissionLevel,);
//   }
//
//
//   DeleteRoleVariablesBuilder deleteRole ({required String id, }) {
//     return DeleteRoleVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   GetRoleVariablesBuilder getRole ({required String id, }) {
//     return GetRoleVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   ListRolesVariablesBuilder listRoles () {
//     return ListRolesVariablesBuilder(dataConnect, );
//   }
//
//
//   CreateTestProfileVariablesBuilder createTestProfile ({required String environment, required String status, }) {
//     return CreateTestProfileVariablesBuilder(dataConnect, environment: environment,status: status,);
//   }
//
//
//   UpdateTestProfileVariablesBuilder updateTestProfile ({required String id, required String status, }) {
//     return UpdateTestProfileVariablesBuilder(dataConnect, id: id,status: status,);
//   }
//
//
//   DeleteTestProfileVariablesBuilder deleteTestProfile ({required String id, }) {
//     return DeleteTestProfileVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   GetTestProfileVariablesBuilder getTestProfile ({required String id, }) {
//     return GetTestProfileVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   ListMyTestProfilesVariablesBuilder listMyTestProfiles () {
//     return ListMyTestProfilesVariablesBuilder(dataConnect, );
//   }
//
//
//   CreateServiceUserVariablesBuilder createServiceUser ({required String serviceName, required String apiKeyHash, }) {
//     return CreateServiceUserVariablesBuilder(dataConnect, serviceName: serviceName,apiKeyHash: apiKeyHash,);
//   }
//
//
//   UpdateServiceUserVariablesBuilder updateServiceUser ({required String id, required String scope, }) {
//     return UpdateServiceUserVariablesBuilder(dataConnect, id: id,scope: scope,);
//   }
//
//
//   DeleteServiceUserVariablesBuilder deleteServiceUser ({required String id, }) {
//     return DeleteServiceUserVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   GetServiceUserVariablesBuilder getServiceUser ({required String id, }) {
//     return GetServiceUserVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   ListMyServiceUsersVariablesBuilder listMyServiceUsers () {
//     return ListMyServiceUsersVariablesBuilder(dataConnect, );
//   }
//
//
//   LogActionVariablesBuilder logAction ({required String actionType, }) {
//     return LogActionVariablesBuilder(dataConnect, actionType: actionType,);
//   }
//
//
//   UpdateAuditLogVariablesBuilder updateAuditLog ({required String id, required String metadata, }) {
//     return UpdateAuditLogVariablesBuilder(dataConnect, id: id,metadata: metadata,);
//   }
//
//
//   DeleteAuditLogVariablesBuilder deleteAuditLog ({required String id, }) {
//     return DeleteAuditLogVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   GetAuditLogVariablesBuilder getAuditLog ({required String id, }) {
//     return GetAuditLogVariablesBuilder(dataConnect, id: id,);
//   }
//
//
//   ListAuditLogsVariablesBuilder listAuditLogs () {
//     return ListAuditLogsVariablesBuilder(dataConnect, );
//   }
//
//
//   static ConnectorConfig connectorConfig = ConnectorConfig(
//     'us-east4',
//     'example',
//     'mariavaiservices',
//   );
//
//   ExampleConnector({required this.dataConnect});
//   static ExampleConnector get instance {
//
//     CacheSettings cacheSettings = CacheSettings(
//       maxAge: Duration(milliseconds:0),
//       storage: CacheStorage.persistent,
//     );
//
//     return ExampleConnector(
//         dataConnect: FirebaseDataConnect.instanceFor(
//             connectorConfig: connectorConfig,
//
//             cacheSettings: cacheSettings,
//
//             sdkType: CallerSDKType.generated));
//   }
//
//   FirebaseDataConnect dataConnect;
// }
