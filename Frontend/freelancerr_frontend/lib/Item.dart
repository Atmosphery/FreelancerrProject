class SearchItem {
  final int ItemId;

  const SearchItem ({
    required this.ItemId,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      ItemId: json['ItemId'],
    );
  }
}
