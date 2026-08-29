part of 'generated.dart';

class UpdateServiceUserVariablesBuilder {
  String id;
  String scope;

  final FirebaseDataConnect _dataConnect;
  UpdateServiceUserVariablesBuilder(this._dataConnect, {required  this.id,required  this.scope,});
  Deserializer<UpdateServiceUserData> dataDeserializer = (dynamic json)  => UpdateServiceUserData.fromJson(jsonDecode(json));
  Serializer<UpdateServiceUserVariables> varsSerializer = (UpdateServiceUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateServiceUserData, UpdateServiceUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateServiceUserData, UpdateServiceUserVariables> ref() {
    UpdateServiceUserVariables vars= UpdateServiceUserVariables(id: id,scope: scope,);
    return _dataConnect.mutation("UpdateServiceUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateServiceUserServiceUserUpdate {
  final String id;
  UpdateServiceUserServiceUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateServiceUserServiceUserUpdate otherTyped = other as UpdateServiceUserServiceUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateServiceUserServiceUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateServiceUserData {
  final UpdateServiceUserServiceUserUpdate? serviceUser_update;
  UpdateServiceUserData.fromJson(dynamic json):
  
  serviceUser_update = json['serviceUser_update'] == null ? null : UpdateServiceUserServiceUserUpdate.fromJson(json['serviceUser_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateServiceUserData otherTyped = other as UpdateServiceUserData;
    return serviceUser_update == otherTyped.serviceUser_update;
    
  }
  @override
  int get hashCode => serviceUser_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (serviceUser_update != null) {
      json['serviceUser_update'] = serviceUser_update!.toJson();
    }
    return json;
  }

  UpdateServiceUserData({
    this.serviceUser_update,
  });
}

@immutable
class UpdateServiceUserVariables {
  final String id;
  final String scope;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateServiceUserVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  scope = nativeFromJson<String>(json['scope']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateServiceUserVariables otherTyped = other as UpdateServiceUserVariables;
    return id == otherTyped.id && 
    scope == otherTyped.scope;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, scope.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['scope'] = nativeToJson<String>(scope);
    return json;
  }

  UpdateServiceUserVariables({
    required this.id,
    required this.scope,
  });
}

