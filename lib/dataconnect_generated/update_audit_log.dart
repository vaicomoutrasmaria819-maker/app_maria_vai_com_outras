part of 'generated.dart';

class UpdateAuditLogVariablesBuilder {
  String id;
  String metadata;

  final FirebaseDataConnect _dataConnect;
  UpdateAuditLogVariablesBuilder(this._dataConnect, {required  this.id,required  this.metadata,});
  Deserializer<UpdateAuditLogData> dataDeserializer = (dynamic json)  => UpdateAuditLogData.fromJson(jsonDecode(json));
  Serializer<UpdateAuditLogVariables> varsSerializer = (UpdateAuditLogVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateAuditLogData, UpdateAuditLogVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateAuditLogData, UpdateAuditLogVariables> ref() {
    UpdateAuditLogVariables vars= UpdateAuditLogVariables(id: id,metadata: metadata,);
    return _dataConnect.mutation("UpdateAuditLog", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateAuditLogAuditLogUpdate {
  final String id;
  UpdateAuditLogAuditLogUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAuditLogAuditLogUpdate otherTyped = other as UpdateAuditLogAuditLogUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateAuditLogAuditLogUpdate({
    required this.id,
  });
}

@immutable
class UpdateAuditLogData {
  final UpdateAuditLogAuditLogUpdate? auditLog_update;
  UpdateAuditLogData.fromJson(dynamic json):
  
  auditLog_update = json['auditLog_update'] == null ? null : UpdateAuditLogAuditLogUpdate.fromJson(json['auditLog_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAuditLogData otherTyped = other as UpdateAuditLogData;
    return auditLog_update == otherTyped.auditLog_update;
    
  }
  @override
  int get hashCode => auditLog_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (auditLog_update != null) {
      json['auditLog_update'] = auditLog_update!.toJson();
    }
    return json;
  }

  UpdateAuditLogData({
    this.auditLog_update,
  });
}

@immutable
class UpdateAuditLogVariables {
  final String id;
  final String metadata;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateAuditLogVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  metadata = nativeFromJson<String>(json['metadata']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateAuditLogVariables otherTyped = other as UpdateAuditLogVariables;
    return id == otherTyped.id && 
    metadata == otherTyped.metadata;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, metadata.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['metadata'] = nativeToJson<String>(metadata);
    return json;
  }

  UpdateAuditLogVariables({
    required this.id,
    required this.metadata,
  });
}

