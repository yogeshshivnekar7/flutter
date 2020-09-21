class MyFlatData {
  static dynamic map() {
    return {
      "app": {"version": "v2", "name": "CHSONE Member"},
      "status_code": 200,
      "data": {
        "unit": {
          "unit_id": 501,
          "unit_flat_number": 1004,
          "building_name": "Demo Building"
        },
        "soc": {"soc_id": 45, "soc_name": "Demo Building"},
        "maintenance": {
          "total_due_amount": 62325,
          "due_date": "30/04/2018",
          "advances": 15
        },
        "last_receipt": {
          "payment_amount": 6210,
          "payment_date": "12/11/2019",
          "receipt_number": "REC101",
          "received_from": "Amit Kumar"
        },
        "last_compalints": {
          "ticket_number": "58585858",
          "created_date": "12/11/2019",
          "status": "open"
        },
        "last_announcement": {
          "subject": "announcement Test",
          "published_on": "12/11/2019"
        },
        "last_notices": {
          "subject": "Notice Test",
          "published_on": "12/11/2019"
        },
        "gallery": {"album_title": "Diwali", "total_album": 5}
      }
    };
  }
}
