class GQLStrings {
  static String getBSPServicesGQLQuery() {
    return (r''' mutation ($serviceMeta: CountryServiceGroupType!) {
          servicesByCountry(input: $serviceMeta) 
      }''');
  }

  static String getBusinessTypes() {
    return (r''' query {
                businessTypes{
                  id,
                  name
                }
            }''');
  }

  static String getTermsandCondition() {
    return (r''' query {
  platformTermsAndConditions {
    country {
      capital,
      id
    },
    endDate,
    id,
    startDate,
    text,
    type,
    url
  }
}''');
  }

  static String loginUser() {
    return (r'''mutation($user:SessionInputType!) {
              loginUser(input:$user) {
                token,
                user {
                  confirmationSentAt,
                  confirmationToken,
                  confirmedAt,
                  currentSignInAt,
                  email,
                  failedAttempts,
                  id,
                  isBsp,
                  isVerified,
                  country {
                    name,
                    id,
                    code,
                    isdCode,
                    currencyCode,
                    currencySymbol,
                    capital,
                    contactInfo,
                    officialName,
                  },
                  language{
                    id,
                    code,
                    isActive,
                    name
                  },
                  lockedAt,
                  meta,
                  mobile,
                  platformTermsAndConditionId,
                  profile,
                  resetPasswordSentAt,
                  resetPasswordToken,
                  scopes,
                  signInCount,
                  statusId,
                  token,
                  unlockToken
                }
              }
            }''');
  }

  static String signupUser() {
    return (r'''mutation($user: UserInputType!) {
          createUser(input:$user){
            confirmationSentAt,
            confirmationToken,
            confirmedAt,
            currentSignInAt,
            email,
            failedAttempts,
            id,
            isBsp,
            isVerified,
            country {
              name,
              id,
              code,
              isdCode,
              currencyCode,
              currencySymbol,
              capital,
              contactInfo,
              officialName,
            },
            language{
                    id,
                    code,
                    isActive,
                    name
                  },
            lockedAt,
            meta,
            mobile,
            platformTermsAndConditionId,
            profile,
            resetPasswordSentAt,
            resetPasswordToken,
            scopes,
            signInCount,
            statusId,
            token,
            unlockToken
            }
          }''');
  }

  static String getCountries() {
    return (r''' query countries {
                  countries{
                    name,
                    id,
                    code,
                    isdCode,
                    currencyCode,
                    currencySymbol,
                    capital,
                    contactInfo,
                    officialName,
                }
            }
    ''');
  }

  static String validateUser() {
    return (r'''mutation ($user:RegisterConfirmationInputType!){
              registerConfirmation(input:$user) { 
                          confirmationSentAt,
                          confirmationToken,
                          confirmedAt,
                          currentSignInAt,
                          email,
                          failedAttempts,
                          id,
                          isBsp,
                          isVerified,
                          country {
                              name,
                              id,
                              code,
                              isdCode,
                              currencyCode,
                              currencySymbol,
                              capital,
                              contactInfo,
                              officialName,
                          },
                          language{
                            id,
                            code,
                            isActive,
                            name
                          },
                          lockedAt,
                          meta,
                          mobile,
                          platformTermsAndConditionId,
                          profile,
                          resetPasswordSentAt,
                          resetPasswordToken,
                          scopes,
                          signInCount,
                          statusId,
                          token,
                          unlockToken
              }
            } 
        ''');
  }

  static String getLanguages() {
    return (r'''query {
              languages {
                id,
                code,
                isActive,
                name
              }
            }''');
  }

  static String resendToken() {
    return (r'''mutation($token: SessionSendInputType!) {
            sendToken(input:$token) {
               confirmationSentAt,
                          confirmationToken,
                          confirmedAt,
                          currentSignInAt,
                          email,
                          failedAttempts,
                          id,
                          isBsp,
                          isVerified,
                          country {
                              name,
                              id,
                              code,
                              isdCode,
                              currencyCode,
                              currencySymbol,
                              capital,
                              contactInfo,
                              officialName,
                          },
                          language{
                            id,
                            code,
                            isActive,
                            name
                          },
                          lockedAt,
                          meta,
                          mobile,
                          platformTermsAndConditionId,
                          profile,
                          resetPasswordSentAt,
                          resetPasswordToken,
                          scopes,
                          signInCount,
                          statusId,
                          token,
                          unlockToken
            }
          }''');
  }

  static String createBusiness() {
    return (r'''mutation($bspUser: BusinessInputType!) {
            createBusiness(input: $bspUser) {
              agreeToPayForVerification,
                    businessType {
                        id,
                        name
                    },
                    employeesCount,
                    id,
                    isActive,
                    isVerified,
                    name,
                    phone,
                    profilePictures,
                    rating,
                    ratingCount,
                    settings,
                    termsAndConditions,
                    user {
                            confirmationSentAt,
                            confirmationToken,
                            confirmedAt,
                            currentSignInAt,
                            email,
                            failedAttempts,
                            id,
                            isBsp,
                            isVerified,
                            country {
                             name,
                              id,
                              code,
                              isdCode,
                              currencyCode,
                              currencySymbol,
                              capital,
                              contactInfo,
                              officialName,
                            },
                            language{
                              id,
                              code,
                              isActive,
                              name
                            },
                            lockedAt,
                            meta,
                            mobile,
                            platformTermsAndConditionId,
                            profile,
                            resetPasswordSentAt,
                            resetPasswordToken,
                            scopes,
                            signInCount,
                            statusId,
                            token,
                            unlockToken
                  },
              }
          }''');
  }

  static String licenceIssuingAuthority() {
    return (r'''
      query ($countryId: Int!) {
              licenceIssuingAuthorities(countryId: $countryId) {
                id,
                name,
                isActive,
                country {
                  id,
                  name,
                  code,
                  isdCode
                }
              }
            }
    ''');
  }
}
