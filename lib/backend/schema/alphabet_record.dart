import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AlphabetRecord extends FirestoreRecord {
  AlphabetRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "letter" field.
  String? _letter;
  String get letter => _letter ?? '';
  bool hasLetter() => _letter != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  // "learning" field.
  bool? _learning;
  bool get learning => _learning ?? false;
  bool hasLearning() => _learning != null;

  void _initializeFields() {
    _letter = snapshotData['letter'] as String?;
    _order = castToType<int>(snapshotData['order']);
    _learning = snapshotData['learning'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('alphabet');

  static Stream<AlphabetRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AlphabetRecord.fromSnapshot(s));

  static Future<AlphabetRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AlphabetRecord.fromSnapshot(s));

  static AlphabetRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AlphabetRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AlphabetRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AlphabetRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AlphabetRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AlphabetRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAlphabetRecordData({
  String? letter,
  int? order,
  bool? learning,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'letter': letter,
      'order': order,
      'learning': learning,
    }.withoutNulls,
  );

  return firestoreData;
}

class AlphabetRecordDocumentEquality implements Equality<AlphabetRecord> {
  const AlphabetRecordDocumentEquality();

  @override
  bool equals(AlphabetRecord? e1, AlphabetRecord? e2) {
    return e1?.letter == e2?.letter &&
        e1?.order == e2?.order &&
        e1?.learning == e2?.learning;
  }

  @override
  int hash(AlphabetRecord? e) =>
      const ListEquality().hash([e?.letter, e?.order, e?.learning]);

  @override
  bool isValidKey(Object? o) => o is AlphabetRecord;
}
