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
    r'asAudioBook': PropertySchema(
      id: 0,
      name: r'asAudioBook',
      type: IsarType.bool,
    ),
    r'howChangedMe': PropertySchema(
      id: 1,
      name: r'howChangedMe',
      type: IsarType.string,
    ),
    r'impressions': PropertySchema(
      id: 2,
      name: r'impressions',
      type: IsarType.string,
    ),
    r'inThreeSentences': PropertySchema(
      id: 3,
      name: r'inThreeSentences',
      type: IsarType.string,
    ),
    r'isReadingNow': PropertySchema(
      id: 4,
      name: r'isReadingNow',
      type: IsarType.bool,
    ),
    r'rating': PropertySchema(
      id: 5,
      name: r'rating',
      type: IsarType.long,
    ),
    r'summary': PropertySchema(
      id: 6,
      name: r'summary',
      type: IsarType.string,
    ),
    r'timeEnded': PropertySchema(
      id: 7,
      name: r'timeEnded',
      type: IsarType.dateTime,
    ),
    r'timeStarted': PropertySchema(
      id: 8,
      name: r'timeStarted',
      type: IsarType.dateTime,
    ),
    r'topThreeQuotes': PropertySchema(
      id: 9,
      name: r'topThreeQuotes',
      type: IsarType.string,
    ),
    r'whoShouldRead': PropertySchema(
      id: 10,
      name: r'whoShouldRead',
      type: IsarType.string,
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
      id: 3280464850837827532,
      name: r'bookReference',
      target: r'Book',
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
  {
    final value = object.howChangedMe;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.impressions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.inThreeSentences;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.summary;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.topThreeQuotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.whoShouldRead;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _bookNotesSerialize(
  BookNotes object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.asAudioBook);
  writer.writeString(offsets[1], object.howChangedMe);
  writer.writeString(offsets[2], object.impressions);
  writer.writeString(offsets[3], object.inThreeSentences);
  writer.writeBool(offsets[4], object.isReadingNow);
  writer.writeLong(offsets[5], object.rating);
  writer.writeString(offsets[6], object.summary);
  writer.writeDateTime(offsets[7], object.timeEnded);
  writer.writeDateTime(offsets[8], object.timeStarted);
  writer.writeString(offsets[9], object.topThreeQuotes);
  writer.writeString(offsets[10], object.whoShouldRead);
}

BookNotes _bookNotesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookNotes();
  object.asAudioBook = reader.readBoolOrNull(offsets[0]);
  object.howChangedMe = reader.readStringOrNull(offsets[1]);
  object.impressions = reader.readStringOrNull(offsets[2]);
  object.inThreeSentences = reader.readStringOrNull(offsets[3]);
  object.isReadingNow = reader.readBoolOrNull(offsets[4]);
  object.noteId = id;
  object.rating = reader.readLongOrNull(offsets[5]);
  object.summary = reader.readStringOrNull(offsets[6]);
  object.timeEnded = reader.readDateTimeOrNull(offsets[7]);
  object.timeStarted = reader.readDateTimeOrNull(offsets[8]);
  object.topThreeQuotes = reader.readStringOrNull(offsets[9]);
  object.whoShouldRead = reader.readStringOrNull(offsets[10]);
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
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookNotesGetId(BookNotes object) {
  return object.noteId;
}

List<IsarLinkBase<dynamic>> _bookNotesGetLinks(BookNotes object) {
  return [object.bookReference];
}

void _bookNotesAttach(IsarCollection<dynamic> col, Id id, BookNotes object) {
  object.noteId = id;
  object.bookReference
      .attach(col, col.isar.collection<Book>(), r'bookReference', id);
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
  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      asAudioBookIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'asAudioBook',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      asAudioBookIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'asAudioBook',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> asAudioBookEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'asAudioBook',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'howChangedMe',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'howChangedMe',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> howChangedMeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> howChangedMeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'howChangedMe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> howChangedMeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'howChangedMe',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'howChangedMe',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      howChangedMeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'howChangedMe',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      impressionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'impressions',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      impressionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'impressions',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> impressionsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      impressionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> impressionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> impressionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'impressions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      impressionsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> impressionsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> impressionsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> impressionsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'impressions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      impressionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'impressions',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      impressionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'impressions',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inThreeSentences',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inThreeSentences',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inThreeSentences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inThreeSentences',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inThreeSentences',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      inThreeSentencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inThreeSentences',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      isReadingNowIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isReadingNow',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      isReadingNowIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isReadingNow',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> isReadingNowEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReadingNow',
        value: value,
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

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> ratingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> ratingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rating',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> ratingEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> ratingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> ratingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> ratingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'summary',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'summary',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeEndedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeEnded',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      timeEndedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeEnded',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeEndedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeEnded',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      timeEndedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeEnded',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeEndedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeEnded',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeEndedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeEnded',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      timeStartedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeStarted',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      timeStartedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeStarted',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeStartedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStarted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      timeStartedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeStarted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeStartedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeStarted',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> timeStartedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeStarted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topThreeQuotes',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topThreeQuotes',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topThreeQuotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topThreeQuotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topThreeQuotes',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      topThreeQuotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topThreeQuotes',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whoShouldRead',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whoShouldRead',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'whoShouldRead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whoShouldRead',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whoShouldRead',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition>
      whoShouldReadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whoShouldRead',
        value: '',
      ));
    });
  }
}

extension BookNotesQueryObject
    on QueryBuilder<BookNotes, BookNotes, QFilterCondition> {}

extension BookNotesQueryLinks
    on QueryBuilder<BookNotes, BookNotes, QFilterCondition> {
  QueryBuilder<BookNotes, BookNotes, QAfterFilterCondition> bookReference(
      FilterQuery<Book> q) {
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
  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByAsAudioBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asAudioBook', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByAsAudioBookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asAudioBook', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByHowChangedMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByHowChangedMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByImpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByImpressionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByInThreeSentences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy>
      sortByInThreeSentencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByIsReadingNow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReadingNow', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByIsReadingNowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReadingNow', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTimeEndedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTimeStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStarted', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTimeStartedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStarted', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTopThreeQuotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByTopThreeQuotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByWhoShouldRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> sortByWhoShouldReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.desc);
    });
  }
}

extension BookNotesQuerySortThenBy
    on QueryBuilder<BookNotes, BookNotes, QSortThenBy> {
  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByAsAudioBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asAudioBook', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByAsAudioBookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asAudioBook', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByHowChangedMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByHowChangedMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByImpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByImpressionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByInThreeSentences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy>
      thenByInThreeSentencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByIsReadingNow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReadingNow', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByIsReadingNowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReadingNow', Sort.desc);
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

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTimeEndedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTimeStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStarted', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTimeStartedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStarted', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTopThreeQuotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByTopThreeQuotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.desc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByWhoShouldRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.asc);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QAfterSortBy> thenByWhoShouldReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.desc);
    });
  }
}

extension BookNotesQueryWhereDistinct
    on QueryBuilder<BookNotes, BookNotes, QDistinct> {
  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByAsAudioBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'asAudioBook');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByHowChangedMe(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'howChangedMe', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByImpressions(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'impressions', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByInThreeSentences(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inThreeSentences',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByIsReadingNow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReadingNow');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctBySummary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeEnded');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByTimeStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeStarted');
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByTopThreeQuotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topThreeQuotes',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNotes, BookNotes, QDistinct> distinctByWhoShouldRead(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whoShouldRead',
          caseSensitive: caseSensitive);
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

  QueryBuilder<BookNotes, bool?, QQueryOperations> asAudioBookProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'asAudioBook');
    });
  }

  QueryBuilder<BookNotes, String?, QQueryOperations> howChangedMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'howChangedMe');
    });
  }

  QueryBuilder<BookNotes, String?, QQueryOperations> impressionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'impressions');
    });
  }

  QueryBuilder<BookNotes, String?, QQueryOperations>
      inThreeSentencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inThreeSentences');
    });
  }

  QueryBuilder<BookNotes, bool?, QQueryOperations> isReadingNowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReadingNow');
    });
  }

  QueryBuilder<BookNotes, int?, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<BookNotes, String?, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<BookNotes, DateTime?, QQueryOperations> timeEndedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeEnded');
    });
  }

  QueryBuilder<BookNotes, DateTime?, QQueryOperations> timeStartedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeStarted');
    });
  }

  QueryBuilder<BookNotes, String?, QQueryOperations> topThreeQuotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topThreeQuotes');
    });
  }

  QueryBuilder<BookNotes, String?, QQueryOperations> whoShouldReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whoShouldRead');
    });
  }
}
