List<dynamic> ensureList(dynamic value) {
  if (value == null) return [];
  return (value is Map) ? [value] : value;
}