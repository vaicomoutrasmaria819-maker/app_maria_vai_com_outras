part of 'generated.dart';

class ListMyTestProfilesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMyTestProfilesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMyTestProfilesData> dataDeserializer = (dynamic json)  => ListMyTestProfilesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMyTestProfilesData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMyTestProfilesData, void> ref() {
    
    return _dataConnect.query("ListMyTestProfiles", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMyTestProfilesTestProfiles {
  final String environment;
  final String status;
  ListMyTestProfilesTestProfiles.fromJson(dynamic json):
  
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

    final ListMyTestProfilesTestProfiles otherTyped = other as ListMyTestProfilesTestProfiles;
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

  ListMyTestProfilesTestProfiles({
    required this.environment,
    required this.status,
  });
}

@immutable
class ListMyTestProfilesData {
  final List<ListMyTestProfilesTestProfiles> testProfiles;
  ListMyTestProfilesData.fromJson(dynamic json):
  
  testProfiles = (json['testProfiles'] as List<dynamic>)
        .map((e) => ListMyTestProfilesTestProfiles.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyTestProfilesData otherTyped = other as ListMyTestProfilesData;
    return testProfiles == otherTyped.testProfiles;
    
  }
  @override
  int get hashCode => testProfiles.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['testProfiles'] = testProfiles.map((e) => e.toJson()).toList();
    return json;
  }

  ListMyTestProfilesData({
    required this.testProfiles,
  });
}

