// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverImageMeta =
      const VerificationMeta('coverImage');
  @override
  late final GeneratedColumn<String> coverImage = GeneratedColumn<String>(
      'cover_image', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
      'isbn', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateAddedMeta =
      const VerificationMeta('dateAdded');
  @override
  late final GeneratedColumn<int> dateAdded = GeneratedColumn<int>(
      'date_added', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateStartedMeta =
      const VerificationMeta('dateStarted');
  @override
  late final GeneratedColumn<int> dateStarted = GeneratedColumn<int>(
      'date_started', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dateFinishedMeta =
      const VerificationMeta('dateFinished');
  @override
  late final GeneratedColumn<int> dateFinished = GeneratedColumn<int>(
      'date_finished', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pageCountMeta =
      const VerificationMeta('pageCount');
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
      'page_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _publisherMeta =
      const VerificationMeta('publisher');
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
      'publisher', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedYearMeta =
      const VerificationMeta('publishedYear');
  @override
  late final GeneratedColumn<String> publishedYear = GeneratedColumn<String>(
      'published_year', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _coverUrlMeta =
      const VerificationMeta('coverUrl');
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
      'cover_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isNonFictionMeta =
      const VerificationMeta('isNonFiction');
  @override
  late final GeneratedColumn<bool> isNonFiction = GeneratedColumn<bool>(
      'is_non_fiction', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_non_fiction" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _inThreeSentencesMeta =
      const VerificationMeta('inThreeSentences');
  @override
  late final GeneratedColumn<String> inThreeSentences = GeneratedColumn<String>(
      'in_three_sentences', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _impressionsMeta =
      const VerificationMeta('impressions');
  @override
  late final GeneratedColumn<String> impressions = GeneratedColumn<String>(
      'impressions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _whoShouldReadMeta =
      const VerificationMeta('whoShouldRead');
  @override
  late final GeneratedColumn<String> whoShouldRead = GeneratedColumn<String>(
      'who_should_read', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _howChangedMeMeta =
      const VerificationMeta('howChangedMe');
  @override
  late final GeneratedColumn<String> howChangedMe = GeneratedColumn<String>(
      'how_changed_me', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _topThreeQuotesMeta =
      const VerificationMeta('topThreeQuotes');
  @override
  late final GeneratedColumn<String> topThreeQuotes = GeneratedColumn<String>(
      'top_three_quotes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        author,
        coverImage,
        isbn,
        status,
        dateAdded,
        dateStarted,
        dateFinished,
        rating,
        note,
        description,
        pageCount,
        publisher,
        publishedYear,
        coverUrl,
        isNonFiction,
        genre,
        inThreeSentences,
        impressions,
        whoShouldRead,
        howChangedMe,
        topThreeQuotes,
        tags
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(Insertable<Book> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('cover_image')) {
      context.handle(
          _coverImageMeta,
          coverImage.isAcceptableOrUnknown(
              data['cover_image']!, _coverImageMeta));
    }
    if (data.containsKey('isbn')) {
      context.handle(
          _isbnMeta, isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('date_added')) {
      context.handle(_dateAddedMeta,
          dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta));
    } else if (isInserting) {
      context.missing(_dateAddedMeta);
    }
    if (data.containsKey('date_started')) {
      context.handle(
          _dateStartedMeta,
          dateStarted.isAcceptableOrUnknown(
              data['date_started']!, _dateStartedMeta));
    }
    if (data.containsKey('date_finished')) {
      context.handle(
          _dateFinishedMeta,
          dateFinished.isAcceptableOrUnknown(
              data['date_finished']!, _dateFinishedMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('page_count')) {
      context.handle(_pageCountMeta,
          pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta));
    }
    if (data.containsKey('publisher')) {
      context.handle(_publisherMeta,
          publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta));
    }
    if (data.containsKey('published_year')) {
      context.handle(
          _publishedYearMeta,
          publishedYear.isAcceptableOrUnknown(
              data['published_year']!, _publishedYearMeta));
    }
    if (data.containsKey('cover_url')) {
      context.handle(_coverUrlMeta,
          coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta));
    }
    if (data.containsKey('is_non_fiction')) {
      context.handle(
          _isNonFictionMeta,
          isNonFiction.isAcceptableOrUnknown(
              data['is_non_fiction']!, _isNonFictionMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    if (data.containsKey('in_three_sentences')) {
      context.handle(
          _inThreeSentencesMeta,
          inThreeSentences.isAcceptableOrUnknown(
              data['in_three_sentences']!, _inThreeSentencesMeta));
    }
    if (data.containsKey('impressions')) {
      context.handle(
          _impressionsMeta,
          impressions.isAcceptableOrUnknown(
              data['impressions']!, _impressionsMeta));
    }
    if (data.containsKey('who_should_read')) {
      context.handle(
          _whoShouldReadMeta,
          whoShouldRead.isAcceptableOrUnknown(
              data['who_should_read']!, _whoShouldReadMeta));
    }
    if (data.containsKey('how_changed_me')) {
      context.handle(
          _howChangedMeMeta,
          howChangedMe.isAcceptableOrUnknown(
              data['how_changed_me']!, _howChangedMeMeta));
    }
    if (data.containsKey('top_three_quotes')) {
      context.handle(
          _topThreeQuotesMeta,
          topThreeQuotes.isAcceptableOrUnknown(
              data['top_three_quotes']!, _topThreeQuotesMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      coverImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_image'])!,
      isbn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isbn']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      dateAdded: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_added'])!,
      dateStarted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_started']),
      dateFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_finished']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      pageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_count']),
      publisher: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}publisher']),
      publishedYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}published_year']),
      coverUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_url']),
      isNonFiction: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_non_fiction'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre']),
      inThreeSentences: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}in_three_sentences']),
      impressions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}impressions']),
      whoShouldRead: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}who_should_read']),
      howChangedMe: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}how_changed_me']),
      topThreeQuotes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}top_three_quotes']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final int id;
  final String title;
  final String author;
  final String coverImage;
  final String? isbn;
  final String status;
  final int dateAdded;
  final int? dateStarted;
  final int? dateFinished;
  final int? rating;
  final String? note;
  final String? description;
  final int? pageCount;
  final String? publisher;
  final String? publishedYear;
  final String? coverUrl;
  final bool isNonFiction;
  final String? genre;
  final String? inThreeSentences;
  final String? impressions;
  final String? whoShouldRead;
  final String? howChangedMe;
  final String? topThreeQuotes;
  final String? tags;
  const Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.coverImage,
      this.isbn,
      required this.status,
      required this.dateAdded,
      this.dateStarted,
      this.dateFinished,
      this.rating,
      this.note,
      this.description,
      this.pageCount,
      this.publisher,
      this.publishedYear,
      this.coverUrl,
      required this.isNonFiction,
      this.genre,
      this.inThreeSentences,
      this.impressions,
      this.whoShouldRead,
      this.howChangedMe,
      this.topThreeQuotes,
      this.tags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['cover_image'] = Variable<String>(coverImage);
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    map['status'] = Variable<String>(status);
    map['date_added'] = Variable<int>(dateAdded);
    if (!nullToAbsent || dateStarted != null) {
      map['date_started'] = Variable<int>(dateStarted);
    }
    if (!nullToAbsent || dateFinished != null) {
      map['date_finished'] = Variable<int>(dateFinished);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || publishedYear != null) {
      map['published_year'] = Variable<String>(publishedYear);
    }
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    map['is_non_fiction'] = Variable<bool>(isNonFiction);
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    if (!nullToAbsent || inThreeSentences != null) {
      map['in_three_sentences'] = Variable<String>(inThreeSentences);
    }
    if (!nullToAbsent || impressions != null) {
      map['impressions'] = Variable<String>(impressions);
    }
    if (!nullToAbsent || whoShouldRead != null) {
      map['who_should_read'] = Variable<String>(whoShouldRead);
    }
    if (!nullToAbsent || howChangedMe != null) {
      map['how_changed_me'] = Variable<String>(howChangedMe);
    }
    if (!nullToAbsent || topThreeQuotes != null) {
      map['top_three_quotes'] = Variable<String>(topThreeQuotes);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      coverImage: Value(coverImage),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      status: Value(status),
      dateAdded: Value(dateAdded),
      dateStarted: dateStarted == null && nullToAbsent
          ? const Value.absent()
          : Value(dateStarted),
      dateFinished: dateFinished == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFinished),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      publishedYear: publishedYear == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedYear),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      isNonFiction: Value(isNonFiction),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
      inThreeSentences: inThreeSentences == null && nullToAbsent
          ? const Value.absent()
          : Value(inThreeSentences),
      impressions: impressions == null && nullToAbsent
          ? const Value.absent()
          : Value(impressions),
      whoShouldRead: whoShouldRead == null && nullToAbsent
          ? const Value.absent()
          : Value(whoShouldRead),
      howChangedMe: howChangedMe == null && nullToAbsent
          ? const Value.absent()
          : Value(howChangedMe),
      topThreeQuotes: topThreeQuotes == null && nullToAbsent
          ? const Value.absent()
          : Value(topThreeQuotes),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      coverImage: serializer.fromJson<String>(json['coverImage']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      status: serializer.fromJson<String>(json['status']),
      dateAdded: serializer.fromJson<int>(json['dateAdded']),
      dateStarted: serializer.fromJson<int?>(json['dateStarted']),
      dateFinished: serializer.fromJson<int?>(json['dateFinished']),
      rating: serializer.fromJson<int?>(json['rating']),
      note: serializer.fromJson<String?>(json['note']),
      description: serializer.fromJson<String?>(json['description']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      publishedYear: serializer.fromJson<String?>(json['publishedYear']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      isNonFiction: serializer.fromJson<bool>(json['isNonFiction']),
      genre: serializer.fromJson<String?>(json['genre']),
      inThreeSentences: serializer.fromJson<String?>(json['inThreeSentences']),
      impressions: serializer.fromJson<String?>(json['impressions']),
      whoShouldRead: serializer.fromJson<String?>(json['whoShouldRead']),
      howChangedMe: serializer.fromJson<String?>(json['howChangedMe']),
      topThreeQuotes: serializer.fromJson<String?>(json['topThreeQuotes']),
      tags: serializer.fromJson<String?>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'coverImage': serializer.toJson<String>(coverImage),
      'isbn': serializer.toJson<String?>(isbn),
      'status': serializer.toJson<String>(status),
      'dateAdded': serializer.toJson<int>(dateAdded),
      'dateStarted': serializer.toJson<int?>(dateStarted),
      'dateFinished': serializer.toJson<int?>(dateFinished),
      'rating': serializer.toJson<int?>(rating),
      'note': serializer.toJson<String?>(note),
      'description': serializer.toJson<String?>(description),
      'pageCount': serializer.toJson<int?>(pageCount),
      'publisher': serializer.toJson<String?>(publisher),
      'publishedYear': serializer.toJson<String?>(publishedYear),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'isNonFiction': serializer.toJson<bool>(isNonFiction),
      'genre': serializer.toJson<String?>(genre),
      'inThreeSentences': serializer.toJson<String?>(inThreeSentences),
      'impressions': serializer.toJson<String?>(impressions),
      'whoShouldRead': serializer.toJson<String?>(whoShouldRead),
      'howChangedMe': serializer.toJson<String?>(howChangedMe),
      'topThreeQuotes': serializer.toJson<String?>(topThreeQuotes),
      'tags': serializer.toJson<String?>(tags),
    };
  }

  Book copyWith(
          {int? id,
          String? title,
          String? author,
          String? coverImage,
          Value<String?> isbn = const Value.absent(),
          String? status,
          int? dateAdded,
          Value<int?> dateStarted = const Value.absent(),
          Value<int?> dateFinished = const Value.absent(),
          Value<int?> rating = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<int?> pageCount = const Value.absent(),
          Value<String?> publisher = const Value.absent(),
          Value<String?> publishedYear = const Value.absent(),
          Value<String?> coverUrl = const Value.absent(),
          bool? isNonFiction,
          Value<String?> genre = const Value.absent(),
          Value<String?> inThreeSentences = const Value.absent(),
          Value<String?> impressions = const Value.absent(),
          Value<String?> whoShouldRead = const Value.absent(),
          Value<String?> howChangedMe = const Value.absent(),
          Value<String?> topThreeQuotes = const Value.absent(),
          Value<String?> tags = const Value.absent()}) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverImage: coverImage ?? this.coverImage,
        isbn: isbn.present ? isbn.value : this.isbn,
        status: status ?? this.status,
        dateAdded: dateAdded ?? this.dateAdded,
        dateStarted: dateStarted.present ? dateStarted.value : this.dateStarted,
        dateFinished:
            dateFinished.present ? dateFinished.value : this.dateFinished,
        rating: rating.present ? rating.value : this.rating,
        note: note.present ? note.value : this.note,
        description: description.present ? description.value : this.description,
        pageCount: pageCount.present ? pageCount.value : this.pageCount,
        publisher: publisher.present ? publisher.value : this.publisher,
        publishedYear:
            publishedYear.present ? publishedYear.value : this.publishedYear,
        coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
        isNonFiction: isNonFiction ?? this.isNonFiction,
        genre: genre.present ? genre.value : this.genre,
        inThreeSentences: inThreeSentences.present
            ? inThreeSentences.value
            : this.inThreeSentences,
        impressions: impressions.present ? impressions.value : this.impressions,
        whoShouldRead:
            whoShouldRead.present ? whoShouldRead.value : this.whoShouldRead,
        howChangedMe:
            howChangedMe.present ? howChangedMe.value : this.howChangedMe,
        topThreeQuotes:
            topThreeQuotes.present ? topThreeQuotes.value : this.topThreeQuotes,
        tags: tags.present ? tags.value : this.tags,
      );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      coverImage:
          data.coverImage.present ? data.coverImage.value : this.coverImage,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      status: data.status.present ? data.status.value : this.status,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
      dateStarted:
          data.dateStarted.present ? data.dateStarted.value : this.dateStarted,
      dateFinished: data.dateFinished.present
          ? data.dateFinished.value
          : this.dateFinished,
      rating: data.rating.present ? data.rating.value : this.rating,
      note: data.note.present ? data.note.value : this.note,
      description:
          data.description.present ? data.description.value : this.description,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      publishedYear: data.publishedYear.present
          ? data.publishedYear.value
          : this.publishedYear,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      isNonFiction: data.isNonFiction.present
          ? data.isNonFiction.value
          : this.isNonFiction,
      genre: data.genre.present ? data.genre.value : this.genre,
      inThreeSentences: data.inThreeSentences.present
          ? data.inThreeSentences.value
          : this.inThreeSentences,
      impressions:
          data.impressions.present ? data.impressions.value : this.impressions,
      whoShouldRead: data.whoShouldRead.present
          ? data.whoShouldRead.value
          : this.whoShouldRead,
      howChangedMe: data.howChangedMe.present
          ? data.howChangedMe.value
          : this.howChangedMe,
      topThreeQuotes: data.topThreeQuotes.present
          ? data.topThreeQuotes.value
          : this.topThreeQuotes,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('coverImage: $coverImage, ')
          ..write('isbn: $isbn, ')
          ..write('status: $status, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('dateStarted: $dateStarted, ')
          ..write('dateFinished: $dateFinished, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('description: $description, ')
          ..write('pageCount: $pageCount, ')
          ..write('publisher: $publisher, ')
          ..write('publishedYear: $publishedYear, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('isNonFiction: $isNonFiction, ')
          ..write('genre: $genre, ')
          ..write('inThreeSentences: $inThreeSentences, ')
          ..write('impressions: $impressions, ')
          ..write('whoShouldRead: $whoShouldRead, ')
          ..write('howChangedMe: $howChangedMe, ')
          ..write('topThreeQuotes: $topThreeQuotes, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        author,
        coverImage,
        isbn,
        status,
        dateAdded,
        dateStarted,
        dateFinished,
        rating,
        note,
        description,
        pageCount,
        publisher,
        publishedYear,
        coverUrl,
        isNonFiction,
        genre,
        inThreeSentences,
        impressions,
        whoShouldRead,
        howChangedMe,
        topThreeQuotes,
        tags
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.coverImage == this.coverImage &&
          other.isbn == this.isbn &&
          other.status == this.status &&
          other.dateAdded == this.dateAdded &&
          other.dateStarted == this.dateStarted &&
          other.dateFinished == this.dateFinished &&
          other.rating == this.rating &&
          other.note == this.note &&
          other.description == this.description &&
          other.pageCount == this.pageCount &&
          other.publisher == this.publisher &&
          other.publishedYear == this.publishedYear &&
          other.coverUrl == this.coverUrl &&
          other.isNonFiction == this.isNonFiction &&
          other.genre == this.genre &&
          other.inThreeSentences == this.inThreeSentences &&
          other.impressions == this.impressions &&
          other.whoShouldRead == this.whoShouldRead &&
          other.howChangedMe == this.howChangedMe &&
          other.topThreeQuotes == this.topThreeQuotes &&
          other.tags == this.tags);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> coverImage;
  final Value<String?> isbn;
  final Value<String> status;
  final Value<int> dateAdded;
  final Value<int?> dateStarted;
  final Value<int?> dateFinished;
  final Value<int?> rating;
  final Value<String?> note;
  final Value<String?> description;
  final Value<int?> pageCount;
  final Value<String?> publisher;
  final Value<String?> publishedYear;
  final Value<String?> coverUrl;
  final Value<bool> isNonFiction;
  final Value<String?> genre;
  final Value<String?> inThreeSentences;
  final Value<String?> impressions;
  final Value<String?> whoShouldRead;
  final Value<String?> howChangedMe;
  final Value<String?> topThreeQuotes;
  final Value<String?> tags;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.isbn = const Value.absent(),
    this.status = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.dateStarted = const Value.absent(),
    this.dateFinished = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    this.description = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedYear = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.isNonFiction = const Value.absent(),
    this.genre = const Value.absent(),
    this.inThreeSentences = const Value.absent(),
    this.impressions = const Value.absent(),
    this.whoShouldRead = const Value.absent(),
    this.howChangedMe = const Value.absent(),
    this.topThreeQuotes = const Value.absent(),
    this.tags = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String author,
    this.coverImage = const Value.absent(),
    this.isbn = const Value.absent(),
    required String status,
    required int dateAdded,
    this.dateStarted = const Value.absent(),
    this.dateFinished = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    this.description = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.publisher = const Value.absent(),
    this.publishedYear = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.isNonFiction = const Value.absent(),
    this.genre = const Value.absent(),
    this.inThreeSentences = const Value.absent(),
    this.impressions = const Value.absent(),
    this.whoShouldRead = const Value.absent(),
    this.howChangedMe = const Value.absent(),
    this.topThreeQuotes = const Value.absent(),
    this.tags = const Value.absent(),
  })  : title = Value(title),
        author = Value(author),
        status = Value(status),
        dateAdded = Value(dateAdded);
  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? coverImage,
    Expression<String>? isbn,
    Expression<String>? status,
    Expression<int>? dateAdded,
    Expression<int>? dateStarted,
    Expression<int>? dateFinished,
    Expression<int>? rating,
    Expression<String>? note,
    Expression<String>? description,
    Expression<int>? pageCount,
    Expression<String>? publisher,
    Expression<String>? publishedYear,
    Expression<String>? coverUrl,
    Expression<bool>? isNonFiction,
    Expression<String>? genre,
    Expression<String>? inThreeSentences,
    Expression<String>? impressions,
    Expression<String>? whoShouldRead,
    Expression<String>? howChangedMe,
    Expression<String>? topThreeQuotes,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (coverImage != null) 'cover_image': coverImage,
      if (isbn != null) 'isbn': isbn,
      if (status != null) 'status': status,
      if (dateAdded != null) 'date_added': dateAdded,
      if (dateStarted != null) 'date_started': dateStarted,
      if (dateFinished != null) 'date_finished': dateFinished,
      if (rating != null) 'rating': rating,
      if (note != null) 'note': note,
      if (description != null) 'description': description,
      if (pageCount != null) 'page_count': pageCount,
      if (publisher != null) 'publisher': publisher,
      if (publishedYear != null) 'published_year': publishedYear,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (isNonFiction != null) 'is_non_fiction': isNonFiction,
      if (genre != null) 'genre': genre,
      if (inThreeSentences != null) 'in_three_sentences': inThreeSentences,
      if (impressions != null) 'impressions': impressions,
      if (whoShouldRead != null) 'who_should_read': whoShouldRead,
      if (howChangedMe != null) 'how_changed_me': howChangedMe,
      if (topThreeQuotes != null) 'top_three_quotes': topThreeQuotes,
      if (tags != null) 'tags': tags,
    });
  }

  BooksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? author,
      Value<String>? coverImage,
      Value<String?>? isbn,
      Value<String>? status,
      Value<int>? dateAdded,
      Value<int?>? dateStarted,
      Value<int?>? dateFinished,
      Value<int?>? rating,
      Value<String?>? note,
      Value<String?>? description,
      Value<int?>? pageCount,
      Value<String?>? publisher,
      Value<String?>? publishedYear,
      Value<String?>? coverUrl,
      Value<bool>? isNonFiction,
      Value<String?>? genre,
      Value<String?>? inThreeSentences,
      Value<String?>? impressions,
      Value<String?>? whoShouldRead,
      Value<String?>? howChangedMe,
      Value<String?>? topThreeQuotes,
      Value<String?>? tags}) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImage: coverImage ?? this.coverImage,
      isbn: isbn ?? this.isbn,
      status: status ?? this.status,
      dateAdded: dateAdded ?? this.dateAdded,
      dateStarted: dateStarted ?? this.dateStarted,
      dateFinished: dateFinished ?? this.dateFinished,
      rating: rating ?? this.rating,
      note: note ?? this.note,
      description: description ?? this.description,
      pageCount: pageCount ?? this.pageCount,
      publisher: publisher ?? this.publisher,
      publishedYear: publishedYear ?? this.publishedYear,
      coverUrl: coverUrl ?? this.coverUrl,
      isNonFiction: isNonFiction ?? this.isNonFiction,
      genre: genre ?? this.genre,
      inThreeSentences: inThreeSentences ?? this.inThreeSentences,
      impressions: impressions ?? this.impressions,
      whoShouldRead: whoShouldRead ?? this.whoShouldRead,
      howChangedMe: howChangedMe ?? this.howChangedMe,
      topThreeQuotes: topThreeQuotes ?? this.topThreeQuotes,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (coverImage.present) {
      map['cover_image'] = Variable<String>(coverImage.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<int>(dateAdded.value);
    }
    if (dateStarted.present) {
      map['date_started'] = Variable<int>(dateStarted.value);
    }
    if (dateFinished.present) {
      map['date_finished'] = Variable<int>(dateFinished.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (publishedYear.present) {
      map['published_year'] = Variable<String>(publishedYear.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (isNonFiction.present) {
      map['is_non_fiction'] = Variable<bool>(isNonFiction.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (inThreeSentences.present) {
      map['in_three_sentences'] = Variable<String>(inThreeSentences.value);
    }
    if (impressions.present) {
      map['impressions'] = Variable<String>(impressions.value);
    }
    if (whoShouldRead.present) {
      map['who_should_read'] = Variable<String>(whoShouldRead.value);
    }
    if (howChangedMe.present) {
      map['how_changed_me'] = Variable<String>(howChangedMe.value);
    }
    if (topThreeQuotes.present) {
      map['top_three_quotes'] = Variable<String>(topThreeQuotes.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('coverImage: $coverImage, ')
          ..write('isbn: $isbn, ')
          ..write('status: $status, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('dateStarted: $dateStarted, ')
          ..write('dateFinished: $dateFinished, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('description: $description, ')
          ..write('pageCount: $pageCount, ')
          ..write('publisher: $publisher, ')
          ..write('publishedYear: $publishedYear, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('isNonFiction: $isNonFiction, ')
          ..write('genre: $genre, ')
          ..write('inThreeSentences: $inThreeSentences, ')
          ..write('impressions: $impressions, ')
          ..write('whoShouldRead: $whoShouldRead, ')
          ..write('howChangedMe: $howChangedMe, ')
          ..write('topThreeQuotes: $topThreeQuotes, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $BookWidgetsTable extends BookWidgets
    with TableInfo<$BookWidgetsTable, BookWidget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookWidgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES books (id) ON DELETE CASCADE'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, type, payloadJson, sortOrder, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_widgets';
  @override
  VerificationContext validateIntegrity(Insertable<BookWidget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookWidget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookWidget(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BookWidgetsTable createAlias(String alias) {
    return $BookWidgetsTable(attachedDatabase, alias);
  }
}

class BookWidget extends DataClass implements Insertable<BookWidget> {
  final int id;
  final int bookId;
  final String type;
  final String payloadJson;
  final int sortOrder;
  final int createdAt;
  final int updatedAt;
  const BookWidget(
      {required this.id,
      required this.bookId,
      required this.type,
      required this.payloadJson,
      required this.sortOrder,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['type'] = Variable<String>(type);
    map['payload_json'] = Variable<String>(payloadJson);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  BookWidgetsCompanion toCompanion(bool nullToAbsent) {
    return BookWidgetsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      type: Value(type),
      payloadJson: Value(payloadJson),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BookWidget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookWidget(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      type: serializer.fromJson<String>(json['type']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'type': serializer.toJson<String>(type),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  BookWidget copyWith(
          {int? id,
          int? bookId,
          String? type,
          String? payloadJson,
          int? sortOrder,
          int? createdAt,
          int? updatedAt}) =>
      BookWidget(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        type: type ?? this.type,
        payloadJson: payloadJson ?? this.payloadJson,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BookWidget copyWithCompanion(BookWidgetsCompanion data) {
    return BookWidget(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      type: data.type.present ? data.type.value : this.type,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookWidget(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('type: $type, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, bookId, type, payloadJson, sortOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookWidget &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.type == this.type &&
          other.payloadJson == this.payloadJson &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BookWidgetsCompanion extends UpdateCompanion<BookWidget> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<String> type;
  final Value<String> payloadJson;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const BookWidgetsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.type = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BookWidgetsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required String type,
    required String payloadJson,
    required int sortOrder,
    required int createdAt,
    required int updatedAt,
  })  : bookId = Value(bookId),
        type = Value(type),
        payloadJson = Value(payloadJson),
        sortOrder = Value(sortOrder),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<BookWidget> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<String>? type,
    Expression<String>? payloadJson,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (type != null) 'type': type,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BookWidgetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<String>? type,
      Value<String>? payloadJson,
      Value<int>? sortOrder,
      Value<int>? createdAt,
      Value<int>? updatedAt}) {
    return BookWidgetsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      type: type ?? this.type,
      payloadJson: payloadJson ?? this.payloadJson,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookWidgetsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('type: $type, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $BookWidgetsTable bookWidgets = $BookWidgetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [books, bookWidgets];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('books',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('book_widgets', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$BooksTableCreateCompanionBuilder = BooksCompanion Function({
  Value<int> id,
  required String title,
  required String author,
  Value<String> coverImage,
  Value<String?> isbn,
  required String status,
  required int dateAdded,
  Value<int?> dateStarted,
  Value<int?> dateFinished,
  Value<int?> rating,
  Value<String?> note,
  Value<String?> description,
  Value<int?> pageCount,
  Value<String?> publisher,
  Value<String?> publishedYear,
  Value<String?> coverUrl,
  Value<bool> isNonFiction,
  Value<String?> genre,
  Value<String?> inThreeSentences,
  Value<String?> impressions,
  Value<String?> whoShouldRead,
  Value<String?> howChangedMe,
  Value<String?> topThreeQuotes,
  Value<String?> tags,
});
typedef $$BooksTableUpdateCompanionBuilder = BooksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> author,
  Value<String> coverImage,
  Value<String?> isbn,
  Value<String> status,
  Value<int> dateAdded,
  Value<int?> dateStarted,
  Value<int?> dateFinished,
  Value<int?> rating,
  Value<String?> note,
  Value<String?> description,
  Value<int?> pageCount,
  Value<String?> publisher,
  Value<String?> publishedYear,
  Value<String?> coverUrl,
  Value<bool> isNonFiction,
  Value<String?> genre,
  Value<String?> inThreeSentences,
  Value<String?> impressions,
  Value<String?> whoShouldRead,
  Value<String?> howChangedMe,
  Value<String?> topThreeQuotes,
  Value<String?> tags,
});

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BookWidgetsTable, List<BookWidget>>
      _bookWidgetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.bookWidgets,
          aliasName: $_aliasNameGenerator(db.books.id, db.bookWidgets.bookId));

  $$BookWidgetsTableProcessedTableManager get bookWidgetsRefs {
    final manager = $$BookWidgetsTableTableManager($_db, $_db.bookWidgets)
        .filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookWidgetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverImage => $composableBuilder(
      column: $table.coverImage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isbn => $composableBuilder(
      column: $table.isbn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dateAdded => $composableBuilder(
      column: $table.dateAdded, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dateStarted => $composableBuilder(
      column: $table.dateStarted, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dateFinished => $composableBuilder(
      column: $table.dateFinished, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageCount => $composableBuilder(
      column: $table.pageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get publisher => $composableBuilder(
      column: $table.publisher, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get publishedYear => $composableBuilder(
      column: $table.publishedYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isNonFiction => $composableBuilder(
      column: $table.isNonFiction, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inThreeSentences => $composableBuilder(
      column: $table.inThreeSentences,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get impressions => $composableBuilder(
      column: $table.impressions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get whoShouldRead => $composableBuilder(
      column: $table.whoShouldRead, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get howChangedMe => $composableBuilder(
      column: $table.howChangedMe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topThreeQuotes => $composableBuilder(
      column: $table.topThreeQuotes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  Expression<bool> bookWidgetsRefs(
      Expression<bool> Function($$BookWidgetsTableFilterComposer f) f) {
    final $$BookWidgetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bookWidgets,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BookWidgetsTableFilterComposer(
              $db: $db,
              $table: $db.bookWidgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverImage => $composableBuilder(
      column: $table.coverImage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isbn => $composableBuilder(
      column: $table.isbn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dateAdded => $composableBuilder(
      column: $table.dateAdded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dateStarted => $composableBuilder(
      column: $table.dateStarted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dateFinished => $composableBuilder(
      column: $table.dateFinished,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageCount => $composableBuilder(
      column: $table.pageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get publisher => $composableBuilder(
      column: $table.publisher, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get publishedYear => $composableBuilder(
      column: $table.publishedYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isNonFiction => $composableBuilder(
      column: $table.isNonFiction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inThreeSentences => $composableBuilder(
      column: $table.inThreeSentences,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get impressions => $composableBuilder(
      column: $table.impressions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get whoShouldRead => $composableBuilder(
      column: $table.whoShouldRead,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get howChangedMe => $composableBuilder(
      column: $table.howChangedMe,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topThreeQuotes => $composableBuilder(
      column: $table.topThreeQuotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get coverImage => $composableBuilder(
      column: $table.coverImage, builder: (column) => column);

  GeneratedColumn<String> get isbn =>
      $composableBuilder(column: $table.isbn, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);

  GeneratedColumn<int> get dateStarted => $composableBuilder(
      column: $table.dateStarted, builder: (column) => column);

  GeneratedColumn<int> get dateFinished => $composableBuilder(
      column: $table.dateFinished, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<String> get publishedYear => $composableBuilder(
      column: $table.publishedYear, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<bool> get isNonFiction => $composableBuilder(
      column: $table.isNonFiction, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<String> get inThreeSentences => $composableBuilder(
      column: $table.inThreeSentences, builder: (column) => column);

  GeneratedColumn<String> get impressions => $composableBuilder(
      column: $table.impressions, builder: (column) => column);

  GeneratedColumn<String> get whoShouldRead => $composableBuilder(
      column: $table.whoShouldRead, builder: (column) => column);

  GeneratedColumn<String> get howChangedMe => $composableBuilder(
      column: $table.howChangedMe, builder: (column) => column);

  GeneratedColumn<String> get topThreeQuotes => $composableBuilder(
      column: $table.topThreeQuotes, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  Expression<T> bookWidgetsRefs<T extends Object>(
      Expression<T> Function($$BookWidgetsTableAnnotationComposer a) f) {
    final $$BookWidgetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bookWidgets,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BookWidgetsTableAnnotationComposer(
              $db: $db,
              $table: $db.bookWidgets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableAnnotationComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder,
    (Book, $$BooksTableReferences),
    Book,
    PrefetchHooks Function({bool bookWidgetsRefs})> {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> coverImage = const Value.absent(),
            Value<String?> isbn = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> dateAdded = const Value.absent(),
            Value<int?> dateStarted = const Value.absent(),
            Value<int?> dateFinished = const Value.absent(),
            Value<int?> rating = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> pageCount = const Value.absent(),
            Value<String?> publisher = const Value.absent(),
            Value<String?> publishedYear = const Value.absent(),
            Value<String?> coverUrl = const Value.absent(),
            Value<bool> isNonFiction = const Value.absent(),
            Value<String?> genre = const Value.absent(),
            Value<String?> inThreeSentences = const Value.absent(),
            Value<String?> impressions = const Value.absent(),
            Value<String?> whoShouldRead = const Value.absent(),
            Value<String?> howChangedMe = const Value.absent(),
            Value<String?> topThreeQuotes = const Value.absent(),
            Value<String?> tags = const Value.absent(),
          }) =>
              BooksCompanion(
            id: id,
            title: title,
            author: author,
            coverImage: coverImage,
            isbn: isbn,
            status: status,
            dateAdded: dateAdded,
            dateStarted: dateStarted,
            dateFinished: dateFinished,
            rating: rating,
            note: note,
            description: description,
            pageCount: pageCount,
            publisher: publisher,
            publishedYear: publishedYear,
            coverUrl: coverUrl,
            isNonFiction: isNonFiction,
            genre: genre,
            inThreeSentences: inThreeSentences,
            impressions: impressions,
            whoShouldRead: whoShouldRead,
            howChangedMe: howChangedMe,
            topThreeQuotes: topThreeQuotes,
            tags: tags,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String author,
            Value<String> coverImage = const Value.absent(),
            Value<String?> isbn = const Value.absent(),
            required String status,
            required int dateAdded,
            Value<int?> dateStarted = const Value.absent(),
            Value<int?> dateFinished = const Value.absent(),
            Value<int?> rating = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> pageCount = const Value.absent(),
            Value<String?> publisher = const Value.absent(),
            Value<String?> publishedYear = const Value.absent(),
            Value<String?> coverUrl = const Value.absent(),
            Value<bool> isNonFiction = const Value.absent(),
            Value<String?> genre = const Value.absent(),
            Value<String?> inThreeSentences = const Value.absent(),
            Value<String?> impressions = const Value.absent(),
            Value<String?> whoShouldRead = const Value.absent(),
            Value<String?> howChangedMe = const Value.absent(),
            Value<String?> topThreeQuotes = const Value.absent(),
            Value<String?> tags = const Value.absent(),
          }) =>
              BooksCompanion.insert(
            id: id,
            title: title,
            author: author,
            coverImage: coverImage,
            isbn: isbn,
            status: status,
            dateAdded: dateAdded,
            dateStarted: dateStarted,
            dateFinished: dateFinished,
            rating: rating,
            note: note,
            description: description,
            pageCount: pageCount,
            publisher: publisher,
            publishedYear: publishedYear,
            coverUrl: coverUrl,
            isNonFiction: isNonFiction,
            genre: genre,
            inThreeSentences: inThreeSentences,
            impressions: impressions,
            whoShouldRead: whoShouldRead,
            howChangedMe: howChangedMe,
            topThreeQuotes: topThreeQuotes,
            tags: tags,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BooksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bookWidgetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bookWidgetsRefs) db.bookWidgets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bookWidgetsRefs)
                    await $_getPrefetchedData<Book, $BooksTable, BookWidget>(
                        currentTable: table,
                        referencedTable:
                            $$BooksTableReferences._bookWidgetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BooksTableReferences(db, table, p0)
                                .bookWidgetsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BooksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BooksTable,
    Book,
    $$BooksTableFilterComposer,
    $$BooksTableOrderingComposer,
    $$BooksTableAnnotationComposer,
    $$BooksTableCreateCompanionBuilder,
    $$BooksTableUpdateCompanionBuilder,
    (Book, $$BooksTableReferences),
    Book,
    PrefetchHooks Function({bool bookWidgetsRefs})>;
typedef $$BookWidgetsTableCreateCompanionBuilder = BookWidgetsCompanion
    Function({
  Value<int> id,
  required int bookId,
  required String type,
  required String payloadJson,
  required int sortOrder,
  required int createdAt,
  required int updatedAt,
});
typedef $$BookWidgetsTableUpdateCompanionBuilder = BookWidgetsCompanion
    Function({
  Value<int> id,
  Value<int> bookId,
  Value<String> type,
  Value<String> payloadJson,
  Value<int> sortOrder,
  Value<int> createdAt,
  Value<int> updatedAt,
});

final class $$BookWidgetsTableReferences
    extends BaseReferences<_$AppDatabase, $BookWidgetsTable, BookWidget> {
  $$BookWidgetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books
      .createAlias($_aliasNameGenerator(db.bookWidgets.bookId, db.books.id));

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager($_db, $_db.books)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BookWidgetsTableFilterComposer
    extends Composer<_$AppDatabase, $BookWidgetsTable> {
  $$BookWidgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableFilterComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BookWidgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookWidgetsTable> {
  $$BookWidgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableOrderingComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BookWidgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookWidgetsTable> {
  $$BookWidgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.books,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BooksTableAnnotationComposer(
              $db: $db,
              $table: $db.books,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BookWidgetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookWidgetsTable,
    BookWidget,
    $$BookWidgetsTableFilterComposer,
    $$BookWidgetsTableOrderingComposer,
    $$BookWidgetsTableAnnotationComposer,
    $$BookWidgetsTableCreateCompanionBuilder,
    $$BookWidgetsTableUpdateCompanionBuilder,
    (BookWidget, $$BookWidgetsTableReferences),
    BookWidget,
    PrefetchHooks Function({bool bookId})> {
  $$BookWidgetsTableTableManager(_$AppDatabase db, $BookWidgetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookWidgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookWidgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookWidgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bookId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
          }) =>
              BookWidgetsCompanion(
            id: id,
            bookId: bookId,
            type: type,
            payloadJson: payloadJson,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bookId,
            required String type,
            required String payloadJson,
            required int sortOrder,
            required int createdAt,
            required int updatedAt,
          }) =>
              BookWidgetsCompanion.insert(
            id: id,
            bookId: bookId,
            type: type,
            payloadJson: payloadJson,
            sortOrder: sortOrder,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BookWidgetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$BookWidgetsTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$BookWidgetsTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BookWidgetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookWidgetsTable,
    BookWidget,
    $$BookWidgetsTableFilterComposer,
    $$BookWidgetsTableOrderingComposer,
    $$BookWidgetsTableAnnotationComposer,
    $$BookWidgetsTableCreateCompanionBuilder,
    $$BookWidgetsTableUpdateCompanionBuilder,
    (BookWidget, $$BookWidgetsTableReferences),
    BookWidget,
    PrefetchHooks Function({bool bookId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$BookWidgetsTableTableManager get bookWidgets =>
      $$BookWidgetsTableTableManager(_db, _db.bookWidgets);
}
