part of 'generated.dart';

class ListUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListUsersVariablesBuilder(this._dataConnect, );
  Deserializer<ListUsersData> dataDeserializer = (dynamic json)  => ListUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListUsersData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListUsersData, void> ref() {
    
    return _dataConnect.query("ListUsers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListUsersUsers {
  final String? displayName;
  final String email;
  ListUsersUsers.fromJson(dynamic json):
  
  displayName = json['displayName'] == null ? null : nativeFromJson<String>(json['displayName']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListUsersUsers otherTyped = other as ListUsersUsers;
    return displayName == otherTyped.displayName && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([displayName.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (displayName != null) {
      json['displayName'] = nativeToJson<String?>(displayName);
    }
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  ListUsersUsers({
    this.displayName,
    required this.email,
  });
}

@immutable
class ListUsersData {
  final List<ListUsersUsers> users;
  ListUsersData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => ListUsersUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListUsersData otherTyped = other as ListUsersData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  ListUsersData({
    required this.users,
  });
}

