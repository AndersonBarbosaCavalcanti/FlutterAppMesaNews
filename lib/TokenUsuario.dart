
import 'package:shared_preferences/shared_preferences.dart';

class TokenUsuario {

  static final TokenUsuario _instancia = new TokenUsuario._internal();

  factory TokenUsuario() {
    return _instancia;
  }

  TokenUsuario._internal();

  SharedPreferences _prefs;

  initTokenUsuario() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get myTOKEN {
    return _prefs.getString('myTOKEN') ?? 1;
  }

  set myTOKEN( value ) {
    _prefs.setString('myTOKEN', value);
  }

  get myFavoritos {
    return _prefs.getString('myFavoritos') ?? 1;
  }

  set myFavoritos( value ) {
    _prefs.setString('myFavoritos', value);
  }
}


