class Revenu {
  double montant;
  String source;
  String frequence;

  Revenu(
      {required this.frequence, required this.montant, required this.source});
}

List<Revenu> revenuData = [
  Revenu(frequence: "mois", montant: 300, source: "Salaire"),
  Revenu(frequence: "mois", montant: 180, source: "Champ"),
  Revenu(frequence: "mois", montant: 600, source: "Boutique"),
  Revenu(frequence: "mois", montant: 80, source: "Moto"),
];
