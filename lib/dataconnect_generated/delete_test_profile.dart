part of 'generated.dart';

class DeleteTestProfileVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteTestProfileVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteTestProfileData> dataDeserializer = (dynamic json)  => DeleteTestProfileData.fromJson(jsonDecode(json));
  Serializer<DeleteTestProfileVariables> varsSerializer = (DeleteTestProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteTestProfileData, DeleteTestProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteTestProfileData, DeleteTestProfileVariables> ref() {
    DeleteTestProfileVariables vars= DeleteTestProfileVariables(id: id,);
    return _dataConnect.mutation("DeleteTestProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteTestProfileTestProfileDelete {
  final String id;
  DeleteTestProfileTestProfileDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteTestProfileTestProfileDelete otherTyped = other as DeleteTestProfileTestProfileDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteTestProfileTestProfileDelete({
    required this.id,
  });
}

@immutable
class DeleteTestProfileData {
  final DeleteTestProfileTestProfileDelete? testProfile_delete;
  DeleteTestProfileData.fromJson(dynamic json):
  
  testProfile_delete = json['testProfile_delete'] == null ? null : DeleteTestProfileTestProfileDelete.fromJson(json['testProfile_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteTestProfileData otherTyped = other as DeleteTestProfileData;
    return testProfile_delete == otherTyped.testProfile_delete;
    
  }
  @override
  int get hashCode => testProfile_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (testProfile_delete != null) {
      json['testProfile_delete'] = testProfile_delete!.toJson();
    }
    return json;
  }

  DeleteTestProfileData({
    this.testProfile_delete,
  });
}

@immutable
class DeleteTestProfileVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteTestProfileVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteTestProfileVariables otherTyped = other as DeleteTestProfileVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteTestProfileVariables({
    required this.id,
  });
}

