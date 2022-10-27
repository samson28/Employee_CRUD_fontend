class Employe {
  final String nom;
  final String prenom;
  final String sex;
  final DateTime dateDeNaissance;
  final String tel;
  final String mail;
  final DateTime dateDePriseDeFonction;
  final String fonction;

  Employe(
      {required this.nom,
      required this.prenom,
      required this.sex,
      required this.dateDeNaissance,
      required this.tel,
      required this.mail,
      required this.dateDePriseDeFonction,
      required this.fonction});

  Employe.fromJson(Map<String, dynamic> json)
      : this(
          nom: json['nam'].toString(),
          prenom: json['prenom'].toString(),
          sex: json['sex'].toString(),
          dateDeNaissance: DateTime.parse(json['dateDeNaissance'].toString()),
          tel: json['tel'].toString(),
          mail: json['mail'].toString(),
          dateDePriseDeFonction:
              DateTime.parse(json['dateDePriseDeFonction'].toString()),
          fonction: json['fonction'].toString(),
        );

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'sex': sex,
      'date_de_naissance': dateDeNaissance,
      'tel': tel,
      'mail': mail,
      'date_de_prise_de_fonction': dateDePriseDeFonction,
      'fonction': fonction,
    };
  }
}
