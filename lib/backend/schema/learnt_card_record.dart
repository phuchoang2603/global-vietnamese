import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LearntCardRecord extends FirestoreRecord {
  LearntCardRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "card_ref" field.
  DocumentReference? _cardRef;
  DocumentReference? get cardRef => _cardRef;
  bool hasCardRef() => _cardRef != null;

  // "review_date" field.
  DateTime? _reviewDate;
  DateTime? get reviewDate => _reviewDate;
  bool hasReviewDate() => _reviewDate != null;

  // "sr_group" field.
  int? _srGroup;
  int get srGroup => _srGroup ?? 0;
  bool hasSrGroup() => _srGroup != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  void _initializeFields() {
    _cardRef = snapshotData['card_ref'] as DocumentReference?;
    _reviewDate = snapshotData['review_date'] as DateTime?;
    _srGroup = castToType<int>(snapshotData['sr_group']);
    _userId = snapshotData['user_id'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('learnt_card');

  static Stream<LearntCardRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LearntCardRecord.fromSnapshot(s));

  static Future<LearntCardRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LearntCardRecord.fromSnapshot(s));

  static LearntCardRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LearntCardRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LearntCardRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LearntCardRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LearntCardRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LearntCardRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLearntCardRecordData({
  DocumentReference? cardRef,
  DateTime? reviewDate,
  int? srGroup,
  DocumentReference? userId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'card_ref': cardRef,
      'review_date': reviewDate,
      'sr_group': srGroup,
      'user_id': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class LearntCardRecordDocumentEquality implements Equality<LearntCardRecord> {
  const LearntCardRecordDocumentEquality();

  @override
  bool equals(LearntCardRecord? e1, LearntCardRecord? e2) {
    return e1?.cardRef == e2?.cardRef &&
        e1?.reviewDate == e2?.reviewDate &&
        e1?.srGroup == e2?.srGroup &&
        e1?.userId == e2?.userId;
  }

  @override
  int hash(LearntCardRecord? e) => const ListEquality()
      .hash([e?.cardRef, e?.reviewDate, e?.srGroup, e?.userId]);

  @override
  bool isValidKey(Object? o) => o is LearntCardRecord;
}
