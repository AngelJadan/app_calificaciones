// ignore_for_file: non_constant_identifier_names

class UrlAddress {
  //static String _url = "http://:8000";
  static String _url = "http://ip:8000";

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
  static String listArea = "$_url/curso/list-area/";
  static String materia = "$_url/curso/materia-api/";
  static String materiaList = "$_url/curso/list-materias/";
  static String list_paralelos = "$_url/curso/list-paralelos/";
  static String curso = "$_url/curso/curso-api/";
  static String funcionario = "$_url/persona/funcionario-api/";
  static String estudiante = "$_url/persona/estudiante-api/";
  static String list_estudiante = "$_url/persona/list_estudiante/";
  static String list_funcionario = "$_url/persona/list_funcionario/";
  static String list_all_cursos = "$_url/curso/list-curso-all/";

  static String periodo = "$_url/curso/periodo-api/";
  static String all_periodo = "$_url/curso/list-periodo-all/";
  static String last_periodo = "$_url/curso/las-periodos/";

  static String materia_curso_docente_periodo =
      "$_url/curso/materia-curso-docente-periodo/";
  static String list_materia_curso_docente_periodo =
      "$_url/curso/list-materia-curso-docente-periodo/";
}
