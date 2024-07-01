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
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 3,
      name: r'rating',
      type: IsarType.long,
    ),
    r'summary': PropertySchema(
      id: 4,
      name: r'summary',
      type: IsarType.string,
    ),
    r'timeEnded': PropertySchema(
      id: 5,
      name: r'timeEnded',
      type: IsarType.dateTime,
    ),
    r'topThreeQuotes': PropertySchema(
      id: 6,
      name: r'topThreeQuotes',
      type: IsarType.string,
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
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.topThreeQuotes.length * 3;
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
  writer.writeString(offsets[2], object.inThreeSentences);
  writer.writeLong(offsets[3], object.rating);
  writer.writeString(offsets[4], object.summary);
  writer.writeDateTime(offsets[5], object.timeEnded);
  writer.writeString(offsets[6], object.topThreeQuotes);
  writer.writeString(offsets[7], object.whoShouldRead);
}

FinishedBookNote _finishedBookNoteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FinishedBookNote(
    howChangedMe: reader.readString(offsets[0]),
    impressions: reader.readString(offsets[1]),
    inThreeSentences: reader.readString(offsets[2]),
    noteId: id,
    rating: reader.readLong(offsets[3]),
    summary: reader.readString(offsets[4]),
    timeEnded: reader.readDateTime(offsets[5]),
    topThreeQuotes: reader.readString(offsets[6]),
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _finishedBookNoteGetId(FinishedBookNote object) {
  return object.noteId;
}

List<IsarLinkBase<dynamic>> _finishedBookNoteGetLinks(FinishedBookNote object) {
  return [object.bookReference];
}

void _finishedBookNoteAttach(
    IsarCollection<dynamic> col, Id id, FinishedBookNote object) {
  object.noteId = id;
  object.bookReference
      .attach(col, col.isar.collection<Book>(), r'bookReference', id);
}

extension FinishedBookNoteQueryWhereSort
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QWhere> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhere> anyNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FinishedBookNoteQueryWhere
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QWhereClause> {
  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      noteIdEqualTo(Id noteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: noteId,
        upper: noteId,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      noteIdNotEqualTo(Id noteId) {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      noteIdGreaterThan(Id noteId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: noteId, includeLower: include),
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      noteIdLessThan(Id noteId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: noteId, includeUpper: include),
      );
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterWhereClause>
      noteIdBetween(
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

extension FinishedBookNoteQueryFilter
    on QueryBuilder<FinishedBookNote, FinishedBookNote, QFilterCondition> {
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
      inThreeSentencesEqualTo(
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
      inThreeSentencesGreaterThan(
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
      inThreeSentencesLessThan(
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
      inThreeSentencesBetween(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inThreeSentences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inThreeSentences',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inThreeSentences',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      inThreeSentencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inThreeSentences',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      noteIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteId',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      noteIdGreaterThan(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      noteIdLessThan(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      noteIdBetween(
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
      summaryEqualTo(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryGreaterThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryLessThan(
    String value, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryBetween(
    String lower,
    String upper, {
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryStartsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryEndsWith(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
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
      topThreeQuotesEqualTo(
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
      topThreeQuotesGreaterThan(
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
      topThreeQuotesLessThan(
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
      topThreeQuotesBetween(
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
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

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topThreeQuotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topThreeQuotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topThreeQuotes',
        value: '',
      ));
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      topThreeQuotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topThreeQuotes',
        value: '',
      ));
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
      bookReference(FilterQuery<Book> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'bookReference');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterFilterCondition>
      bookReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'bookReference', 0, true, 0, true);
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
      sortByInThreeSentences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByInThreeSentencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.desc);
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
      sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
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
      sortByTopThreeQuotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      sortByTopThreeQuotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.desc);
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
      thenByInThreeSentences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByInThreeSentencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inThreeSentences', Sort.desc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteId', Sort.desc);
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
      thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
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
      thenByTopThreeQuotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.asc);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QAfterSortBy>
      thenByTopThreeQuotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topThreeQuotes', Sort.desc);
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
      distinctByInThreeSentences({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inThreeSentences',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct> distinctBySummary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByTimeEnded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeEnded');
    });
  }

  QueryBuilder<FinishedBookNote, FinishedBookNote, QDistinct>
      distinctByTopThreeQuotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topThreeQuotes',
          caseSensitive: caseSensitive);
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
  QueryBuilder<FinishedBookNote, int, QQueryOperations> noteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteId');
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

  QueryBuilder<FinishedBookNote, String, QQueryOperations>
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

  QueryBuilder<FinishedBookNote, String, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<FinishedBookNote, DateTime, QQueryOperations>
      timeEndedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeEnded');
    });
  }

  QueryBuilder<FinishedBookNote, String, QQueryOperations>
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
