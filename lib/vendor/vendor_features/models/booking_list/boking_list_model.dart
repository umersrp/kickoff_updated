class BookingListItemModel {
  // final String bookingIdName;
  final String bookingIdNumber;

  // final String venueName;
  final String venueTitle;

  // final String dateName;
  final String date;

  // final String Status;
  final String StatusTitle;

  // final String createName;
  final String createAt;

  BookingListItemModel({
    required this.bookingIdNumber,
    required this.venueTitle,
    required this.date,
    required this.StatusTitle,
    required this.createAt,
  });
}
