class GQLStrings {
  static String getBSPServicesGQLQuery() {
    return (r''' mutation ($serviceMeta: CountryServiceGroupType!) {
          servicesByCountry(input: $serviceMeta) 
      }''');
  }
}
