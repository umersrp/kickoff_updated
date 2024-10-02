// To parse this JSON data, do
//
//     final bookingListItemModel = bookingListItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:appkickoff/vendor/vendor_features/models/booking_list/venue_model.dart';
import 'package:appkickoff/vendor/vendor_features/models/page/page_model.dart';

BookingListItemModelOrg bookingListItemModelFromJson(String str) =>
    BookingListItemModelOrg.fromJson(json.decode(str));

String bookingListItemModelToJson(BookingListItemModelOrg data) =>
    json.encode(data.toJson());

class BookingListItemModelOrg {
  List<Venue> venues;
  Pagination pagination;

  BookingListItemModelOrg({
    required this.venues,
    required this.pagination,
  });

  factory BookingListItemModelOrg.fromJson(Map<String, dynamic> json) =>
      BookingListItemModelOrg(
        venues: List<Venue>.from(json["venues"].map((x) => Venue.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "venues": List<dynamic>.from(venues.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}



 

