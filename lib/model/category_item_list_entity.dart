class CategoryItemListModel {
	int code;
	String msg;
	ItemList data;
	bool success;
//	String status;

	CategoryItemListModel({this.code, this.msg, this.data, this.success});

	CategoryItemListModel.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		msg = json['msg'];
		if (json['data'] != null) {
			data = new ItemList.fromJson(json['data']);
		}
		success = json['success'];
//		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['msg'] = this.msg;
		if (this.data != null) {
			data['data'] = this.data.toJson();
		}
		data['success'] = this.success;
//		data['status'] = this.status;
		return data;
	}
}

class ItemList {
	List<Item> itemList;

	ItemList(this.itemList);

	ItemList.fromJson(Map<String, dynamic> json) {
		itemList = new List<Item>();
		json['itemList'].forEach((v){
			itemList.add(new Item.fromJson(v));
		});
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (itemList != null) {
			data['itemList'] = itemList.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class Item {
	int itemId;
	int productId;
	String itemName;
	double price;
	String logo;
	String detail;

	Item(this.itemId,
			this.productId,
			this.itemName,
			this.price,
			this.logo,
			this.detail);

	Item.fromJson(Map<String, dynamic> json) {
		itemId = json['itemId'];
		productId = json['productId'];
		itemName = json['itemName'];
		price = json['price'];
		logo = json['logo'];
		detail = json['detail'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemId'] = this.itemId;
		data['productId'] = this.productId;
		data['itemName'] = this.itemName;
		data['price'] = this.price;
		data['logo'] = this.logo;
		data['detail'] = this.detail;
		return data;
	}
}
