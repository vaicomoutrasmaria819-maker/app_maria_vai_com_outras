part of 'generated.dart';

class UpdateRoleVariablesBuilder {
  String id;
  int permissionLevel;

  final FirebaseDataConnect _dataConnect;
  UpdateRoleVariablesBuilder(this._dataConnect, {required  this.id,required  this.permissionLevel,});
  Deserializer<UpdateRoleData> dataDeserializer = (dynamic json)  => UpdateRoleData.fromJson(jsonDecode(json));
  Serializer<UpdateRoleVariables> varsSerializer = (UpdateRoleVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateRoleData, UpdateRoleVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateRoleData, UpdateRoleVariables> ref() {
    UpdateRoleVariables vars= UpdateRoleVariables(id: id,permissionLevel: permissionLevel,);
    return _dataConnect.mutation("UpdateRole", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateRoleRoleUpdate {
  final String id;
  UpdateRoleRoleUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateRoleRoleUpdate otherTyped = other as UpdateRoleRoleUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateRoleRoleUpdate({
    required this.id,
  });
}

@immutable
class UpdateRoleData {
  final UpdateRoleRoleUpdate? role_update;
  UpdateRoleData.fromJson(dynamic json):
  
  role_update = json['role_update'] == null ? null : UpdateRoleRoleUpdate.fromJson(json['role_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateRoleData otherTyped = other as UpdateRoleData;
    return role_update == otherTyped.role_update;
    
  }
  @override
  int get hashCode => role_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (role_update != null) {
      json['role_update'] = role_update!.toJson();
    }
    return json;
  }

  UpdateRoleData({
    this.role_update,
  });
}

@immutable
class UpdateRoleVariables {
  final String id;
  final int permissionLevel;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateRoleVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  permissionLevel = nativeFromJson<int>(json['permissionLevel']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateRoleVariables otherTyped = other as UpdateRoleVariables;
    return id == otherTyped.id && 
    permissionLevel == otherTyped.permissionLevel;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, permissionLevel.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['permissionLevel'] = nativeToJson<int>(permissionLevel);
    return json;
  }

  UpdateRoleVariables({
    required this.id,
    required this.permissionLevel,
  });
}

