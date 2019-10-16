import 'package:graphql/client.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class LanguageRepository {
  LanguageRepository();

  Future<dynamic> getLanguages() async {
    try {
      final QueryResult result =
          await GraphQLHelper.gqlMutation(GQLStrings.getLanguages(), {});
      print(result.data);
      // result.data['data']
      // Handle the error
      if (result.data != null) {
        // dynamic langs = Languages.fromJson(result.data);
        // dynamic userRes = result.data['loginUser'];
        print('langs from the repo');
        // print(langs);
        return result.data;
      }
    } catch (e) {}
  }
}
