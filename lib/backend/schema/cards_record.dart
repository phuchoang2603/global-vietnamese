import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CardsRecord extends FirestoreRecord {
  CardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "word_vn" field.
  String? _wordVn;
  String get wordVn => _wordVn ?? '';
  bool hasWordVn() => _wordVn != null;

  // "word_en" field.
  String? _wordEn;
  String get wordEn => _wordEn ?? '';
  bool hasWordEn() => _wordEn != null;

  // "word_fr" field.
  String? _wordFr;
  String get wordFr => _wordFr ?? '';
  bool hasWordFr() => _wordFr != null;

  // "starting_letter" field.
  String? _startingLetter;
  String get startingLetter => _startingLetter ?? '';
  bool hasStartingLetter() => _startingLetter != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "pronunciation" field.
  String? _pronunciation;
  String get pronunciation => _pronunciation ?? '';
  bool hasPronunciation() => _pronunciation != null;

  // "is_learnt" field.
  bool? _isLearnt;
  bool get isLearnt => _isLearnt ?? false;
  bool hasIsLearnt() => _isLearnt != null;

  // "review_date" field.
  DateTime? _reviewDate;
  DateTime? get reviewDate => _reviewDate;
  bool hasReviewDate() => _reviewDate != null;

  // "sr_group" field.
  int? _srGroup;
  int get srGroup => _srGroup ?? 0;
  bool hasSrGroup() => _srGroup != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  void _initializeFields() {
    _wordVn = snapshotData['word_vn'] as String?;
    _wordEn = snapshotData['word_en'] as String?;
    _wordFr = snapshotData['word_fr'] as String?;
    _startingLetter = snapshotData['starting_letter'] as String?;
    _image = snapshotData['image'] as String?;
    _pronunciation = snapshotData['pronunciation'] as String?;
    _isLearnt = snapshotData['is_learnt'] as bool?;
    _reviewDate = snapshotData['review_date'] as DateTime?;
    _srGroup = castToType<int>(snapshotData['sr_group']);
    _category = snapshotData['category'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cards');

  static Stream<CardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CardsRecord.fromSnapshot(s));

  static Future<CardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CardsRecord.fromSnapshot(s));

  static CardsRecord fromSnapshot(DocumentSnapshot snapshot) => CardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCardsRecordData({
  String? wordVn,
  String? wordEn,
  String? wordFr,
  String? startingLetter,
  String? image,
  String? pronunciation,
  bool? isLearnt,
  DateTime? reviewDate,
  int? srGroup,
  String? category,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'word_vn': wordVn,
      'word_en': wordEn,
      'word_fr': wordFr,
      'starting_letter': startingLetter,
      'image': image,
      'pronunciation': pronunciation,
      'is_learnt': isLearnt,
      'review_date': reviewDate,
      'sr_group': srGroup,
      'category': category,
    }.withoutNulls,
  );

  return firestoreData;
}

class CardsRecordDocumentEquality implements Equality<CardsRecord> {
  const CardsRecordDocumentEquality();

  @override
  bool equals(CardsRecord? e1, CardsRecord? e2) {
    return e1?.wordVn == e2?.wordVn &&
        e1?.wordEn == e2?.wordEn &&
        e1?.wordFr == e2?.wordFr &&
        e1?.startingLetter == e2?.startingLetter &&
        e1?.image == e2?.image &&
        e1?.pronunciation == e2?.pronunciation &&
        e1?.isLearnt == e2?.isLearnt &&
        e1?.reviewDate == e2?.reviewDate &&
        e1?.srGroup == e2?.srGroup &&
        e1?.category == e2?.category;
  }

  @override
  int hash(CardsRecord? e) => const ListEquality().hash([
        e?.wordVn,
        e?.wordEn,
        e?.wordFr,
        e?.startingLetter,
        e?.image,
        e?.pronunciation,
        e?.isLearnt,
        e?.reviewDate,
        e?.srGroup,
        e?.category
      ]);

  @override
  bool isValidKey(Object? o) => o is CardsRecord;
}
