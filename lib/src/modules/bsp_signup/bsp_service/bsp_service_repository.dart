import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/index.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class BspServiceRepository {
  BspServiceRepository();

  Future<BspServices> getBspServices(
      int countryId, bool isHome, bool isOnDemand, bool isWalkIn) async {
    Map<String, dynamic> serviceRequestMap = {
      "serviceMeta": {
        'countryId': countryId,
        'onDemand': isHome,
        'walkIn': isWalkIn,
      }
    };

    final QueryResult result = await GraphQLHelper.gqlQuery(
        GQLStrings.getBSPServicesGQLQuery(), serviceRequestMap);
    print('result.data.servicesByCountry');
    print(result.data);
    BspServices bspServices = BspServices.fromJson(result.data);
    return bspServices;
  }
}
