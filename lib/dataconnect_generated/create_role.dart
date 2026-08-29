part of 'generated.dart';

class CreateRoleVariablesBuilder {
  String roleName;
  int permissionLevel;

  final FirebaseDataConnect _dataConnect;
  CreateRoleVariablesBuilder(this._dataConnect, {required  this.roleName,required  this.permissionLevel,});
  Deserializer<CreateRoleData> dataDeserializer = (dynamic json)  => CreateRoleData.fromJson(jsonDecode(json));
  Serializer<CreateRoleVariables> varsSerializer = (CreateRoleVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateRoleData, CreateRoleVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateRoleData, CreateRoleVariables> ref() {
    CreateRoleVariables vars= CreateRoleVariables(roleName: roleName,permissionLevel: permissionLevel,);
    return _dataConnect.mutation("CreateRole", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateRoleRoleInsert {
  final String id;
  CreateRoleRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRoleRoleInsert otherTyped = other as CreateRoleRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateRoleRoleInsert({
    required this.id,
  });
}

@immutable
class CreateRoleData {
  final CreateRoleRoleInsert role_insert;
  CreateRoleData.fromJson(dynamic json):
  
  role_insert = CreateRoleRoleInsert.fromJson(json['role_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRoleData otherTyped = other as CreateRoleData;
    return role_insert == otherTyped.role_insert;
    
  }
  @override
  int get hashCode => role_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['role_insert'] = role_insert.toJson();
    return json;
  }

  CreateRoleData({
    required this.role_insert,
  });
}

@immutable
class CreateRoleVariables {
  final String roleName;
  final int permissionLevel;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateRoleVariables.fromJson(Map<String, dynamic> json):
  
  roleName = nativeFromJson<String>(json['roleName']),
  permissionLevel = nativeFromJson<int>(json['permissionLevel']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateRoleVariables otherTyped = other as CreateRoleVariables;
    return roleName == otherTyped.roleName && 
    permissionLevel == otherTyped.permissionLevel;
    
  }
  @override
  int get hashCode => Object.hashAll([roleName.hashCode, permissionLevel.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['roleName'] = nativeToJson<String>(roleName);
    json['permissionLevel'] = nativeToJson<int>(permissionLevel);
    return json;
  }

  CreateRoleVariables({
    required this.roleName,
    required this.permissionLevel,
  });
}

