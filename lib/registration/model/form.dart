class FeedbackForm {
  var _name,
      _age,
      _gender,
      _mobileno,
      _bloodgroup,
      _donateblood,
      _city,
      _state,
      _email,
      _password;

  FeedbackForm(
    this._name,
    this._age,
    this._gender,
    this._mobileno,
    this._bloodgroup,
    this._donateblood,
    this._city,
    this._state,
    this._email,
    this._password,
  );

  String toParams() =>
      "?name=$_name&age=$_age&gender=$_gender&mobileno=$_mobileno&bloodgroup=$_bloodgroup&donateblood=$_donateblood&city=$_city&state=$_state&email=$_email&password=$_password";
}
