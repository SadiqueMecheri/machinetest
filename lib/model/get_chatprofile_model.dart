// To parse this JSON data, do
//
//     final getChatProfileResponse = getChatProfileResponseFromJson(jsonString);

import 'dart:convert';

GetChatProfileResponse getChatProfileResponseFromJson(String str) => GetChatProfileResponse.fromJson(json.decode(str));

String getChatProfileResponseToJson(GetChatProfileResponse data) => json.encode(data.toJson());

class GetChatProfileResponse {
    List<ChatMainList>? data;
    List<Included>? included;
    Meta? meta;
    Links? links;

    GetChatProfileResponse({
        this.data,
        this.included,
        this.meta,
        this.links,
    });

    factory GetChatProfileResponse.fromJson(Map<String, dynamic> json) => GetChatProfileResponse(
        data: json["data"] == null ? [] : List<ChatMainList>.from(json["data"]!.map((x) => ChatMainList.fromJson(x))),
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

class ChatMainList {
    String? type;
    String? id;
    DatumAttributes? attributes;
    Relationships? relationships;

    ChatMainList({
        this.type,
        this.id,
        this.attributes,
        this.relationships,
    });

    factory ChatMainList.fromJson(Map<String, dynamic> json) => ChatMainList(
        type: json["type"],
        id: json["id"],
        attributes: json.containsKey("name") ? DatumAttributes.fromJson(json) : null,
        relationships: json.containsKey("userSettings") || json.containsKey("blockedContacts")
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
    DateTime? messageReceivedFromPartnerAt;
    int? authUserId;
    String? name;
    String? username;
    String? email;
    dynamic profilePhotoPath;
    dynamic profilePhotoId;
    String? phone;
    String? gender;
    int? countryId;
    String? countryName;
    int? stateId;
    String? stateName;
    int? cityId;
    String? cityName;
    dynamic customCityName;
    bool? isActive;
    String? customerCode;
    bool? isPremiumCustomer;
    bool? isOnline;
    dynamic bioIntroText;
    DateTime? lastActiveAt;
    String? address;
    DateTime? dateOfBirth;
    int? nativeLanguageId;
    String? nativeLanguageName;
    String? referralCode;
    String? referredBy;
    int? referredId;
    bool? isVanishModeEnabled;
    bool? isChatInitiated;
    DateTime? likebackCreatedAt;
    String? profilePhotoUrl;
    String? square100ProfilePhotoUrl;
    String? square300ProfilePhotoUrl;
    String? square500ProfilePhotoUrl;
    int? age;

    DatumAttributes({
        this.messageReceivedFromPartnerAt,
        this.authUserId,
        this.name,
        this.username,
        this.email,
        this.profilePhotoPath,
        this.profilePhotoId,
        this.phone,
        this.gender,
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
        this.customCityName,
        this.isActive,
        this.customerCode,
        this.isPremiumCustomer,
        this.isOnline,
        this.bioIntroText,
        this.lastActiveAt,
        this.address,
        this.dateOfBirth,
        this.nativeLanguageId,
        this.nativeLanguageName,
        this.referralCode,
        this.referredBy,
        this.referredId,
        this.isVanishModeEnabled,
        this.isChatInitiated,
        this.likebackCreatedAt,
        this.profilePhotoUrl,
        this.square100ProfilePhotoUrl,
        this.square300ProfilePhotoUrl,
        this.square500ProfilePhotoUrl,
        this.age,
    });

    factory DatumAttributes.fromJson(Map<String, dynamic> json) => DatumAttributes(
        messageReceivedFromPartnerAt: json["message_received_from_partner_at"] == null
            ? null
            : DateTime.tryParse(json["message_received_from_partner_at"]),
        authUserId: json["auth_user_id"]?.toInt(),
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profilePhotoPath: json["profile_photo_path"],
        profilePhotoId: json["profile_photo_id"],
        phone: json["phone"],
        gender: json["gender"],
        countryId: json["country_id"]?.toInt(),
        countryName: json["country_name"],
        stateId: json["state_id"]?.toInt(),
        stateName: json["state_name"],
        cityId: json["city_id"]?.toInt(),
        cityName: json["city_name"],
        customCityName: json["custom_city_name"],
        isActive: json["is_active"] ?? false,
        customerCode: json["customer_code"],
        isPremiumCustomer: json["is_premium_customer"] ?? false,
        isOnline: json["is_online"] ?? false,
        bioIntroText: json["bio_intro_text"],
        lastActiveAt: json["last_active_at"] == null
            ? null
            : DateTime.tryParse(json["last_active_at"]),
        address: json["address"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.tryParse(json["date_of_birth"]),
        nativeLanguageId: json["native_language_id"]?.toInt(),
        nativeLanguageName: json["native_language_name"],
        referralCode: json["referral_code"],
        referredBy: json["referred_by"],
        referredId: json["referred_id"]?.toInt(),
        isVanishModeEnabled: json["is_vanish_mode_enabled"] ?? false,
        isChatInitiated: json["is_chat_initiated"] ?? false,
        likebackCreatedAt: json["likeback_created_at"] == null
            ? null
            : DateTime.tryParse(json["likeback_created_at"]),
        profilePhotoUrl: json["profile_photo_url"],
        square100ProfilePhotoUrl: json["square100_profile_photo_url"],
        square300ProfilePhotoUrl: json["square300_profile_photo_url"],
        square500ProfilePhotoUrl: json["square500_profile_photo_url"],
        age: json["age"]?.toInt(),
    );

    Map<String, dynamic> toJson() => {
        "message_received_from_partner_at": messageReceivedFromPartnerAt?.toIso8601String(),
        "auth_user_id": authUserId,
        "name": name,
        "username": username,
        "email": email,
        "profile_photo_path": profilePhotoPath,
        "profile_photo_id": profilePhotoId,
        "phone": phone,
        "gender": gender,
        "country_id": countryId,
        "country_name": countryName,
        "state_id": stateId,
        "state_name": stateName,
        "city_id": cityId,
        "city_name": cityName,
        "custom_city_name": customCityName,
        "is_active": isActive,
        "customer_code": customerCode,
        "is_premium_customer": isPremiumCustomer,
        "is_online": isOnline,
        "bio_intro_text": bioIntroText,
        "last_active_at": lastActiveAt?.toIso8601String(),
        "address": address,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "native_language_id": nativeLanguageId,
        "native_language_name": nativeLanguageName,
        "referral_code": referralCode,
        "referred_by": referredBy,
        "referred_id": referredId,
        "is_vanish_mode_enabled": isVanishModeEnabled,
        "is_chat_initiated": isChatInitiated,
        "likeback_created_at": likebackCreatedAt?.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
        "square100_profile_photo_url": square100ProfilePhotoUrl,
        "square300_profile_photo_url": square300ProfilePhotoUrl,
        "square500_profile_photo_url": square500ProfilePhotoUrl,
        "age": age,
    };
}

class Relationships {
    BlockedContacts? blockedContacts;
    UserSettings? userSettings;

    Relationships({
        this.blockedContacts,
        this.userSettings,
    });

    factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        blockedContacts: json.containsKey("blockedContacts") && json["blockedContacts"] != null
            ? BlockedContacts.fromJson(json["blockedContacts"])
            : null,
        userSettings: json.containsKey("userSettings") && json["userSettings"] != null
            ? UserSettings.fromJson(json["userSettings"])
            : null,
    );

    Map<String, dynamic> toJson() => {
        "blockedContacts": blockedContacts?.toJson(),
        "userSettings": userSettings?.toJson(),
    };
}

class BlockedContacts {
    List<dynamic>? data;

    BlockedContacts({
        this.data,
    });

    factory BlockedContacts.fromJson(Map<String, dynamic> json) => BlockedContacts(
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    };
}

class UserSettings {
    Data? data;

    UserSettings({
        this.data,
    });

    factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        data: json.containsKey("type") && json.containsKey("id")
            ? Data.fromJson(json)
            : null,
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
    int? userId;
    bool? isRealGiftsAccepted;
    bool? isGenderRevealed;
    bool? isHeightRevealed;
    bool? isReligionRevealed;
    bool? isDrinkingHabitRevealed;
    bool? isSmokingHabitRevealed;
    bool? isSexualOrientationRevealed;
    bool? isEducationalQualificationRevealed;
    bool? isPersonalityTraitsRevealed;
    bool? isLifestyleActivitiesRevealed;
    bool? isContactDiscoveryEnabled;
    bool? isGhostModeEnabled;
    bool? isDarkModeEnabled;
    bool? isReceivingPushNotifications;
    bool? isReceivingFlashMessages;
    bool? isLastSeenEnabled;
    bool? isOnlineStatusEnabled;
    bool? isReadReceiptsEnabled;

    IncludedAttributes({
        this.userId,
        this.isRealGiftsAccepted,
        this.isGenderRevealed,
        this.isHeightRevealed,
        this.isReligionRevealed,
        this.isDrinkingHabitRevealed,
        this.isSmokingHabitRevealed,
        this.isSexualOrientationRevealed,
        this.isEducationalQualificationRevealed,
        this.isPersonalityTraitsRevealed,
        this.isLifestyleActivitiesRevealed,
        this.isContactDiscoveryEnabled,
        this.isGhostModeEnabled,
        this.isDarkModeEnabled,
        this.isReceivingPushNotifications,
        this.isReceivingFlashMessages,
        this.isLastSeenEnabled,
        this.isOnlineStatusEnabled,
        this.isReadReceiptsEnabled,
    });

    factory IncludedAttributes.fromJson(Map<String, dynamic> json) => IncludedAttributes(
        userId: json["user_id"]?.toInt(),
        isRealGiftsAccepted: json["is_real_gifts_accepted"] ?? false,
        isGenderRevealed: json["is_gender_revealed"] ?? false,
        isHeightRevealed: json["is_height_revealed"] ?? false,
        isReligionRevealed: json["is_religion_revealed"] ?? false,
        isDrinkingHabitRevealed: json["is_drinking_habit_revealed"] ?? false,
        isSmokingHabitRevealed: json["is_smoking_habit_revealed"] ?? false,
        isSexualOrientationRevealed: json["is_sexual_orientation_revealed"] ?? false,
        isEducationalQualificationRevealed: json["is_educational_qualification_revealed"] ?? false,
        isPersonalityTraitsRevealed: json["is_personality_traits_revealed"] ?? false,
        isLifestyleActivitiesRevealed: json["is_lifestyle_activities_revealed"] ?? false,
        isContactDiscoveryEnabled: json["is_contact_discovery_enabled"] ?? false,
        isGhostModeEnabled: json["is_ghost_mode_enabled"] ?? false,
        isDarkModeEnabled: json["is_dark_mode_enabled"] ?? false,
        isReceivingPushNotifications: json["is_receiving_push_notifications"] ?? false,
        isReceivingFlashMessages: json["is_receiving_flash_messages"] ?? false,
        isLastSeenEnabled: json["is_last_seen_enabled"] ?? false,
        isOnlineStatusEnabled: json["is_online_status_enabled"] ?? false,
        isReadReceiptsEnabled: json["is_read_receipts_enabled"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "is_real_gifts_accepted": isRealGiftsAccepted,
        "is_gender_revealed": isGenderRevealed,
        "is_height_revealed": isHeightRevealed,
        "is_religion_revealed": isReligionRevealed,
        "is_drinking_habit_revealed": isDrinkingHabitRevealed,
        "is_smoking_habit_revealed": isSmokingHabitRevealed,
        "is_sexual_orientation_revealed": isSexualOrientationRevealed,
        "is_educational_qualification_revealed": isEducationalQualificationRevealed,
        "is_personality_traits_revealed": isPersonalityTraitsRevealed,
        "is_lifestyle_activities_revealed": isLifestyleActivitiesRevealed,
        "is_contact_discovery_enabled": isContactDiscoveryEnabled,
        "is_ghost_mode_enabled": isGhostModeEnabled,
        "is_dark_mode_enabled": isDarkModeEnabled,
        "is_receiving_push_notifications": isReceivingPushNotifications,
        "is_receiving_flash_messages": isReceivingFlashMessages,
        "is_last_seen_enabled": isLastSeenEnabled,
        "is_online_status_enabled": isOnlineStatusEnabled,
        "is_read_receipts_enabled": isReadReceiptsEnabled,
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