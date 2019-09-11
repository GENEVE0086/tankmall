class ItemDetailEntity {
	String msg;
	int code;
	ItemDetailData data;
	bool success;

	ItemDetailEntity({this.msg, this.code, this.data, this.success});

	ItemDetailEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new ItemDetailData.fromJson(json['data']) : null;
		success = json['success'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.data != null) {
			data['data'] = this.data.toJson();
		}
		data['success'] = this.success;
		return data;
	}
}

class ItemDetailData {
	ItemDetailDataItem item;
	List<String> itemDetail;

	ItemDetailData({this.item, this.itemDetail});

	ItemDetailData.fromJson(Map<String, dynamic> json) {
		item = json['item'] != null ? new ItemDetailDataItem.fromJson(json['item']) : null;
		itemDetail = json['itemDetail']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.item != null) {
			data['item'] = this.item.toJson();
		}
		data['itemDetail'] = this.itemDetail;
		return data;
	}
}

class ItemDetailDataItem {
	int itemId;
	String itemName;
	int productId;
	double price;
	String logo;
	String detail;

	ItemDetailDataItem({this.itemId, this.itemName, this.productId, this.price, this.logo, this.detail});

	ItemDetailDataItem.fromJson(Map<String, dynamic> json) {
		itemId = json['itemId'];
		itemName = json['itemName'];
		productId = json['productId'];
		price = json['price'];
		logo = json['logo'];
		detail = json['detail'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemId'] = this.itemId;
		data['itemName'] = this.itemName;
		data['productId'] = this.productId;
		data['price'] = this.price;
		data['logo'] = this.logo;
		data['detail'] = this.detail;
		return data;
	}
}
