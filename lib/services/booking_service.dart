import '../models/booking.dart';

class BookingService {
  static List<Booking> bookings = [];

  static void addBooking(Booking b) {
    bookings.add(b);
  }
}