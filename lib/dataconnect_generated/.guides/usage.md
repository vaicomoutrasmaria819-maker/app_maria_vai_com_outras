# Basic Usage

```dart
ExampleConnector.instance.CreateUser(createUserVariables).execute();
ExampleConnector.instance.UpdateMyProfile(updateMyProfileVariables).execute();
ExampleConnector.instance.DeleteUser().execute();
ExampleConnector.instance.GetMyUser().execute();
ExampleConnector.instance.ListUsers().execute();
ExampleConnector.instance.CreateRole(createRoleVariables).execute();
ExampleConnector.instance.UpdateRole(updateRoleVariables).execute();
ExampleConnector.instance.DeleteRole(deleteRoleVariables).execute();
ExampleConnector.instance.GetRole(getRoleVariables).execute();
ExampleConnector.instance.ListRoles().execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ExampleConnector.instance.UpdateMyProfile({ ... })
.displayName(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

