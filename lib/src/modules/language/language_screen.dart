import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/modules/language/language_repository.dart';

import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/utils/roundrectbutton.dart';
import 'package:tudo/src/widgets/background.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final formKey = new GlobalKey<FormState>();
  bool _validate = false;
  LanguageRepository _langugaesRepository = new LanguageRepository();

  List<String> _type = [];
  List<Map<String, dynamic>> _langsMap = [];
  String type = 'English';
  String languageId = '';

  @override
  void initState() {
    super.initState();
    _langugaesRepository.getLanguages().then((langs) {
      List<String> _langs = [];
      langs['languages'].map((language) {
        _langsMap.add({
          'name': language['name'],
          'id': language['id'],
        });
        print(_langsMap);
        print(language);
        _langs.add(language['name']);
      }).toList();
      setState(() {
        _langsMap = _langsMap;
        _type = _langs;
      });
    });
  }

  Widget _buildLanguage() {
    return FormBuilder(
      child: FormBuilderCustomField(
          attribute: "Identification type",
          validators: [FormBuilderValidators.required()],
          formField: FormField(
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.globe),
                  labelText: 'Select Language',
                  errorText: field.errorText,
                ),
                isEmpty: type == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: type,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        type = newValue;
                        field.didChange(newValue);
                      });
                    },
                    items: _type.map(
                      (String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildLanguagebutton(BuildContext context) {
    return GestureDetector(
      child: RoundrectButton.buildRoundedRectButton(
        AppConstantsValue.appConst['language']['language']['translation'],
        loginBtnGradients,
        false,
      ),
      onTap: () async {
        print('language selection button clicked');
        print('languge selected by user is $type');
        if (formKey.currentState.validate()) {
          List target =
              _langsMap.where((langs) => langs['name'] == type).toList();
          print(target[0]['id']);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('user_lang', type);
          pref.setString('user_lang_id', target[0]['id']);
          NavigationHelper.navigatetologinscreen(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: formKey,
            autovalidate: _validate,
            child: Stack(
              children: <Widget>[
                Background(),
                SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: new Container(
                    margin: EdgeInsets.fromLTRB(30, 300, 30, 10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildLanguage(),
                        SizedBox(
                          height: 30,
                        ),
                        _buildLanguagebutton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<Color> loginBtnGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];
