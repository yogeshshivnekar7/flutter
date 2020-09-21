class Request {
  static demo() {
    // print("sssssssssssssssssssssssssssss");
    List allMembers = getData()["data"][0]["member"];
    print("ssssssssssssss");
    var membres = [];
    //print("sssssssssssssssssssssssssssss");
    print(allMembers);
    for (var member in allMembers) {
      var visitor = member["visitors"];
      var primmary = member["member_type"] == "owner" ? true : false;
      var unitCustomDetails = {
        "is_primary": primmary,
        "member_type_id": member["member_type"] == "owner" ? 1 : 2,
        // "user_id": unitStatus["user_id"],
        //[]
        "member_first_name": visitor["first_name"],
        "member_last_name": visitor["last_name"],
        "member_id": member["member_id"],
        "unit_id": member["unit_id"],
        /* "approved": unitStatus["approved"],*/
      };
      membres.add(unitCustomDetails);
      print(membres);
    }
  }

  static getData() {
    return {
      "app": {
        "version": "v1",
        "name": "CHSONE Vizlog",
        "time": "2019-12-23 15:06:41"
      },
      "status_code": 200,
      "data": [
        {
          "building_unit_id": 2,
          "fk_building_id": 1,
          "unit_id": 1094,
          "company_id": 1094,
          "floor_no": "0",
          "unit_number": "1002",
          "parking_alloted_unit": null,
          "intercomm_no": null,
          "vendor_reference_id": null,
          "unit_type": "flat",
          "is_occupied": 1,
          "occupied_by": null,
          "occupancy_type": "owner",
          "parking_type": null,
          "allow_guest_parking": 0,
          "status": 1,
          "created_by": 10,
          "created_at": "2019-07-16 12:11:53",
          "updated_by": null,
          "updated_at": null,
          "member": [
            {
              "member_id": 66,
              "unit_id": 1094,
              "company_id": 1094,
              "fk_visitor_id": 8238055954796,
              "fk_building_unit_id": 2,
              "vendor_reference_id": null,
              "parent_member_id": null,
              "member_type": "tenant",
              "start_date": "2019-12-10",
              "end_date": null,
              "status": 0,
              "visitor_verify": 1,
              "is_dnd": 0,
              "whitelisted_at": null,
              "created_by": null,
              "created_at": "2019-12-10 07:39:49",
              "updated_by": null,
              "updated_at": "2019-12-10 07:39:49",
              "emergancy_contact": null,
              "emergancy_contact_relation": null,
              "emergancy_contact_relation_secondary": null,
              "emergancy_contact_secondary": null,
              "visitors": {
                "visitor_id": 8238055954796,
                "company_id": 1094,
                "first_name": "amit",
                "last_name": "dhawle",
                "gender": "M",
                "mobile": "918055954796",
                "email": null,
                "visitor_type": "member",
                "image_path":
                    "http://dev.prosimvizlog.s3-ap-southeast-1.amazonaws.com/visitors/visitor_8238055954796.jpg",
                "coming_from": null,
                "zip_code": null,
                "city": "noida",
                "state": "Badakhshan",
                "country": "Afghanistan",
                "image_large":
                    "http://dev.prosimvizlog.s3-ap-southeast-1.amazonaws.com/visitors/visitor_8238055954796_large.jpg",
                "image_medium":
                    "http://dev.prosimvizlog.s3-ap-southeast-1.amazonaws.com/visitors/visitor_8238055954796_medium.jpg",
                "image_small":
                    "http://dev.prosimvizlog.s3-ap-southeast-1.amazonaws.com/visitors/visitor_8238055954796_small.jpg"
              }
            },
            {
              "member_id": 79,
              "unit_id": 1094,
              "company_id": 1094,
              "fk_visitor_id": 15159004564166,
              "fk_building_unit_id": 2,
              "vendor_reference_id": null,
              "parent_member_id": null,
              "member_type": "owner",
              "start_date": "2019-12-13",
              "end_date": null,
              "status": 1,
              "visitor_verify": 1,
              "is_dnd": 0,
              "whitelisted_at": "2019-12-19 11:20:59",
              "created_by": null,
              "created_at": "2019-12-13 13:42:31",
              "updated_by": 10,
              "updated_at": "2019-12-19 11:20:59",
              "emergancy_contact": null,
              "emergancy_contact_relation": null,
              "emergancy_contact_relation_secondary": null,
              "emergancy_contact_secondary": null,
              "visitors": {
                "visitor_id": 15159004564166,
                "company_id": 1094,
                "first_name": "Amit",
                "last_name": "d dhawale",
                "gender": null,
                "mobile": "919004564166",
                "email": "ad@gmail.com",
                "visitor_type": "member",
                "image_path": null,
                "coming_from": null,
                "zip_code": null,
                "city": null,
                "state": null,
                "country": null,
                "image_large": null,
                "image_medium": null,
                "image_small": null
              }
            },
            {
              "member_id": 88,
              "unit_id": 1094,
              "company_id": 1094,
              "fk_visitor_id": 25017000000008,
              "fk_building_unit_id": 2,
              "vendor_reference_id": null,
              "parent_member_id": null,
              "member_type": "family",
              "start_date": "2019-12-23",
              "end_date": null,
              "status": 1,
              "visitor_verify": 1,
              "is_dnd": 0,
              "whitelisted_at": "2019-12-23 13:39:09",
              "created_by": null,
              "created_at": "2019-12-23 09:49:18",
              "updated_by": 10,
              "updated_at": "2019-12-23 13:39:09",
              "emergancy_contact": null,
              "emergancy_contact_relation": null,
              "emergancy_contact_relation_secondary": null,
              "emergancy_contact_secondary": null,
              "visitors": {
                "visitor_id": 25017000000008,
                "company_id": 1094,
                "first_name": "John",
                "last_name": "null",
                "gender": null,
                "mobile": "917000000008",
                "email": "john@gmail.com",
                "visitor_type": "member",
                "image_path": null,
                "coming_from": null,
                "zip_code": null,
                "city": null,
                "state": null,
                "country": null,
                "image_large": null,
                "image_medium": null,
                "image_small": null
              }
            }
          ]
        }
      ]
    };
  }
}
