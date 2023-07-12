

class CheckoutBook {
  final int appUserID;
  final int bookEditionId;

  CheckoutBook({required this.appUserID, required this.bookEditionId});

  Map<String, dynamic> toJson() {
    return {
      'appUserID': appUserID,
      'bookEditionID': bookEditionId,
    };
  }
}
