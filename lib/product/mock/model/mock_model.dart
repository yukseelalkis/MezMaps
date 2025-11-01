class Cemetery {
  final String name;
  const Cemetery(this.name);
}

class District {
  final String name;
  final List<Cemetery> cemeteries;
  const District({required this.name, this.cemeteries = const []});
}

class Province {
  final String name;
  final List<District> districts;
  const Province({required this.name, this.districts = const []});
}
