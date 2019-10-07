import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:testing/common/app_constants.dart';

class GraphQLHelper {
  GraphQLHelper();

  static HttpLink httpLink = HttpLink(
    uri: AppConstants.gqlAwsUrl,
  );

  static Link link = httpLink;
  static GraphQLClient client =
      GraphQLClient(cache: InMemoryCache(), link: link);

  static Future<QueryResult> gqlQuery(
      String document, Map<String, dynamic> variables) async {
    final QueryResult result = await client.query(
      QueryOptions(document: document, variables: variables),
    );
    return result;
  }

  static Future<QueryResult> gqlMutation(
      String document, Map<String, dynamic> variables) async {
    final QueryResult result = await client.mutate(
      MutationOptions(document: document, variables: variables),
    );
    return result;
  }
}
