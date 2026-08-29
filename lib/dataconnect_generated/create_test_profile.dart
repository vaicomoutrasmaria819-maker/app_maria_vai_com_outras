part of 'generated.dart';

class CreateTestProfileVariablesBuilder {
  String environment;
  String status;

  final FirebaseDataConnect _dataConnect;
  CreateTestProfileVariablesBuilder(this._dataConnect, {required  this.environment,required  this.status,});
  Deserializer<CreateTestProfileData> dataDeserializer = (dynamic json)  => CreateTestProfileData.fromJson(jsonDecode(json));
  Serializer<CreateTestProfileVariables> varsSerializer = (CreateTestProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateTestProfileData, CreateTestProfileVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateTestProfileData, CreateTestProfileVariables> ref() {
    CreateTestProfileVariables vars= CreateTestProfileVariables(environment: environment,status: status,);
    return _dataConnect.mutation("CreateTestProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateTestProfileTestProfileInsert {
  final String id;
  CreateTestProfileTestProfileInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTestProfileTestProfileInsert otherTyped = other as CreateTestProfileTestProfileInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateTestProfileTestProfileInsert({
    required this.id,
  });
}

@immutable
class CreateTestProfileData {
  final CreateTestProfileTestProfileInsert testProfile_insert;
  CreateTestProfileData.fromJson(dynamic json):
  
  testProfile_insert = CreateTestProfileTestProfileInsert.fromJson(json['testProfile_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTestProfileData otherTyped = other as CreateTestProfileData;
    return testProfile_insert == otherTyped.testProfile_insert;
    
  }
  @override
  int get hashCode => testProfile_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['testProfile_insert'] = testProfile_insert.toJson();
    return json;
  }

  CreateTestProfileData({
    required this.testProfile_insert,
  });
}

@immutable
class CreateTestProfileVariables {
  final String environment;
  final String status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateTestProfileVariables.fromJson(Map<String, dynamic> json):
  
  environment = nativeFromJson<String>(json['environment']),
  status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateTestProfileVariables otherTyped = other as CreateTestProfileVariables;
    return environment == otherTyped.environment && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([environment.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['environment'] = nativeToJson<String>(environment);
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  CreateTestProfileVariables({
    required this.environment,
    required this.status,
  });
}

