//set
String? validateEmail(value) {
  Pattern patten =
      r"^[^._!#$%&'*+-/=?](?!.*\.\.)[a-zA-Z0-9\._!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = new RegExp(patten.toString());
  if (value != null) {
    value = value.trim();
  }
  if (value.length == 0)
    return "";
  else if (!regex.hasMatch(value))
    return 'Please enter valid email address';
  else if (value.length == 1) return null;
  return null;
}

//set
String? validateName(String? value) {
  RegExp regExp = new RegExp('[a-zA-Z]');
  if (value != null) {
    value = value.trim();
  }
  if (value!.isEmpty) {
    return null;
  } else if (!regExp.hasMatch(value) ||
      value[0] == '.' ||
      value[value.length - 1] == '.') {
    return "Please enter valid name";
  }
  return null;
}

//set
String? validateDescription(value) {
  String pattern = r"^[a-zA-Z]+(([a-zA-Z])?[a-zA-Z][ ',. -]*)*$";
  RegExp regExp = new RegExp(pattern);
  if (value!.length == 0) {
    return null;
  } else if (!regExp.hasMatch(value)) {
    return "Please enter valid description";
  }
  return null;
}

String? validateLocation(value) {
  String pattern = r'(^[a-zA-Z0-9 ,./-]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return null;
  } else if (!regExp.hasMatch(value)) {
    return "Please enter valid location";
  }
  return null;
}

//set
String? validateAddress(value) {
  String pattern = r"(^[a-zA-Z0-9. ,/-/\s+|[^'-\w]+|[0-9]+/]*$)";
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return null;
  } else if (!regExp.hasMatch(value)) {
    return "Please enter valid address ";
  }
  return null;
}

//set
String? validatePhone(value) {
  String pattern = r'(^\(\d{3}\)\s\d{3}-\d{4})';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return '';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

//set
String? validateEmail1(value) {
  Pattern patten =
      r"^[^._!#$%&'*+-/=?](?!.*\.\.)[a-zA-Z0-9\._!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = new RegExp(patten.toString());
  if (value.length == 0)
    return "Please enter email address";
  else if (!regex.hasMatch(value))
    return 'Please enter valid email address';
  else if (value.length == 1) return null;
  return null;
}

//set
String? validateName1(String? value) {
  String pattern = r"^[a-zA-Z\.]+(([ -][a-zA-Z ])?[a-zA-Z]*)*$";
  RegExp regExp = new RegExp(pattern);
  if (value!.isEmpty) {
    return "Please enter name";
  } else if (!regExp.hasMatch(value) ||
      value[0] == '.' ||
      value[value.length - 1] == '.') {
    return "Please enter valid name";
  }
  return null;
}

//set
String? validateDescription1(value) {
  String pattern = r"^[a-zA-Z]+(([a-zA-Z])?[a-zA-Z][ ',. -]*)*$";
  RegExp regExp = new RegExp(pattern);
  if (value!.length == 0) {
    return "please enter description";
  } else if (!regExp.hasMatch(value)) {
    return "Please enter valid description";
  }
  return null;
}

String? validateLocation1(value) {
  String pattern = r'(^[a-zA-Z0-9 ,./-]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Please enter location";
  } else if (!regExp.hasMatch(value)) {
    return "Please enter valid location";
  }
  return null;
}

//set
String? validateAddress1(value) {
  String pattern = r"(^[a-zA-Z0-9. ,/-/\s+|[^'-\w]+|[0-9]+/]*$)";
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "";
  } else if (!regExp.hasMatch(value)) {
    return "Please enter valid address ";
  }
  return null;
}

//set
String? validatePhone1(value) {
  String pattern = r'(^\(\d{3}\)\s\d{3}-\d{4})';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return 'plese enter mobile number ';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}
