part of 'generated.dart';

class GetServiceUserVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetServiceUserVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetServiceUserData> dataDeserializer = (dynamic json)  => GetServiceUserData.fromJson(jsonDecode(json));
  Serializer<GetServiceUserVariables> varsSerializer = (GetServiceUserVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetServiceUserData, GetServiceUserVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetServiceUserData, GetServiceUserVariables> ref() {
    GetServiceUserVariables vars= GetServiceUserVariables(id: id,);
    return _dataConnect.query("GetServiceUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetServiceUserServiceUser {
  final String serviceName;
  final String? scope;
  GetServiceUserServiceUser.fromJson(dynamic json):
  
  serviceName = nativeFromJson<String>(json['serviceName']),
  scope = json['scope'] == null ? null : nativeFromJson<String>(json['scope']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetServiceUserServiceUser otherTyped = other as GetServiceUserServiceUser;
    return serviceName == otherTyped.serviceName && 
    scope == otherTyped.scope;
    
  }
  @override
  int get hashCode => Object.hashAll([serviceName.hashCode, scope.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['serviceName'] = nativeToJson<String>(serviceName);
    if (scope != null) {
      json['scope'] = nativeToJson<String?>(scope);
    }
    return json;
  }

  GetServiceUserServiceUser({
    required this.serviceName,
    this.scope,
  });
}

@immutable
class GetServiceUserData {
  final GetServiceUserServiceUser? serviceUser;
  GetServiceUserData.fromJson(dynamic json):
  
  serviceUser = json['serviceUser'] == null ? null : GetServiceUserServiceUser.fromJson(json['serviceUser']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetServiceUserData otherTyped = other as GetServiceUserData;
    return serviceUser == otherTyped.serviceUser;
    
  }
  @override
  int get hashCode => serviceUser.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (serviceUser != null) {
      json['serviceUser'] = serviceUser!.toJson();
    }
    return json;
  }

  GetServiceUserData({
    this.serviceUser,
  });
}

@immutable
class GetServiceUserVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetServiceUserVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetServiceUserVariables otherTyped = other as GetServiceUserVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetServiceUserVariables({
    required this.id,
  });
}

