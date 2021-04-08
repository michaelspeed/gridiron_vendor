import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String uuidFromObject(Object object) {
  if (object is Map<String, Object>) {
    final String typeName = object['__typename'];
    final String id = object['id'].toString();
    if (typeName != null && id != null) {
      return <String>[typeName, id].join('/');
    }
  }
  return null;
}

ValueNotifier<GraphQLClient> clientFor({
  @required String uri,
  String subscriptionUri,
  String token
}) {
  AuthLink _authLink;
  Link link;
  print(token);
  if (token != null) {
    _authLink = AuthLink(getToken: () => "Bearer $token");
    Link mainLink = HttpLink(uri);
    link = _authLink.concat(mainLink);
  } else {
    link = HttpLink(uri);
  }

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    ),
  );
}

/// Wraps the root application with the `graphql_flutter` client.
/// We use the cache for all state management.
class ClientProvider extends StatelessWidget {
  ClientProvider({
    @required this.child,
    @required String uri,
    String token
  }) : client = clientFor(
    uri: uri,
    token: token
  );

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}