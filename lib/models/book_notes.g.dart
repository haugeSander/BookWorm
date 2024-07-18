// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_notes.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookNotesCollection on Isar {
  IsarCollection<BookNotes> get bookNotes => this.collection();
}

const BookNotesSchema = CollectionSchema(
  name: r'BookNotes',
  id: 2573453524368001867,
  properties: {
    r'noteContent': PropertySchema(
      id: 0,
      name: r'noteContent',
      type: IsarType.string,
    ),
    r'noteNumber': PropertySchema(
      id: 1,
      name: r'noteNumber',
      type: IsarType.long,
    ),
    r'statusWhenNoted': PropertySchema(
      id: 2,
      name: r'statusWhenNoted',
      type: IsarType.byte,
      enumMap: _BookNotesstatusWhenNotedEnumValueMap,
    ),
    r'timeOfNote': PropertySchema(
      id: 3,
      name: r'timeOfNote',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _bookNotesEstimateSize,
  serialize: _bookNotesSerialize,
  deserialize: _bookNotesDeserialize,
  deserializeProp: _bookNotesDeserializeProp,
  idName: r'noteId',
  indexes: {},
  links: {
    r'bookReference': LinkSchema(
      id: 1013598117759763890,
      name: r'bookReference',
      target: r'UserBookEntry',
      single: true,
      linkName: r'bookNote',
    )
  },
  embeddedSchemas: {},
  getId: _bookNotesGetId,
  getLinks: _bookNotesGetLinks,
  attach: _bookNotesAttach,
  version: '3.1.0+1',
);

int _bookNotesEstimateSize(
  BookNotes object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.noteContent.length * 3;
  return bytesCount;
}

void _bookNotesSerialize(
  BookNotes object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.noteContent);
  writer.writeLong(offsets[1], object.noteNumber);
  writer.writeByte(offsets[2], object.statusWhenNoted.index);
  writer.writeDateTime(offsets[3], object.timeOfNote);
}

BookNotes _bookNotesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookNotes(
    noteContent: reader.readString(offsets[0]),
    noteNumber: reader.readLong(offsets[1]),
    statusWhenNoted: _BookNotesstatusWhenNotedValueEnumMap[
            reader.readByteOrNull(offsets[2])] ??
        BookStatus.finished,
    timeOfNote: reader.readDateTime(offsets[3]),
  );
  object.noteId = id;
  return object;
}

P _bookNotesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_BookNotesstatusWhenNotedValueEnumMap[
              reader.readByteOrNull(offset)] ??
          BookStatus.finished) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BookNotesstatusWhenNotedEnumValueMap = {
  'finished': 0,
  'reading': 1,
  'listening': 2,
  'added': 3,
  'dropped': 4,
};
const _BookNotesstatusWhenNotedValueEnumMap = {
  0: BookStatus.finished,
  1: BookStatus.reading,
  2: BookStatus.listening,
  3: BookStatus.added,
  4: BookStatus.dropped,
};

Id _bookNotesGetId(BookNotes object) {
  return object.noteId;
}

List<IsarLinkBase<dynamic>> _bookNotesGetLinks(BookNotes object) {
  return [object.bookReference];
}

void _bookNotesAttach(IsarCollection<dynamic> col, Id id, BookNotes object) {
  object.noteId = id;
  object.bookReference
      .attach(col, col.isar.collection<UserBookEntry>(), r'bookReference', id);
}

extension BookNotesQueryWhereSort
    on QueryBuilder<BookNotes, BookNotes, QWhere> {
  QueryBuilder<BookNotes, BookNotes, QAfterWhere> anyNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookNotesQueryWhere
    on QueryBuilder<BookNotes, BookNotes, QWhereClause> {
  QueryBuilder<BookNotes, BookNotes, QAfterWhereClause> noteIdEqualTo(
      Id noteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: noteId,
        upper: noteId,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterWhereClause> noteIdNotEqualTo(
      Id noteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: noteId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: noteId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: noteId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: noteId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterWhereClause> noteIdGreaterThan(
      Id noteId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: noteId, includeLower: include),
      );
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterWhereClause> noteIdLessThan(
      Id noteId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: noteId, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterWhereClause> noteIdBetween(
    Id lowerNoteId,
    Id upperNoteId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerNoteId,
        includeLower: includeLower,
        upper: upperNoteId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookNotesQueryFilter
    on QueryBuilder<BookNotes, BookNotes, QFilterCondition> {
  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteContentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      noteContentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteContentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteContentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteContent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      noteContentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'noteContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteContentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'noteContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteContentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'noteContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteContentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'noteContent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      noteContentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteContent',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      noteContentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'noteContent',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteId',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      noteNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> noteNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      statusWhenNotedEqualTo(BookStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusWhenNoted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      statusWhenNotedGreaterThan(
    BookStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusWhenNoted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      statusWhenNotedLessThan(
    BookStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusWhenNoted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      statusWhenNotedBetween(
    BookStatus lower,
    BookStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusWhenNoted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeOfNoteEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeOfNote',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      timeOfNoteGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeOfNote',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeOfNoteLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeOfNote',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeOfNoteBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeOfNote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookNotesQueryObject
    on QueryBuilder<BookNotes, BookNotes, QFilterCondition> {}

extension BookNotesQueryLinks
    on QueryBuilder<BookNotes, BookNotes, QFilterCondition> {
  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> bookReference(
      FilterQuery<UserBookEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bookReference');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      bookReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookReference', 0, true, 0, true);
    });
  }
}

extension BookNotesQuerySortBy on QueryBuilder<BookNotes, BookNotes, QSortBy> {
  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByNoteContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteContent', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByNoteContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteContent', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByNoteNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteNumber', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByNoteNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteNumber', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByStatusWhenNoted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusWhenNoted', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByStatusWhenNotedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusWhenNoted', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTimeOfNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOfNote', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTimeOfNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOfNote', Sort.desc);
    });
  }
}

extension BookNotesQuerySortThenBy
    on QueryBuilder<BookNotes, BookNotes, QSortThenBy> {
  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByNoteContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteContent', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByNoteContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteContent', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByNoteNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteNumber', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByNoteNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteNumber', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByStatusWhenNoted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusWhenNoted', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByStatusWhenNotedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusWhenNoted', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTimeOfNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOfNote', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTimeOfNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeOfNote', Sort.desc);
    });
  }
}

extension BookNotesQueryWhereDistinct
    on QueryBuilder<BookNotes, BookNotes, QDistinct> {
  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByNoteContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteContent', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByNoteNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteNumber');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByStatusWhenNoted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusWhenNoted');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByTimeOfNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeOfNote');
    });
  }
}

extension BookNotesQueryProperty
    on QueryBuilder<BookNotes, BookNotes, QQueryProperty> {
  QueryBuilder<BookNotes, int, QQueryOperations> noteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteId');
    });
  }

  QueryBuilder<BookNotes, String, QQueryOperations> noteContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteContent');
    });
  }

  QueryBuilder<BookNotes, int, QQueryOperations> noteNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteNumber');
    });
  }

  QueryBuilder<BookNotes, BookStatus, QQueryOperations>
      statusWhenNotedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusWhenNoted');
    });
  }

  QueryBuilder<BookNotes, DateTime, QQueryOperations> timeOfNoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeOfNote');
    });
  }
}
