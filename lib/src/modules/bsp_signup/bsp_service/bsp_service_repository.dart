import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class BspServiceRepository {
  BspServiceRepository();

  Future<dynamic> getBspServices(
      int countryId, bool isHome, bool isOnDemand, bool isWalkIn) async {
    Map<String, dynamic> serviceRequestMap = {
      "serviceMeta": {
        'countryId': countryId,
        'onDemand': isOnDemand,
        'walkIn': isWalkIn,
      }
    };
    print('serviceRequestMap');
    print(serviceRequestMap);
    final QueryResult result = await GraphQLHelper.gqlQuery(
        GQLStrings.getBSPServicesGQLQuery(), serviceRequestMap);
    print('result.data.servicesByCountry');

    Map<String, dynamic> bspServices = {
      'data': result.data,
      'error': result.errors
    };
    return bspServices;
    // print(result.data);
    // BspServices bspServices = BspServices.fromJson(result.data);
    // return bspServices;
  }
}
