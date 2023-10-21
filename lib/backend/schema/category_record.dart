import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CategoryRecord extends FirestoreRecord {
  CategoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "name_vn" field.
  String? _nameVn;
  String get nameVn => _nameVn ?? '';
  bool hasNameVn() => _nameVn != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "is_learning" field.
  bool? _isLearning;
  bool get isLearning => _isLearning ?? false;
  bool hasIsLearning() => _isLearning != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _nameVn = snapshotData['name_vn'] as String?;
    _image = snapshotData['image'] as String?;
    _isLearning = snapshotData['is_learning'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('category');

  static Stream<CategoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CategoryRecord.fromSnapshot(s));

  static Future<CategoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CategoryRecord.fromSnapshot(s));

  static CategoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CategoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CategoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CategoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CategoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CategoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCategoryRecordData({
  String? name,
  String? nameVn,
  String? image,
  bool? isLearning,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'name_vn': nameVn,
      'image': image,
      'is_learning': isLearning,
    }.withoutNulls,
  );

  return firestoreData;
}

class CategoryRecordDocumentEquality implements Equality<CategoryRecord> {
  const CategoryRecordDocumentEquality();

  @override
  bool equals(CategoryRecord? e1, CategoryRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.nameVn == e2?.nameVn &&
        e1?.image == e2?.image &&
        e1?.isLearning == e2?.isLearning;
  }

  @override
  int hash(CategoryRecord? e) =>
      const ListEquality().hash([e?.name, e?.nameVn, e?.image, e?.isLearning]);

  @override
  bool isValidKey(Object? o) => o is CategoryRecord;
}
