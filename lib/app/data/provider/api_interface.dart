abstract class MESAApiInterface {
  Future<Map> login(String id, String password);
  Future<Map> writeArticle(String id, String password, String subject, String title, String texts, String link, String imgdata);
  Future<Map> getSubjects();
}
