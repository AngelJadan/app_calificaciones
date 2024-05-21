// ignore_for_file: non_constant_identifier_names

class UrlAddress {
  //static String _url = "http://192.168.100.68:8000";
  // ignore: prefer_final_fields
  static String _url = "http://192.168.10.241:8000"; //Oficina

  UrlAddress();

  static const headers = {'Content-Type': 'application/json;'};

  static Map<String, String> getHeadersWithToken(String token, String cookie) {
    // ignore: unnecessary_null_comparison
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
  // ignore: duplicate_ignore
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
  static String list_materia_curso_docente_to_periodo =
      "$_url/curso/list-materia-curso-docente-to-periodo/";

  static String materia_curso_docente_periodo =
      "$_url/curso/materia-curso-docente-periodo/";
  static String list_materia_curso_docente_periodo =
      "$_url/curso/list-materia-curso-docente-periodo/";

  static String materia_estudiante = "$_url/calificacion/materia-estudiante/";
  static String curso_estudiante = "$_url/calificacion/curso-materia/";

  static String trimestre_estudiante = "$_url/calificacion/cabecera-trimestre/";
  static String list_estudiante_trimeste =
      "$_url/calificacion/cabecera-trimestre/";
}
