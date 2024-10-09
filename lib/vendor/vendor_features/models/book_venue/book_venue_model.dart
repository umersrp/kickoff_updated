// To parse this JSON data, do
//
//     final bookVenueModel = bookVenueModelFromJson(jsonString);

import 'dart:convert'; 

import 'booking_venues.dart';

BookVenueModel bookVenueModelFromJson(String str) =>
    BookVenueModel.fromJson(json.decode(str));

String bookVenueModelToJson(BookVenueModel data) => json.encode(data.toJson());

class BookVenueModel {
  List<Booking> bookings;
  Pagination pagination;

  BookVenueModel({
    required this.bookings,
    required this.pagination,
  });

  factory BookVenueModel.fromJson(Map<String, dynamic> json) => BookVenueModel(
        bookings: List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
} 


class Pagination {
  int page; // Renamed from currentPage
  int limit; // Renamed from pageSize
  int total; // Renamed from totalVenues
  bool hasNextPage; // Added for API consistency

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.hasNextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"], // Renamed
        limit: json["limit"], // Renamed
        total: json["total"], // Renamed
        hasNextPage: json["hasNextPage"], // Added for API consistency
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "hasNextPage": hasNextPage, // Added for API consistency
      };
}
