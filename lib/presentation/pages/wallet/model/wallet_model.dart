class WalletModel {
  Wallet? wallet;
  Transactions? transactions;

  WalletModel({this.wallet, this.transactions});

  WalletModel.fromJson(Map<String, dynamic> json) {
    wallet =
    json['wallet'] != null ? Wallet.fromJson(json['wallet']) : Wallet(amount: "0");
    transactions = json['transactions'] != null
        ? Transactions.fromJson(json['transactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? id;
  int? userId;
  String? amount;
  String? createdAt;
  String? updatedAt;

  Wallet({this.id, this.userId, this.amount, this.createdAt, this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Transactions {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Transactions(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Transactions.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? bookingId;
  String? reason;
  String? orderId;
  String? paymentId;
  String? amount;
  String? serviceAmount;
  String? type;
  String? method;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.bookingId,
        this.reason,
        this.orderId,
        this.paymentId,
        this.amount,
        this.serviceAmount,
        this.type,
        this.method,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    reason = json['reason'];
    orderId = json['order_id'];
    paymentId = json['payment_id'];
    amount = json['amount'];
    serviceAmount = json['service_amount'];
    type = json['type'];
    method = json['method'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['booking_id'] = bookingId;
    data['reason'] = reason;
    data['order_id'] = orderId;
    data['payment_id'] = paymentId;
    data['amount'] = amount;
    data['service_amount'] = serviceAmount;
    data['type'] = type;
    data['method'] = method;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}