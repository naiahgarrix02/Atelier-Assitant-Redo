class Country {
  final String name;
  final String flag;
  final String dialCode;

  const Country({
    required this.name,
    required this.flag,
    required this.dialCode,
  });
}

const List<Country> countries = [
  Country(name: 'Ghana', flag: 'GH', dialCode: '+233'),
  Country(name: 'Nigeria', flag: 'NG', dialCode: '+234'),
  Country(name: 'Togo', flag: 'TG', dialCode: '+228'),
  Country(name: 'Ivory Coast', flag: 'IV', dialCode: '+225'),
  Country(name: 'United Kingdom', flag: 'UK', dialCode: '+44'),
  Country(name: 'United States', flag: 'US', dialCode: '+1'),
];
