part of 'generated.dart';

class ListMyServiceUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMyServiceUsersVariablesBuilder(this._dataConnect, );
  Deserializer<ListMyServiceUsersData> dataDeserializer = (dynamic json)  => ListMyServiceUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMyServiceUsersData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMyServiceUsersData, void> ref() {
    
    return _dataConnect.query("ListMyServiceUsers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMyServiceUsersServiceUsers {
  final String serviceName;
  ListMyServiceUsersServiceUsers.fromJson(dynamic json):
  
  serviceName = nativeFromJson<String>(json['serviceName']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyServiceUsersServiceUsers otherTyped = other as ListMyServiceUsersServiceUsers;
    return serviceName == otherTyped.serviceName;
    
  }
  @override
  int get hashCode => serviceName.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['serviceName'] = nativeToJson<String>(serviceName);
    return json;
  }

  ListMyServiceUsersServiceUsers({
    required this.serviceName,
  });
}

@immutable
class ListMyServiceUsersData {
  final List<ListMyServiceUsersServiceUsers> serviceUsers;
  ListMyServiceUsersData.fromJson(dynamic json):
  
  serviceUsers = (json['serviceUsers'] as List<dynamic>)
        .map((e) => ListMyServiceUsersServiceUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyServiceUsersData otherTyped = other as ListMyServiceUsersData;
    return serviceUsers == otherTyped.serviceUsers;
    
  }
  @override
  int get hashCode => serviceUsers.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['serviceUsers'] = serviceUsers.map((e) => e.toJson()).toList();
    return json;
  }

  ListMyServiceUsersData({
    required this.serviceUsers,
  });
}

