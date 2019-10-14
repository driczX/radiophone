import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class BSPSignupRepository {
  BSPSignupRepository();

  Future<dynamic> createMyBusiness(
      Map<String, dynamic> bspUserSignUpMap) async {
    print('bspUserSignUpMap = $bspUserSignUpMap');
    Map<String, dynamic> bspSignupUserMutationVar = {
      "bspUser": bspUserSignUpMap,
    };
    print(bspSignupUserMutationVar);
    final QueryResult result = await GraphQLHelper.gqlMutation(
        GQLStrings.createBusiness(), bspSignupUserMutationVar);
    Map<String, dynamic> bspSignupResponse = {
      'data': result.data,
      'error': result.errors
    };
    return bspSignupResponse;
  }

  Future<dynamic> getBSTypes() async {
    final QueryResult result =
        await GraphQLHelper.gqlQuery(GQLStrings.getBusinessTypes(), {});
    Map<String, dynamic> businessTypes = {
      'data': result.data,
      'error': result.errors
    };
    return businessTypes;
  }

  Future<dynamic> getLicenseAuthority(String countryId) async {
    final QueryResult result = await GraphQLHelper.gqlQuery(
      GQLStrings.licenceIssuingAuthority(),
      {
        "countryId": int.parse(countryId),
      },
    );
    Map<String, dynamic> listOfLicenseIssuingAuthority = {
      'data': result.data,
      'error': result.errors
    };
    return listOfLicenseIssuingAuthority;
  }
}
