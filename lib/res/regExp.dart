class RegEx{
  static const emailRegExp=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const passRegExp=r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const userNameRegexp=r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$';
  static const FullNameRegExp="[a-zA-Z]+\\.?";
  
}