part of 'generated.dart';

class GetTestProfileVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetTestProfileVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetTestProfileData> dataDeserializer = (dynamic json)  => GetTestProfileData.fromJson(jsonDecode(json));
  Serializer<GetTestProfileVariables> varsSerializer = (GetTestProfileVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetTestProfileData, GetTestProfileVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetTestProfileData, GetTestProfileVariables> ref() {
    GetTestProfileVariables vars= GetTestProfileVariables(id: id,);
    return _dataConnect.query("GetTestProfile", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetTestProfileTestProfile {
  final String environment;
  final String status;
  GetTestProfileTestProfile.fromJson(dynamic json):
  
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

    final GetTestProfileTestProfile otherTyped = other as GetTestProfileTestProfile;
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

  GetTestProfileTestProfile({
    required this.environment,
    required this.status,
  });
}

@immutable
class GetTestProfileData {
  final GetTestProfileTestProfile? testProfile;
  GetTestProfileData.fromJson(dynamic json):
  
  testProfile = json['testProfile'] == null ? null : GetTestProfileTestProfile.fromJson(json['testProfile']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetTestProfileData otherTyped = other as GetTestProfileData;
    return testProfile == otherTyped.testProfile;
    
  }
  @override
  int get hashCode => testProfile.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (testProfile != null) {
      json['testProfile'] = testProfile!.toJson();
    }
    return json;
  }

  GetTestProfileData({
    this.testProfile,
  });
}

@immutable
class GetTestProfileVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetTestProfileVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetTestProfileVariables otherTyped = other as GetTestProfileVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetTestProfileVariables({
    required this.id,
  });
}

