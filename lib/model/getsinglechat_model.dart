// To parse this JSON data, do
//
//     final getSingleChatModel = getSingleChatModelFromJson(jsonString);

import 'dart:convert';

GetSingleChatModel getSingleChatModelFromJson(String str) => GetSingleChatModel.fromJson(json.decode(str));

String getSingleChatModelToJson(GetSingleChatModel data) => json.encode(data.toJson());

class GetSingleChatModel {
    List<SingleChat>? data;
    List<Included>? included;
    Meta? meta;
    Links? links;

    GetSingleChatModel({
        this.data,
        this.included,
        this.meta,
        this.links,
    });

    factory GetSingleChatModel.fromJson(Map<String, dynamic> json) => GetSingleChatModel(
        data: json["data"] == null ? [] : List<SingleChat>.from(json["data"]!.map((x) => SingleChat.fromJson(x))),
        included: json["included"] == null ? [] : List<Included>.from(json["included"]!.map((x) => Included.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "included": included == null ? [] : List<dynamic>.from(included!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
        "links": links?.toJson(),
    };
}

class SingleChat {
    String? type;
    String? id;
    DatumAttributes? attributes;
    Relationships? relationships;

    SingleChat({
        this.type,
        this.id,
        this.attributes,
        this.relationships,
    });

    factory SingleChat.fromJson(Map<String, dynamic> json) => SingleChat(
        type: json["type"],
        id: json["id"],
        attributes: json.containsKey("chat_thread_id") ? DatumAttributes.fromJson(json) : null,
        relationships: json.containsKey("sender") || json.containsKey("sticker") || json.containsKey("giftOrder")
            ? Relationships.fromJson(json)
            : null,
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes?.toJson(),
        "relationships": relationships?.toJson(),
    };
}

class DatumAttributes {
    int? chatThreadId;
    int? chatMessageTypeId;
    int? senderId;
    int? receiverId;
    String? message;
    dynamic mediaMeta;
    bool? isOneTimeView;
    int? isReadReceiptsOn;
    dynamic isOneTimeViewedAt;
    bool? isOnVanishMode;
    dynamic scheduledAt;
    DateTime? sentAt;
    DateTime? deliveredAt;
    dynamic viewedAt;
    dynamic stickerId;
    dynamic giftOrderId;
    dynamic senderCoinTransactionId;
    dynamic receiverCoinTransactionId;
    dynamic transferCoins;
    dynamic deletedForSenderBy;
    dynamic deletedForSenderAt;
    dynamic deletedForReceiverBy;
    dynamic deletedForReceiverAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic mediaUrl;

    DatumAttributes({
        this.chatThreadId,
        this.chatMessageTypeId,
        this.senderId,
        this.receiverId,
        this.message,
        this.mediaMeta,
        this.isOneTimeView,
        this.isReadReceiptsOn,
        this.isOneTimeViewedAt,
        this.isOnVanishMode,
        this.scheduledAt,
        this.sentAt,
        this.deliveredAt,
        this.viewedAt,
        this.stickerId,
        this.giftOrderId,
        this.senderCoinTransactionId,
        this.receiverCoinTransactionId,
        this.transferCoins,
        this.deletedForSenderBy,
        this.deletedForSenderAt,
        this.deletedForReceiverBy,
        this.deletedForReceiverAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.mediaUrl,
    });

    factory DatumAttributes.fromJson(Map<String, dynamic> json) => DatumAttributes(
        chatThreadId: json["chat_thread_id"]?.toInt(),
        chatMessageTypeId: json["chat_message_type_id"]?.toInt(),
        senderId: json["sender_id"]?.toInt(),
        receiverId: json["receiver_id"]?.toInt(),
        message: json["message"],
        mediaMeta: json["media_meta"],
        isOneTimeView: json["is_one_time_view"] ?? false,
        isReadReceiptsOn: json["is_read_receipts_on"]?.toInt() ?? 0,
        isOneTimeViewedAt: json["is_one_time_viewed_at"],
        isOnVanishMode: json["is_on_vanish_mode"] ?? false,
        scheduledAt: json["scheduled_at"],
        sentAt: json["sent_at"] == null ? null : DateTime.tryParse(json["sent_at"]),
        deliveredAt: json["delivered_at"] == null ? null : DateTime.tryParse(json["delivered_at"]),
        viewedAt: json["viewed_at"],
        stickerId: json["sticker_id"],
        giftOrderId: json["gift_order_id"],
        senderCoinTransactionId: json["sender_coin_transaction_id"],
        receiverCoinTransactionId: json["receiver_coin_transaction_id"],
        transferCoins: json["transfer_coins"],
        deletedForSenderBy: json["deleted_for_sender_by"],
        deletedForSenderAt: json["deleted_for_sender_at"],
        deletedForReceiverBy: json["deleted_for_receiver_by"],
        deletedForReceiverAt: json["deleted_for_receiver_at"],
        createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        mediaUrl: json["media_url"],
    );

    Map<String, dynamic> toJson() => {
        "chat_thread_id": chatThreadId,
        "chat_message_type_id": chatMessageTypeId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "media_meta": mediaMeta,
        "is_one_time_view": isOneTimeView,
        "is_read_receipts_on": isReadReceiptsOn,
        "is_one_time_viewed_at": isOneTimeViewedAt,
        "is_on_vanish_mode": isOnVanishMode,
        "scheduled_at": scheduledAt,
        "sent_at": sentAt?.toIso8601String(),
        "delivered_at": deliveredAt?.toIso8601String(),
        "viewed_at": viewedAt,
        "sticker_id": stickerId,
        "gift_order_id": giftOrderId,
        "sender_coin_transaction_id": senderCoinTransactionId,
        "receiver_coin_transaction_id": receiverCoinTransactionId,
        "transfer_coins": transferCoins,
        "deleted_for_sender_by": deletedForSenderBy,
        "deleted_for_sender_at": deletedForSenderAt,
        "deleted_for_receiver_by": deletedForReceiverBy,
        "deleted_for_receiver_at": deletedForReceiverAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "media_url": mediaUrl,
    };
}

class Relationships {
    GiftOrder? sender;
    GiftOrder? sticker;
    GiftOrder? giftOrder;

    Relationships({
        this.sender,
        this.sticker,
        this.giftOrder,
    });

    factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        sender: json.containsKey("sender") && json["sender"] != null ? GiftOrder.fromJson(json["sender"]) : null,
        sticker: json.containsKey("sticker") && json["sticker"] != null ? GiftOrder.fromJson(json["sticker"]) : null,
        giftOrder: json.containsKey("giftOrder") && json["giftOrder"] != null ? GiftOrder.fromJson(json["giftOrder"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "sender": sender?.toJson(),
        "sticker": sticker?.toJson(),
        "giftOrder": giftOrder?.toJson(),
    };
}

class GiftOrder {
    Data? data;

    GiftOrder({
        this.data,
    });

    factory GiftOrder.fromJson(Map<String, dynamic> json) => GiftOrder(
        data: json.containsKey("type") && json.containsKey("id") ? Data.fromJson(json) : null,
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    String? type;
    String? id;

    Data({
        this.type,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
    };
}

class Included {
    String? type;
    String? id;
    IncludedAttributes? attributes;

    Included({
        this.type,
        this.id,
        this.attributes,
    });

    factory Included.fromJson(Map<String, dynamic> json) => Included(
        type: json["type"],
        id: json["id"],
        attributes: json["attributes"] == null ? null : IncludedAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes?.toJson(),
    };
}

class IncludedAttributes {
    String? name;
    String? username;
    String? email;
    String? profilePhotoUrl;
    String? square100ProfilePhotoUrl;
    String? square300ProfilePhotoUrl;
    String? square500ProfilePhotoUrl;
    dynamic age;

    IncludedAttributes({
        this.name,
        this.username,
        this.email,
        this.profilePhotoUrl,
        this.square100ProfilePhotoUrl,
        this.square300ProfilePhotoUrl,
        this.square500ProfilePhotoUrl,
        this.age,
    });

    factory IncludedAttributes.fromJson(Map<String, dynamic> json) => IncludedAttributes(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profilePhotoUrl: json["profile_photo_url"],
        square100ProfilePhotoUrl: json["square100_profile_photo_url"],
        square300ProfilePhotoUrl: json["square300_profile_photo_url"],
        square500ProfilePhotoUrl: json["square500_profile_photo_url"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "profile_photo_url": profilePhotoUrl,
        "square100_profile_photo_url": square100ProfilePhotoUrl,
        "square300_profile_photo_url": square300ProfilePhotoUrl,
        "square500_profile_photo_url": square500ProfilePhotoUrl,
        "age": age,
    };
}

class Links {
    String? self;
    String? first;
    String? last;

    Links({
        this.self,
        this.first,
        this.last,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        first: json["first"],
        last: json["last"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
        "first": first,
        "last": last,
    };
}

class Meta {
    Pagination? pagination;

    Meta({
        this.pagination,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
    };
}

class Pagination {
    int? total;
    int? count;
    int? perPage;
    int? currentPage;
    int? totalPages;

    Pagination({
        this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"]?.toInt(),
        count: json["count"]?.toInt(),
        perPage: json["per_page"]?.toInt(),
        currentPage: json["current_page"]?.toInt(),
        totalPages: json["total_pages"]?.toInt(),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
    };
}