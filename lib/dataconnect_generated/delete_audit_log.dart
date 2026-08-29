part of 'generated.dart';

class DeleteAuditLogVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteAuditLogVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteAuditLogData> dataDeserializer = (dynamic json)  => DeleteAuditLogData.fromJson(jsonDecode(json));
  Serializer<DeleteAuditLogVariables> varsSerializer = (DeleteAuditLogVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteAuditLogData, DeleteAuditLogVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteAuditLogData, DeleteAuditLogVariables> ref() {
    DeleteAuditLogVariables vars= DeleteAuditLogVariables(id: id,);
    return _dataConnect.mutation("DeleteAuditLog", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteAuditLogAuditLogDelete {
  final String id;
  DeleteAuditLogAuditLogDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAuditLogAuditLogDelete otherTyped = other as DeleteAuditLogAuditLogDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteAuditLogAuditLogDelete({
    required this.id,
  });
}

@immutable
class DeleteAuditLogData {
  final DeleteAuditLogAuditLogDelete? auditLog_delete;
  DeleteAuditLogData.fromJson(dynamic json):
  
  auditLog_delete = json['auditLog_delete'] == null ? null : DeleteAuditLogAuditLogDelete.fromJson(json['auditLog_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAuditLogData otherTyped = other as DeleteAuditLogData;
    return auditLog_delete == otherTyped.auditLog_delete;
    
  }
  @override
  int get hashCode => auditLog_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (auditLog_delete != null) {
      json['auditLog_delete'] = auditLog_delete!.toJson();
    }
    return json;
  }

  DeleteAuditLogData({
    this.auditLog_delete,
  });
}

@immutable
class DeleteAuditLogVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteAuditLogVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteAuditLogVariables otherTyped = other as DeleteAuditLogVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteAuditLogVariables({
    required this.id,
  });
}

