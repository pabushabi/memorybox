import 'package:flutter/material.dart';
import 'package:recorder/Controllers/GeneralController.dart';
import 'package:recorder/models/ProfileModel.dart';
import 'package:recorder/Style.dart';
import 'package:provider/provider.dart';
import 'package:recorder/generated/l10n.dart';

class ProfileName extends StatefulWidget {
  final bool isEdit;
  final ProfileModel person;

  ProfileName({@required this.isEdit, @required this.person});
  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return widget.isEdit
        ? nameIsEdit(context)
        : Text(
            '${widget.person.name ?? S.current.anonymous}',
            style: nameTextStyle,
          );
  }

  Widget nameIsEdit(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromRGBO(58, 58, 85, 0.5)))),
      child: TextField(
        controller: context.read<GeneralController>().profileController.controllerName,
        textAlign: TextAlign.center,
        cursorColor: Color.fromRGBO(64, 64, 64, 1),
        style: nameTextStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.person.name ?? S.current.fake_name,
          hintStyle: TextStyle(color: cBlack.withOpacity(.4)),
          // hintStyle: nameTextStyle,
        ),
      ),
    );
  }
}
