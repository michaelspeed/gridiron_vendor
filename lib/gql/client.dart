import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gql_error_link/gql_error_link.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_transform_link/gql_transform_link.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "package:gql_exec/gql_exec.dart";

/*
class HttpAuthLink extends Link {
  Function getToken;
  String graphQLEndpoint;

  String _token;

  Link _link;

  HttpAuthLink({
    this.getToken,
    this.graphQLEndpoint,
  }) {
    _link = Link.from([
      TransformLink(requestTransformer: transformRequest),
      ErrorLink(onException: handleException),
      HttpLink(graphQLEndpoint),
    ]);
  }

  Future<void> updateToken() async {
    _token = await getToken();
  }

  Stream<Response> handleException(
      Request request,
      NextLink forward,
      LinkException exception,
      ) async* {
    if (exception is HttpLinkServerException &&
        exception.response.statusCode == 401) {
      await updateToken();

      yield* forward(request);

      return;
    }

    final message = exception is HttpLinkServerException
        ? exception.response.reasonPhrase
        : exception.toString();

    Zone.current.handleUncaughtError(message, StackTrace.fromString(''));

    throw exception;
  }

  Request transformRequest(Request request) =>
      request.updateContextEntry<HttpLinkHeaders>(
            (headers) => HttpLinkHeaders(
          headers: <String, String>{
            ...headers?.headers ?? <String, String>{},
            "Authorization": _token,
          },
        ),
      );

  @override
  Stream<Response> request(Request request, [forward]) async* {
    if (_token == null) {
      await updateToken();
    }

    yield* _link.request(request, forward);
  }
}

Future<Client> initClient({
  @required Function getToken,
}) async {
  await Hive.initFlutter();

  final box = await Hive.openBox("graphql");

  final store = HiveStore(box);

  final cache = Cache(store: store);

  final link = HttpAuthLink(
    // TODO Change to Development env for logs
    graphQLEndpoint: 'https://megatron.assammart.shop/',
    getToken: () async {
      String token = await getToken();
      if (token == null) {
        return '';
      }
      return 'Bearer $token';
    },
  );

  final client = Client(
    link: link,
    cache: cache,
  );

  return client;
}*/
