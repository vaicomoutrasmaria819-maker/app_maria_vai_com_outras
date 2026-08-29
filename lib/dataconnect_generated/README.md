# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetMyUser
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getMyUser().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyUserData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMyUser();
GetMyUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getMyUser().ref();
ref.execute();

ref.subscribe(...);
```


### ListUsers
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listUsers();
ListUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetRole
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getRole(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetRoleData, GetRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getRole(
  id: id,
);
GetRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getRole(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListRoles
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listRoles().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListRolesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listRoles();
ListRolesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listRoles().ref();
ref.execute();

ref.subscribe(...);
```


### GetTestProfile
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getTestProfile(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetTestProfileData, GetTestProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getTestProfile(
  id: id,
);
GetTestProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getTestProfile(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMyTestProfiles
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMyTestProfiles().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMyTestProfilesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMyTestProfiles();
ListMyTestProfilesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMyTestProfiles().ref();
ref.execute();

ref.subscribe(...);
```


### GetServiceUser
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getServiceUser(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetServiceUserData, GetServiceUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getServiceUser(
  id: id,
);
GetServiceUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getServiceUser(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMyServiceUsers
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMyServiceUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMyServiceUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMyServiceUsers();
ListMyServiceUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMyServiceUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetAuditLog
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getAuditLog(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetAuditLogData, GetAuditLogVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getAuditLog(
  id: id,
);
GetAuditLogData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getAuditLog(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListAuditLogs
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listAuditLogs().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAuditLogsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listAuditLogs();
ListAuditLogsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listAuditLogs().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateUser
#### Required Arguments
```dart
String email = ...;
ExampleConnector.instance.createUser(
  email: email,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateUser, we created `CreateUserBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateUserVariablesBuilder {
  ...
   CreateUserVariablesBuilder displayName(String? t) {
   _displayName.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.createUser(
  email: email,
)
.displayName(displayName)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createUser(
  email: email,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String email = ...;

final ref = ExampleConnector.instance.createUser(
  email: email,
).ref();
ref.execute();
```


### UpdateMyProfile
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.updateMyProfile().execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateMyProfile, we created `UpdateMyProfileBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateMyProfileVariablesBuilder {
  ...
 
  UpdateMyProfileVariablesBuilder displayName(String? t) {
   _displayName.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateMyProfile()
.displayName(displayName)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateMyProfileData, UpdateMyProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateMyProfile();
UpdateMyProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.updateMyProfile().ref();
ref.execute();
```


### DeleteUser
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.deleteUser().execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteUserData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteUser();
DeleteUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.deleteUser().ref();
ref.execute();
```


### CreateRole
#### Required Arguments
```dart
String roleName = ...;
int permissionLevel = ...;
ExampleConnector.instance.createRole(
  roleName: roleName,
  permissionLevel: permissionLevel,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateRoleData, CreateRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createRole(
  roleName: roleName,
  permissionLevel: permissionLevel,
);
CreateRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String roleName = ...;
int permissionLevel = ...;

final ref = ExampleConnector.instance.createRole(
  roleName: roleName,
  permissionLevel: permissionLevel,
).ref();
ref.execute();
```


### UpdateRole
#### Required Arguments
```dart
String id = ...;
int permissionLevel = ...;
ExampleConnector.instance.updateRole(
  id: id,
  permissionLevel: permissionLevel,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateRoleData, UpdateRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateRole(
  id: id,
  permissionLevel: permissionLevel,
);
UpdateRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
int permissionLevel = ...;

final ref = ExampleConnector.instance.updateRole(
  id: id,
  permissionLevel: permissionLevel,
).ref();
ref.execute();
```


### DeleteRole
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteRole(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteRoleData, DeleteRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteRole(
  id: id,
);
DeleteRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteRole(
  id: id,
).ref();
ref.execute();
```


### CreateTestProfile
#### Required Arguments
```dart
String environment = ...;
String status = ...;
ExampleConnector.instance.createTestProfile(
  environment: environment,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateTestProfileData, CreateTestProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createTestProfile(
  environment: environment,
  status: status,
);
CreateTestProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String environment = ...;
String status = ...;

final ref = ExampleConnector.instance.createTestProfile(
  environment: environment,
  status: status,
).ref();
ref.execute();
```


### UpdateTestProfile
#### Required Arguments
```dart
String id = ...;
String status = ...;
ExampleConnector.instance.updateTestProfile(
  id: id,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateTestProfileData, UpdateTestProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateTestProfile(
  id: id,
  status: status,
);
UpdateTestProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String status = ...;

final ref = ExampleConnector.instance.updateTestProfile(
  id: id,
  status: status,
).ref();
ref.execute();
```


### DeleteTestProfile
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteTestProfile(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteTestProfileData, DeleteTestProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteTestProfile(
  id: id,
);
DeleteTestProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteTestProfile(
  id: id,
).ref();
ref.execute();
```


### CreateServiceUser
#### Required Arguments
```dart
String serviceName = ...;
String apiKeyHash = ...;
ExampleConnector.instance.createServiceUser(
  serviceName: serviceName,
  apiKeyHash: apiKeyHash,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateServiceUserData, CreateServiceUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createServiceUser(
  serviceName: serviceName,
  apiKeyHash: apiKeyHash,
);
CreateServiceUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String serviceName = ...;
String apiKeyHash = ...;

final ref = ExampleConnector.instance.createServiceUser(
  serviceName: serviceName,
  apiKeyHash: apiKeyHash,
).ref();
ref.execute();
```


### UpdateServiceUser
#### Required Arguments
```dart
String id = ...;
String scope = ...;
ExampleConnector.instance.updateServiceUser(
  id: id,
  scope: scope,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateServiceUserData, UpdateServiceUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateServiceUser(
  id: id,
  scope: scope,
);
UpdateServiceUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String scope = ...;

final ref = ExampleConnector.instance.updateServiceUser(
  id: id,
  scope: scope,
).ref();
ref.execute();
```


### DeleteServiceUser
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteServiceUser(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteServiceUserData, DeleteServiceUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteServiceUser(
  id: id,
);
DeleteServiceUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteServiceUser(
  id: id,
).ref();
ref.execute();
```


### LogAction
#### Required Arguments
```dart
String actionType = ...;
ExampleConnector.instance.logAction(
  actionType: actionType,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<LogActionData, LogActionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.logAction(
  actionType: actionType,
);
LogActionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String actionType = ...;

final ref = ExampleConnector.instance.logAction(
  actionType: actionType,
).ref();
ref.execute();
```


### UpdateAuditLog
#### Required Arguments
```dart
String id = ...;
String metadata = ...;
ExampleConnector.instance.updateAuditLog(
  id: id,
  metadata: metadata,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateAuditLogData, UpdateAuditLogVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateAuditLog(
  id: id,
  metadata: metadata,
);
UpdateAuditLogData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String metadata = ...;

final ref = ExampleConnector.instance.updateAuditLog(
  id: id,
  metadata: metadata,
).ref();
ref.execute();
```


### DeleteAuditLog
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteAuditLog(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteAuditLogData, DeleteAuditLogVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteAuditLog(
  id: id,
);
DeleteAuditLogData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteAuditLog(
  id: id,
).ref();
ref.execute();
```

