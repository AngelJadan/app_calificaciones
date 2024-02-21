// ignore_for_file: non_constant_identifier_names

class UrlAddress {
  //static String _url = "http://192.168.100.68:8000";
  static String _url = "http://192.168.10.241:8000";

  UrlAddress();

  static const headers = {'Content-Type': 'application/json;'};

  static Map<String, String> getHeadersWithToken(String token, String cookie) {
    return cookie != null && cookie != ""
        ? {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Token $token',
            'Cookie': cookie
          }
        : {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Token $token'
          };
  }

  static String login = "$_url/obtener_token/";

  //cursos
  // ignore: non_constant_identifier_names
  static String list_paralelos = "$_url/curso/list-paralelos/";
  static String curso = "$_url/curso/curso-api/";
  static String funcionario = "$_url/persona/funcionario-api/";
  static String list_funcionario = "$_url/persona/list_funcionario/";
  static String list_all_cursos = "$_url/curso/list-curso-all/";
}
