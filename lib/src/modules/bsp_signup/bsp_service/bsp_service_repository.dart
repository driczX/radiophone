import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_model.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tudo/src/utils/gql_strings.dart';
import 'package:tudo/src/utils/graphql_helper.dart';

class BspServiceRepository {
  BspServiceRepository();

  Future<BspServices> getBspServices() async {
    Map<String, dynamic> serviceRequestMap = {
      "serviceMeta": {
        'countryId': 1,
        'onDemand': true,
        'walkIn': true,
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
