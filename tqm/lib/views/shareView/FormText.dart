import 'package:flutter/material.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

class FormText {
  static Widget textFormWithNode(
      {BuildContext context,
      FocusNode focusNode,
      String initialValue,
      String hintText,
      Icon icon,
      String validator(String val, String filde),
      onSaved(String value),
      onFieldSubmitted(String value),
      validText,
      Widget suffixIcon,
      keyboardType = TextInputType.text,
      autofocse = false,
      textInputAction = TextInputAction.none,
      prefixText = ""}) {
    return new TextFormField(
      // controller: nameTextEditingController,

      focusNode: focusNode,
      style: Theme.of(context).textTheme.bodyText1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      initialValue: initialValue,
      autofillHints: [AutofillHints.organizationName],
      maxLines: 1,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
          filled: false,
          hintText: hintText,
          labelText: hintText,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: customGreyColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: customGreyColor)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon != null ? suffixIcon : Container(),
              //Text(prefixText,style: TextStyle(fontSize: 12)),
            ],
          ),
          prefixIcon: icon,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.grey)),
      validator: (
        value,
      ) {
        return validator(value, validText);
      },
      onSaved: (String value) {
        onSaved(value);
        // widget.data.name = value;
      },
      onFieldSubmitted: (term) {
        onFieldSubmitted(term);
      },
    );
  }

  static Widget textFormF(
      BuildContext context,
      //FocusNode focusNode,
      String initialValue,
      String hintText,
      Icon icon,
      String validator(String val, String filde),
      onSaved(String value),
      validText,
      Widget suffixIcon,
      [keyboardType = TextInputType.text,
      autofocse = false,
      textInputAction = TextInputAction.none,
      prefixText = ""]) {
    return new TextFormField(
      // controller: nameTextEditingController,

      //focusNode: focusNode,
      style: Theme.of(context).textTheme.bodyText1,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      initialValue: initialValue,
      autofillHints: [AutofillHints.organizationName],
      maxLines: 1,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
          filled: false,
          hintText: hintText,
          labelText: hintText,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: customGreyColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: customGreyColor)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon != null ? suffixIcon : Container(),
              //Text(prefixText,style: TextStyle(fontSize: 12)),
            ],
          ),
          prefixIcon: icon,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.grey)),
      validator: (
        value,
      ) {
        return validator(value, validText);
      },
      onSaved: (String value) {
        onSaved(value);
      },
    );
  }

  static Widget textFormIconLess(
      context,
      String initialValue,
      String hintText,
      String validator(String val, String filde),
      onSaved(String value),
      validText,
      [keyboardType = TextInputType.text,
      prefixText = ""]) {
    return new TextFormField(
        style: Theme.of(context).textTheme.bodyText1,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        initialValue: initialValue,
        autofillHints: [AutofillHints.organizationName],
        maxLines: 1,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        enableInteractiveSelection: true,
        decoration: InputDecoration(
            labelText: hintText,
            filled: false,
            hintText: hintText,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: customGreyColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: customGreyColor)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.grey)),
        validator: (
          value,
        ) {
          return validator(value, validText);
        },
        onSaved: (String value) {
          onSaved(value);
          // widget.data.name = value;
        });
  }
}

class FormValidator {
  // Form Error
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final String emailNullError = "Please Enter your email";

  final String invalidEmailError = "Please Enter Valid Email";
  final String passNullError = "Please Enter your password";
  final String shortPassError = "Password is too short";
  final String matchPassError = "Passwords don't match";

  static FormValidator _instance;

  factory FormValidator() => _instance ??= new FormValidator._();

  FormValidator._();

  String validateisEmpty(String value, String field) {
    /* String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    */
    if (value.isEmpty) {
      return 'الرجاء ادخال  $field  ';
    }
    /*else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }*/
    else {
      return null;
    }
  }

  String validateisEmail(String value, String filed) {
    String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    /* if (value.isEmpty) {
      return 'الرجاء ادخال الايميل  ';
    } else */
    if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validateisNull(String value, String filed) {
    return null;
  }

  String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return " الحقل مطلوب ";
    }
    /*else if (value.length < 8) {
      return "Password must minimum eight characters";
    }
     else if (!regExp.hasMatch(value)) {
      return "Password at least one uppercase letter, one lowercase letter and one number";
    }*/
    return null;
  }

  String validateNumberNonZero(String value, String filed) {
    if (value.isEmpty) {
      return "الرجال إدخال $filed";
    }
    /*String pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'الرقم المدخل غير صحيح';
    }*/
    if (double.parse(value) <= 0) {
      return 'الرقم المدخل غير صالح';
    }
    return null;
  }

///////////
}
///////
////
////////////////////
///////////////
///////////////////
/////////////////
///////////////////////////////
///
///////////////////////////
///

///////////////////////
///////////////////
/////////////////////
///
///
///
///
///
///
///
