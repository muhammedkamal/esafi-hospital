import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../global/data/models/hospitals.dart';

// to get string from enum
// describeEnum(CaseCategories.accident);
//to get enum from string
// CaseCategories.values.firstWhere((element) => describeEnum(element) == e);

class AmbulanceRequest {
  String? id;
  final String userId;
  String? hospitalId;
  String? ambulanceId;
  Ambulance? ambulance;
  AmbulanceRequestStatus status;
  GeoPoint? sourceLocation; //source
  GeoPoint? destinationLocation; //destination
  GeoPoint? ambulanceLocation;
  DateTime? createdAt;
  DateTime? acceptedAt;
  DateTime? inProgressAt;
  DateTime? canceledAt;
  DateTime? completedAt;
  AmbulanceRequestType type;
  CaseDetails? caseDetails;

  AmbulanceRequest({
    this.id,
    required this.userId,
    this.hospitalId,
    this.ambulanceId,
    required this.status,
    this.sourceLocation,
    this.destinationLocation,
    this.ambulanceLocation,
    this.createdAt,
    this.acceptedAt,
    this.inProgressAt,
    this.canceledAt,
    this.completedAt,
    required this.type,
    this.caseDetails,
    this.ambulance,
  });

  //serialize
  factory AmbulanceRequest.fromMap(Map<String, dynamic> data) {
    return AmbulanceRequest(
      id: data['id'],
      userId: data['userId'],
      hospitalId: data['hospitalId'],
      ambulanceId: data['ambulanceId'],
      status: AmbulanceRequestStatus.values
          .firstWhere((element) => describeEnum(element) == data['status']),
      sourceLocation: data['sourceLocation'],
      destinationLocation: data['destinationLocation'],
      ambulanceLocation: data['ambulanceLocation'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      acceptedAt: data['acceptedAt'] != null
          ? (data['acceptedAt'] as Timestamp).toDate()
          : null,
      inProgressAt: data['inProgressAt'] != null
          ? (data['inProgressAt'] as Timestamp).toDate()
          : null,
      canceledAt: data['canceledAt'] != null
          ? (data['canceledAt'] as Timestamp).toDate()
          : null,
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      type: AmbulanceRequestType.values
          .firstWhere((element) => describeEnum(element) == data['type']),
      caseDetails: data['caseDetails'] != null
          ? CaseDetails.fromMap(data['caseDetails'])
          : null,
    );
  }

  //deserialize
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'hospitalId': hospitalId,
      'ambulanceId': ambulanceId,
      'status': describeEnum(status),
      'sourceLocation': sourceLocation,
      'destinationLocation': destinationLocation,
      'ambulanceLocation': ambulanceLocation,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'acceptedAt': acceptedAt,
      'inProgressAt': inProgressAt,
      'canceledAt': canceledAt,
      'completedAt': completedAt,
      'type': describeEnum(type),
      'caseDetails': caseDetails?.toMap(),
    };
  }

  //from firestore
  factory AmbulanceRequest.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return AmbulanceRequest.fromMap(data);
  }

  //copy with
  AmbulanceRequest copyWith({
    String? id,
    String? userId,
    String? hospitalId,
    String? ambulanceId,
    AmbulanceRequestStatus? status,
    GeoPoint? sourceLocation,
    GeoPoint? destinationLocation,
    GeoPoint? ambulanceLocation,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? inProgressAt,
    DateTime? canceledAt,
    DateTime? completedAt,
    AmbulanceRequestType? type,
    CaseDetails? caseDetails,
  }) {
    return AmbulanceRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      hospitalId: hospitalId ?? this.hospitalId,
      ambulanceId: ambulanceId ?? this.ambulanceId,
      status: status ?? this.status,
      sourceLocation: sourceLocation ?? this.sourceLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      ambulanceLocation: ambulanceLocation ?? this.ambulanceLocation,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      inProgressAt: inProgressAt ?? this.inProgressAt,
      canceledAt: canceledAt ?? this.canceledAt,
      completedAt: completedAt ?? this.completedAt,
      type: type ?? this.type,
      caseDetails: caseDetails ?? this.caseDetails,
    );
  }

  //to string
  @override
  String toString() {
    return 'AmbulanceRequest(id: $id, userId: $userId, hospitalId: $hospitalId, ambulanceId: $ambulanceId, status: $status, sourceLocation: $sourceLocation, destinationLocation: $destinationLocation, ambulanceLocation: $ambulanceLocation, createdAt: $createdAt, acceptedAt: $acceptedAt, inProgressAt: $inProgressAt, canceledAt: $canceledAt, completedAt: $completedAt, type: $type, caseDetails: $caseDetails)';
  }
}

enum AmbulanceRequestStatus {
  pending,
  accepted,
  inProgress,
  canceled,
  completed
}

enum AmbulanceRequestType { emergency, normal }

class CaseDetails {
  String title;
  num numberOfPatients;
  List<String>? caseImages;
  CaseCategories category;
  CaseDetails(
      {required this.title,
      required this.numberOfPatients,
      this.caseImages,
      required this.category});

  //serialize
  factory CaseDetails.fromMap(Map<String, dynamic> data) {
    return CaseDetails(
      title: data['title'],
      numberOfPatients: data['numberOfPatients'] is String
          ? num.parse(data['numberOfPatients'])
          : data['numberOfPatients'],
      category: data['category'] is CaseCategories
          ? data['category']
          : CaseCategories.values.firstWhere(
              (element) => describeEnum(element) == data['category']),
      caseImages: (data['caseImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  //deserialize
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'numberOfPatients': numberOfPatients,
      'category': describeEnum(category),
      'caseImages': caseImages,
    };
  }
}

enum CaseCategories { accident, heartAttack, stroke, other }
