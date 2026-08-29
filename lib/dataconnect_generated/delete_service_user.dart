part of 'generated.dart';

class DeleteServiceUserVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteServiceUserVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteServiceUserData> dataDeserializer = (dynamic json)  => DeleteServiceUserData.fromJson(jsonDecode(json));
  Serializer<DeleteServiceUserVariables> varsSerializer = (DeleteServiceUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteServiceUserData, DeleteServiceUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteServiceUserData, DeleteServiceUserVariables> ref() {
    DeleteServiceUserVariables vars= DeleteServiceUserVariables(id: id,);
    return _dataConnect.mutation("DeleteServiceUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteServiceUserServiceUserDelete {
  final String id;
  DeleteServiceUserServiceUserDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteServiceUserServiceUserDelete otherTyped = other as DeleteServiceUserServiceUserDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteServiceUserServiceUserDelete({
    required this.id,
  });
}

@immutable
class DeleteServiceUserData {
  final DeleteServiceUserServiceUserDelete? serviceUser_delete;
  DeleteServiceUserData.fromJson(dynamic json):
  
  serviceUser_delete = json['serviceUser_delete'] == null ? null : DeleteServiceUserServiceUserDelete.fromJson(json['serviceUser_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteServiceUserData otherTyped = other as DeleteServiceUserData;
    return serviceUser_delete == otherTyped.serviceUser_delete;
    
  }
  @override
  int get hashCode => serviceUser_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (serviceUser_delete != null) {
      json['serviceUser_delete'] = serviceUser_delete!.toJson();
    }
    return json;
  }

  DeleteServiceUserData({
    this.serviceUser_delete,
  });
}

@immutable
class DeleteServiceUserVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteServiceUserVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteServiceUserVariables otherTyped = other as DeleteServiceUserVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteServiceUserVariables({
    required this.id,
  });
}

