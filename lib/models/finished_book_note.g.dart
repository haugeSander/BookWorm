// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finished_book_note.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFinishedBookNoteCollection on Isar {
  IsarCollection<FinishedBookNote> get finishedBookNotes => this.collection();
}

const FinishedBookNoteSchema = CollectionSchema(
  name: r'FinishedBookNote',
  id: 6833937414210839562,
  properties: {
    r'howChangedMe': PropertySchema(
      id: 0,
      name: r'howChangedMe',
      type: IsarType.string,
    ),
    r'impressions': PropertySchema(
      id: 1,
      name: r'impressions',
      type: IsarType.string,
    ),
    r'inThreeSentences': PropertySchema(
      id: 2,
      name: r'inThreeSentences',
      type: IsarType.stringList,
    ),
    r'rating': PropertySchema(
      id: 3,
      name: r'rating',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(
      id: 4,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'timeEnded': PropertySchema(
      id: 5,
      name: r'timeEnded',
      type: IsarType.dateTime,
    ),
    r'topThreeQuotes': PropertySchema(
      id: 6,
      name: r'topThreeQuotes',
      type: IsarType.stringList,
    ),
    r'whoShouldRead': PropertySchema(
      id: 7,
      name: r'whoShouldRead',
      type: IsarType.string,
    )
  },
  estimateSize: _finishedBookNoteEstimateSize,
  serialize: _finishedBookNoteSerialize,
  deserialize: _finishedBookNoteDeserialize,
  deserializeProp: _finishedBookNoteDeserializeProp,
  idName: r'bookId',
  indexes: {},
  links: {
    r'bookDataReference': LinkSchema(
      id: -1403008970436645318,
      name: r'bookDataReference',
      target: r'UserBookEntry',
      single: true,
      linkName: r'finishedNote',
    )
  },
  embeddedSchemas: {},
  getId: _finishedBookNoteGetId,
  getLinks: _finishedBookNoteGetLinks,
  attach: _finishedBookNoteAttach,
  version: '3.1.0+1',
);

int _finishedBookNoteEstimateSize(
  FinishedBookNote object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.howChangedMe.length * 3;
  bytesCount += 3 + object.impressions.length * 3;
  bytesCount += 3 + object.inThreeSentences.length * 3;
  {
    for (var i = 0; i < object.inThreeSentences.length; i++) {
      final value = object.inThreeSentences[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final list = object.tags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.topThreeQuotes.length * 3;
  {
    for (var i = 0; i < object.topThreeQuotes.length; i++) {
      final value = object.topThreeQuotes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.whoShouldRead.length * 3;
  return bytesCount;
}

void _finishedBookNoteSerialize(
  FinishedBookNote object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.howChangedMe);
  writer.writeString(offsets[1], object.impressions);
  writer.writeStringList(offsets[2], object.inThreeSentences);
  writer.writeLong(offsets[3], object.rating);
  writer.writeStringList(offsets[4], object.tags);
  writer.writeDateTime(offsets[5], object.timeEnded);
  writer.writeStringList(offsets[6], object.topThreeQuotes);
  writer.writeString(offsets[7], object.whoShouldRead);
}

FinishedBookNote _finishedBookNoteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FinishedBookNote(
    bookId: id,
    howChangedMe: reader.readString(offsets[0]),
    impressions: reader.readString(offsets[1]),
    inThreeSentences: reader.readStringList(offsets[2]) ?? [],
    rating: reader.readLong(offsets[3]),
    tags: reader.readStringList(offsets[4]),
    timeEnded: reader.readDateTime(offsets[5]),
    topThreeQuotes: reader.readStringList(offsets[6]) ?? [],
    whoShouldRead: reader.readString(offsets[7]),
  );
  return object;
}

P _finishedBookNoteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringList(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _finishedBookNoteGetId(FinishedBookNote object) {
  return object.bookId;
}

List<IsarLinkBase<dynamic>> _finishedBookNoteGetLinks(FinishedBookNote object) {
  return [object.bookDataReference];
}

void _finishedBookNoteAttach(
    IsarCollection<dynamic> col, Id id, FinishedBookNote object) {
  object.bookId = id;
  object.bookDataReference.attach(
      col, col.isar.collection<UserBookEntry>(), r'bookDataReference', id);
}

extension FinishedBookNoteQueryWhereSort
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QWhere> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhere> anyBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FinishedBookNoteQueryWhere
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QWhereClause> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      bookIdEqualTo(Id bookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: bookId,
        upper: bookId,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      bookIdNotEqualTo(Id bookId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: bookId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: bookId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: bookId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: bookId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      bookIdGreaterThan(Id bookId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: bookId, includeLower: include),
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      bookIdLessThan(Id bookId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: bookId, includeUpper: include),
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      bookIdBetween(
    Id lowerBookId,
    Id upperBookId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerBookId,
        includeLower: includeLower,
        upper: upperBookId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FinishedBookNoteQueryFilter
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QFilterCondition> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeEqualTo(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeGreaterThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeLessThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'howChangedMe',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'howChangedMe',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'howChangedMe',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      howChangedMeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'howChangedMe',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsEqualTo(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsGreaterThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsLessThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsEndsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'impressions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'impressions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'impressions',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      impressionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'impressions',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementEqualTo(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementGreaterThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementLessThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementStartsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementEndsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inThreeSentences',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inThreeSentences',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inThreeSentences',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inThreeSentences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inThreeSentences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inThreeSentences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inThreeSentences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inThreeSentences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inThreeSentences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      ratingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      ratingGreaterThan(
    int value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      ratingLessThan(
    int value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      ratingBetween(
    int lower,
    int upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      timeEndedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeEnded',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      timeEndedGreaterThan(
    DateTime value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      timeEndedLessThan(
    DateTime value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      timeEndedBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementEqualTo(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementGreaterThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementLessThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementStartsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementEndsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topThreeQuotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topThreeQuotes',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topThreeQuotes',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topThreeQuotes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topThreeQuotes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topThreeQuotes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topThreeQuotes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topThreeQuotes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topThreeQuotes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadEqualTo(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadGreaterThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadLessThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whoShouldRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whoShouldRead',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whoShouldRead',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      whoShouldReadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whoShouldRead',
        value: '',
      ));
    });
  }
}

extension FinishedBookNoteQueryObject
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QFilterCondition> {}

extension FinishedBookNoteQueryLinks
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QFilterCondition> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookDataReference(FilterQuery<UserBookEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bookDataReference');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookDataReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookDataReference', 0, true, 0, true);
    });
  }
}

extension FinishedBookNoteQuerySortBy
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QSortBy> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByHowChangedMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByHowChangedMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByImpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByImpressionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByTimeEndedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByWhoShouldRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByWhoShouldReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.desc);
    });
  }
}

extension FinishedBookNoteQuerySortThenBy
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QSortThenBy> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByHowChangedMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByHowChangedMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'howChangedMe', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByImpressions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByImpressionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'impressions', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByTimeEndedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeEnded', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByWhoShouldRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByWhoShouldReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoShouldRead', Sort.desc);
    });
  }
}

extension FinishedBookNoteQueryWhereDistinct
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByHowChangedMe({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'howChangedMe', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByImpressions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'impressions', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByInThreeSentences() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inThreeSentences');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeEnded');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByTopThreeQuotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topThreeQuotes');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByWhoShouldRead({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whoShouldRead',
          caseSensitive: caseSensitive);
    });
  }
}

extension FinishedBookNoteQueryProperty
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QQueryProperty> {
  QueryBuilder<FinishedBookNote, int, QQueryOperations> bookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookId');
    });
  }

  QueryBuilder<FinishedBookNote, String, QQueryOperations>
      howChangedMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'howChangedMe');
    });
  }

  QueryBuilder<FinishedBookNote, String, QQueryOperations>
      impressionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'impressions');
    });
  }

  QueryBuilder<FinishedBookNote, List<String>, QQueryOperations>
      inThreeSentencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inThreeSentences');
    });
  }

  QueryBuilder<FinishedBookNote, int, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<FinishedBookNote, List<String>?, QQueryOperations>
      tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<FinishedBookNote, DateTime, QQueryOperations>
      timeEndedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeEnded');
    });
  }

  QueryBuilder<FinishedBookNote, List<String>, QQueryOperations>
      topThreeQuotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topThreeQuotes');
    });
  }

  QueryBuilder<FinishedBookNote, String, QQueryOperations>
      whoShouldReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whoShouldRead');
    });
  }
}
