const String uri = "http://172.0.0.1:8000/api/";

class UserUrl {
  String loginUrl() => "login";
  String registerUrl() => "register";
  String logoutUrl() => "logout";
  String refreshUrl() => "refresh";
  String currentUrl() => "current";
}

class EmployeUrl {
  String getUrl() => "employe/all";
  String addUrl() => "employe/store";
  String getOneUrl(id) => "employe/show/{$id}";
  String updateUrl(id) => "employe/update/{$id}";
  String deleteUrl(id) => "employe/delete/{$id}";
  String searchUrl() => "employe/search";
}
