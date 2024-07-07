// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_book_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserBookEntryCollection on Isar {
  IsarCollection<UserBookEntry> get userBookEntrys => this.collection();
}

const UserBookEntrySchema = CollectionSchema(
  name: r'UserBookEntry',
  id: 8574173189035031917,
  properties: {
    r'dateOfCurrentStatus': PropertySchema(
      id: 0,
      name: r'dateOfCurrentStatus',
      type: IsarType.dateTime,
    ),
    r'gallery': PropertySchema(
      id: 1,
      name: r'gallery',
      type: IsarType.stringList,
    ),
    r'status': PropertySchema(
      id: 2,
      name: r'status',
      type: IsarType.byte,
      enumMap: _UserBookEntrystatusEnumValueMap,
    )
  },
  estimateSize: _userBookEntryEstimateSize,
  serialize: _userBookEntrySerialize,
  deserialize: _userBookEntryDeserialize,
  deserializeProp: _userBookEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'bookNote': LinkSchema(
      id: -3787082839783751551,
      name: r'bookNote',
      target: r'BookNotes',
      single: false,
    ),
    r'finishedNote': LinkSchema(
      id: 501166541234078424,
      name: r'finishedNote',
      target: r'FinishedBookNote',
      single: true,
    ),
    r'bookReference': LinkSchema(
      id: -7934952021545960208,
      name: r'bookReference',
      target: r'Book',
      single: true,
      linkName: r'userDataReference',
    )
  },
  embeddedSchemas: {},
  getId: _userBookEntryGetId,
  getLinks: _userBookEntryGetLinks,
  attach: _userBookEntryAttach,
  version: '3.1.0+1',
);

int _userBookEntryEstimateSize(
  UserBookEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.gallery.length * 3;
  {
    for (var i = 0; i < object.gallery.length; i++) {
      final value = object.gallery[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _userBookEntrySerialize(
  UserBookEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateOfCurrentStatus);
  writer.writeStringList(offsets[1], object.gallery);
  writer.writeByte(offsets[2], object.status.index);
}

UserBookEntry _userBookEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserBookEntry(
    dateOfCurrentStatus: reader.readDateTimeOrNull(offsets[0]),
    status:
        _UserBookEntrystatusValueEnumMap[reader.readByteOrNull(offsets[2])] ??
            BookStatus.finished,
  );
  object.gallery = reader.readStringList(offsets[1]) ?? [];
  object.id = id;
  return object;
}

P _userBookEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (_UserBookEntrystatusValueEnumMap[reader.readByteOrNull(offset)] ??
          BookStatus.finished) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserBookEntrystatusEnumValueMap = {
  'finished': 0,
  'reading': 1,
  'listening': 2,
  'added': 3,
  'dropped': 4,
};
const _UserBookEntrystatusValueEnumMap = {
  0: BookStatus.finished,
  1: BookStatus.reading,
  2: BookStatus.listening,
  3: BookStatus.added,
  4: BookStatus.dropped,
};

Id _userBookEntryGetId(UserBookEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userBookEntryGetLinks(UserBookEntry object) {
  return [object.bookNote, object.finishedNote, object.bookReference];
}

void _userBookEntryAttach(
    IsarCollection<dynamic> col, Id id, UserBookEntry object) {
  object.id = id;
  object.bookNote
      .attach(col, col.isar.collection<BookNotes>(), r'bookNote', id);
  object.finishedNote.attach(
      col, col.isar.collection<FinishedBookNote>(), r'finishedNote', id);
  object.bookReference
      .attach(col, col.isar.collection<Book>(), r'bookReference', id);
}

extension UserBookEntryQueryWhereSort
    on QueryBuilder<UserBookEntry, UserBookEntry, QWhere> {
  QueryBuilder<UserBookEntry, UserBookEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserBookEntryQueryWhere
    on QueryBuilder<UserBookEntry, UserBookEntry, QWhereClause> {
  QueryBuilder<UserBookEntry, UserBookEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserBookEntryQueryFilter
    on QueryBuilder<UserBookEntry, UserBookEntry, QFilterCondition> {
  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      dateOfCurrentStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOfCurrentStatus',
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      dateOfCurrentStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOfCurrentStatus',
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      dateOfCurrentStatusEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfCurrentStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      dateOfCurrentStatusGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfCurrentStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      dateOfCurrentStatusLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfCurrentStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      dateOfCurrentStatusBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfCurrentStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gallery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gallery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gallery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gallery',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gallery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gallery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gallery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gallery',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gallery',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gallery',
        value: '',
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gallery',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gallery',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gallery',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gallery',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gallery',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      galleryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'gallery',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      statusEqualTo(BookStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      statusGreaterThan(
    BookStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      statusLessThan(
    BookStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      statusBetween(
    BookStatus lower,
    BookStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserBookEntryQueryObject
    on QueryBuilder<UserBookEntry, UserBookEntry, QFilterCondition> {}

extension UserBookEntryQueryLinks
    on QueryBuilder<UserBookEntry, UserBookEntry, QFilterCondition> {
  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition> bookNote(
      FilterQuery<BookNotes> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bookNote');
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookNoteLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookNote', length, true, length, true);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookNoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookNote', 0, true, 0, true);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookNoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookNote', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookNoteLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookNote', 0, true, length, include);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookNoteLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookNote', length, include, 999999, true);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookNoteLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'bookNote', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      finishedNote(FilterQuery<FinishedBookNote> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'finishedNote');
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      finishedNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'finishedNote', 0, true, 0, true);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookReference(FilterQuery<Book> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bookReference');
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterFilterCondition>
      bookReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookReference', 0, true, 0, true);
    });
  }
}

extension UserBookEntryQuerySortBy
    on QueryBuilder<UserBookEntry, UserBookEntry, QSortBy> {
  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy>
      sortByDateOfCurrentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfCurrentStatus', Sort.asc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy>
      sortByDateOfCurrentStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfCurrentStatus', Sort.desc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension UserBookEntryQuerySortThenBy
    on QueryBuilder<UserBookEntry, UserBookEntry, QSortThenBy> {
  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy>
      thenByDateOfCurrentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfCurrentStatus', Sort.asc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy>
      thenByDateOfCurrentStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfCurrentStatus', Sort.desc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension UserBookEntryQueryWhereDistinct
    on QueryBuilder<UserBookEntry, UserBookEntry, QDistinct> {
  QueryBuilder<UserBookEntry, UserBookEntry, QDistinct>
      distinctByDateOfCurrentStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfCurrentStatus');
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QDistinct> distinctByGallery() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gallery');
    });
  }

  QueryBuilder<UserBookEntry, UserBookEntry, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension UserBookEntryQueryProperty
    on QueryBuilder<UserBookEntry, UserBookEntry, QQueryProperty> {
  QueryBuilder<UserBookEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserBookEntry, DateTime?, QQueryOperations>
      dateOfCurrentStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfCurrentStatus');
    });
  }

  QueryBuilder<UserBookEntry, List<String>, QQueryOperations>
      galleryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gallery');
    });
  }

  QueryBuilder<UserBookEntry, BookStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
