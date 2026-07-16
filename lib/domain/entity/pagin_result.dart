class PaginResult<T> {
  final List<T> items;
  final int currentPage;
  final bool hasnextPage;

  PaginResult({
    required this.currentPage,
    required this.hasnextPage,
    required this.items
  });
}