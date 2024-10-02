class Pagination {
  int totalVenues;
  int totalPages;
  int currentPage;
  int pageSize;

  Pagination({
    required this.totalVenues,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalVenues: json["totalVenues"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "totalVenues": totalVenues,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
      };
}
