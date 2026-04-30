import 'dart:convert';
import 'dart:io';

import 'package:book_worm/database/app_database.dart';
import 'package:book_worm/services/database_service.dart';
import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BookDetailWidgetSections extends StatelessWidget {
  const BookDetailWidgetSections({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookDetailState>();
    final service = context.read<DatabaseService>();

    return StreamBuilder<List<BookWidget>>(
      stream: service.watchBookWidgets(state.book.id),
      builder: (context, snapshot) {
        final widgets = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.isEditMode)
                _ReorderableWidgetCards(
                  widgets: widgets,
                  state: state,
                  service: service,
                )
              else
                for (final widget in widgets) ...[
                  _BookWidgetCard(
                    widget: widget,
                    state: state,
                    service: service,
                  ),
                  const SizedBox(height: 12),
                ],
              Align(
                alignment: Alignment.center,
                child: FilledButton.icon(
                  onPressed: () => _showAddSheet(
                    context: context,
                    bookId: state.book.id,
                    existingWidgets: widgets,
                    service: service,
                    state: state,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text(AppStrings.addBookWidget),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddSheet({
    required BuildContext context,
    required int bookId,
    required List<BookWidget> existingWidgets,
    required DatabaseService service,
    required BookDetailState state,
  }) {
    final existingTypes = existingWidgets.map((w) => w.type).toSet();
    final available = _BookWidgetType.values
        .where((type) => !existingTypes.contains(type.type))
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (available.isEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Text(
                  AppStrings.noBookWidgetsAvailable,
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              )
            else
              for (final type in available)
                ListTile(
                  leading: Icon(type.icon),
                  title: Text(type.label),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    await service.addBookWidget(
                      bookId: bookId,
                      type: type.type,
                      payloadJson: type.defaultPayload(state),
                    );
                  },
                ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ReorderableWidgetCards extends StatelessWidget {
  final List<BookWidget> widgets;
  final BookDetailState state;
  final DatabaseService service;

  const _ReorderableWidgetCards({
    required this.widgets,
    required this.state,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: widgets.length,
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final scale = 1 + animation.value * 0.015;
            return Transform.scale(
              scale: scale,
              child: Material(
                color: Colors.transparent,
                shadowColor: Colors.black.withValues(alpha: 0.12),
                child: child,
              ),
            );
          },
          child: child,
        );
      },
      onReorder: (oldIndex, newIndex) async {
        if (newIndex > oldIndex) newIndex -= 1;
        final reordered = List<BookWidget>.of(widgets);
        final moved = reordered.removeAt(oldIndex);
        reordered.insert(newIndex, moved);
        await service.reorderBookWidgets(reordered);
      },
      itemBuilder: (context, index) {
        final widget = widgets[index];
        return Padding(
          key: ValueKey(widget.id),
          padding: const EdgeInsets.only(bottom: 12),
          child: _BookWidgetCard(
            widget: widget,
            state: state,
            service: service,
            reorderIndex: index,
          ),
        );
      },
    );
  }
}

enum _BookWidgetType {
  review('notes', AppStrings.bookReviewWidget, Icons.rate_review_outlined),
  textNote('textNote', AppStrings.notesWidget, Icons.edit_note_outlined),
  lending('lending', AppStrings.lendingWidget, Icons.handshake_outlined),
  progress('progress', AppStrings.progressWidget, Icons.trending_up),
  gallery('gallery', AppStrings.galleryWidget, Icons.photo_library_outlined),
  location('location', AppStrings.locationWidget, Icons.location_on_outlined);

  final String type;
  final String label;
  final IconData icon;

  const _BookWidgetType(this.type, this.label, this.icon);

  Color get accent {
    switch (this) {
      case _BookWidgetType.review:
        return const Color(0xFF8A5A44);
      case _BookWidgetType.textNote:
        return AppTheme.primary;
      case _BookWidgetType.lending:
        return AppTheme.statusWant;
      case _BookWidgetType.progress:
        return AppTheme.statusReading;
      case _BookWidgetType.gallery:
        return AppTheme.accent;
      case _BookWidgetType.location:
        return AppTheme.statusRead;
    }
  }

  String defaultPayload(BookDetailState state) {
    switch (this) {
      case _BookWidgetType.review:
        return jsonEncode({
          'note': state.note,
          'inThreeSentences': state.inThreeSentences,
          'impressions': state.impressions,
          'whoShouldRead': state.whoShouldRead,
          'howChangedMe': state.howChangedMe,
          'topThreeQuotes': state.topThreeQuotes,
          'tags': state.tags,
        });
      case _BookWidgetType.textNote:
        return jsonEncode({'text': ''});
      case _BookWidgetType.lending:
        return jsonEncode({
          'direction': 'lent',
          'person': '',
          'date': '',
          'returnDate': '',
        });
      case _BookWidgetType.progress:
        return jsonEncode({
          'currentPage': '',
          'totalPages': state.book.pageCount?.toString() ?? '',
          'lastUpdated': '',
        });
      case _BookWidgetType.gallery:
        return jsonEncode({'images': <String>[]});
      case _BookWidgetType.location:
        return jsonEncode({'location': ''});
    }
  }

  static _BookWidgetType fromType(String type) {
    return values.firstWhere(
      (value) => value.type == type,
      orElse: () => _BookWidgetType.review,
    );
  }
}

class _BookWidgetCard extends StatelessWidget {
  final BookWidget widget;
  final BookDetailState state;
  final DatabaseService service;
  final int? reorderIndex;

  const _BookWidgetCard({
    required this.widget,
    required this.state,
    required this.service,
    this.reorderIndex,
  });

  @override
  Widget build(BuildContext context) {
    final type = _BookWidgetType.fromType(widget.type);
    final payload = _decodePayload(widget.payloadJson);
    final accent = type.accent;

    return Container(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          accent.withValues(alpha: 0.025),
          AppTheme.surface,
        ),
        border: Border.all(color: accent.withValues(alpha: 0.14)),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(width: 4, color: accent),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(type.icon, size: 18, color: accent),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        type.label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    if (state.isEditMode && reorderIndex != null) ...[
                      ReorderableDragStartListener(
                        index: reorderIndex!,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.drag_handle,
                            size: 20,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                    ],
                    if (state.isEditMode)
                      IconButton(
                        tooltip: AppStrings.remove,
                        icon: const Icon(Icons.close, size: 18),
                        color: AppTheme.textSecondary,
                        onPressed: () => service.deleteBookWidget(widget.id),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(
                          width: 34,
                          height: 34,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                switch (type) {
                  _BookWidgetType.review => _ReviewPayloadFields(
                      payload: payload,
                      isNonFiction: state.isNonFiction,
                      enabled: state.isEditMode,
                      onChanged: _save,
                    ),
                  _BookWidgetType.textNote => _TextNotePayloadFields(
                      payload: payload,
                      enabled: state.isEditMode,
                      onChanged: _save,
                    ),
                  _BookWidgetType.lending => _LendingPayloadFields(
                      payload: payload,
                      enabled: state.isEditMode,
                      onChanged: _save,
                    ),
                  _BookWidgetType.progress => _ProgressPayloadFields(
                      payload: payload,
                      enabled: state.isEditMode,
                      onChanged: _save,
                    ),
                  _BookWidgetType.gallery => _GalleryPayloadFields(
                      payload: payload,
                      enabled: state.isEditMode,
                      onChanged: _save,
                    ),
                  _BookWidgetType.location => _LocationPayloadFields(
                      payload: payload,
                      enabled: state.isEditMode,
                      onChanged: _save,
                    ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _save(Map<String, dynamic> payload) {
    service.updateBookWidgetPayload(widget.id, jsonEncode(payload));
  }
}

class _ReviewPayloadFields extends StatefulWidget {
  final Map<String, dynamic> payload;
  final bool isNonFiction;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _ReviewPayloadFields({
    required this.payload,
    required this.isNonFiction,
    required this.enabled,
    required this.onChanged,
  });

  @override
  State<_ReviewPayloadFields> createState() => _ReviewPayloadFieldsState();
}

class _ReviewPayloadFieldsState extends State<_ReviewPayloadFields> {
  late final TextEditingController _noteController;
  late final List<TextEditingController> _sentenceControllers;
  late final TextEditingController _impressionsController;
  late final TextEditingController _whoController;
  late final TextEditingController _howController;
  late final List<TextEditingController> _quoteControllers;
  late final TextEditingController _tagController;
  late final TextEditingController _favoriteCharacterController;
  late final TextEditingController _memorableSceneController;
  late final TextEditingController _fictionThemesController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: _stringValue('note'));
    _sentenceControllers = List.generate(
      3,
      (index) =>
          TextEditingController(text: _listValue('inThreeSentences', index)),
    );
    _impressionsController = TextEditingController(
      text: _stringValue('impressions'),
    );
    _whoController = TextEditingController(text: _stringValue('whoShouldRead'));
    _howController = TextEditingController(text: _stringValue('howChangedMe'));
    _quoteControllers = List.generate(
      3,
      (index) =>
          TextEditingController(text: _listValue('topThreeQuotes', index)),
    );
    _tagController = TextEditingController();
    _favoriteCharacterController = TextEditingController(
      text: _stringValue('favoriteCharacter'),
    );
    _memorableSceneController = TextEditingController(
      text: _stringValue('memorableScene'),
    );
    _fictionThemesController = TextEditingController(
      text: _stringValue('fictionThemes'),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    for (final controller in _sentenceControllers) {
      controller.dispose();
    }
    _impressionsController.dispose();
    _whoController.dispose();
    _howController.dispose();
    for (final controller in _quoteControllers) {
      controller.dispose();
    }
    _tagController.dispose();
    _favoriteCharacterController.dispose();
    _memorableSceneController.dispose();
    _fictionThemesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isNonFiction) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Subsection(
            label: AppStrings.fictionReview,
            child: _MultilineField(
              controller: _noteController,
              enabled: widget.enabled,
              hint: AppStrings.notesHint,
              onChanged: (value) => _setValue('note', value),
            ),
          ),
          _SingleLineField(
            controller: _favoriteCharacterController,
            enabled: widget.enabled,
            label: AppStrings.favoriteCharacter,
            icon: Icons.favorite_border,
            onChanged: (value) => _setValue('favoriteCharacter', value),
          ),
          const SizedBox(height: 12),
          _Subsection(
            label: AppStrings.memorableScene,
            child: _MultilineField(
              controller: _memorableSceneController,
              enabled: widget.enabled,
              hint: 'Hva husker du best?',
              onChanged: (value) => _setValue('memorableScene', value),
            ),
          ),
          _Subsection(
            label: AppStrings.fictionThemes,
            child: _MultilineField(
              controller: _fictionThemesController,
              enabled: widget.enabled,
              hint: 'F.eks. mørk, varm, politisk, håpefull...',
              onChanged: (value) => _setValue('fictionThemes', value),
            ),
          ),
        ],
      );
    }

    final tags = _stringList('tags');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Subsection(
          label: AppStrings.inThreeSentences,
          child: Column(
            children: List.generate(
              3,
              (index) => _IndexedField(
                index: index + 1,
                controller: _sentenceControllers[index],
                enabled: widget.enabled,
                hint: 'Setning ${index + 1}',
                onChanged: (value) =>
                    _setListValue('inThreeSentences', index, value),
              ),
            ),
          ),
        ),
        _Subsection(
          label: AppStrings.impressions,
          child: _MultilineField(
            controller: _impressionsController,
            enabled: widget.enabled,
            hint: AppStrings.impressionsHint,
            onChanged: (value) => _setValue('impressions', value),
          ),
        ),
        _Subsection(
          label: AppStrings.whoShouldRead,
          child: _MultilineField(
            controller: _whoController,
            enabled: widget.enabled,
            hint: AppStrings.whoShouldReadHint,
            onChanged: (value) => _setValue('whoShouldRead', value),
          ),
        ),
        _Subsection(
          label: AppStrings.howChangedMe,
          child: _MultilineField(
            controller: _howController,
            enabled: widget.enabled,
            hint: AppStrings.howChangedMeHint,
            onChanged: (value) => _setValue('howChangedMe', value),
          ),
        ),
        _Subsection(
          label: AppStrings.topThreeQuotes,
          child: Column(
            children: List.generate(
              3,
              (index) => _IndexedField(
                index: index + 1,
                controller: _quoteControllers[index],
                enabled: widget.enabled,
                hint: 'Sitat ${index + 1}',
                onChanged: (value) =>
                    _setListValue('topThreeQuotes', index, value),
              ),
            ),
          ),
        ),
        _Subsection(
          label: AppStrings.tags,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: tags
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          backgroundColor: AppTheme.primaryLight,
                          side: BorderSide.none,
                          deleteIcon: widget.enabled
                              ? const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: AppTheme.textSecondary,
                                )
                              : null,
                          onDeleted:
                              widget.enabled ? () => _removeTag(tag) : null,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
                ),
              if (widget.enabled) ...[
                if (tags.isNotEmpty) const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tagController,
                        decoration: _bookWidgetInputDecoration(
                          hintText: AppStrings.addTag,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textPrimary,
                        ),
                        onSubmitted: (_) => _addTag(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 20,
                        color: AppTheme.primary,
                      ),
                      onPressed: _addTag,
                    ),
                  ],
                ),
              ] else if (tags.isEmpty)
                const Text(
                  '-',
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _stringValue(String key) => widget.payload[key] as String? ?? '';

  String _listValue(String key, int index) {
    final list = _stringList(key);
    return index < list.length ? list[index] : '';
  }

  List<String> _stringList(String key) {
    final value = widget.payload[key];
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return [];
  }

  void _setValue(String key, String value) {
    final next = Map<String, dynamic>.from(widget.payload);
    next[key] = value.isEmpty ? null : value;
    widget.onChanged(next);
  }

  void _setListValue(String key, int index, String value) {
    final next = Map<String, dynamic>.from(widget.payload);
    final list = _stringList(key);
    while (list.length <= index) {
      list.add('');
    }
    list[index] = value;
    next[key] = list;
    widget.onChanged(next);
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isEmpty) return;

    final tags = _stringList('tags');
    if (!tags.contains(tag)) {
      final next = Map<String, dynamic>.from(widget.payload);
      next['tags'] = [...tags, tag];
      widget.onChanged(next);
    }
    _tagController.clear();
  }

  void _removeTag(String tag) {
    final next = Map<String, dynamic>.from(widget.payload);
    next['tags'] = _stringList('tags')..remove(tag);
    widget.onChanged(next);
  }
}

class _TextNotePayloadFields extends StatefulWidget {
  final Map<String, dynamic> payload;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _TextNotePayloadFields({
    required this.payload,
    required this.enabled,
    required this.onChanged,
  });

  @override
  State<_TextNotePayloadFields> createState() => _TextNotePayloadFieldsState();
}

class _TextNotePayloadFieldsState extends State<_TextNotePayloadFields> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.payload['text'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MultilineField(
      controller: _controller,
      enabled: widget.enabled,
      hint: AppStrings.notesHint,
      onChanged: (value) => widget.onChanged({'text': value}),
    );
  }
}

class _LendingPayloadFields extends StatefulWidget {
  final Map<String, dynamic> payload;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _LendingPayloadFields({
    required this.payload,
    required this.enabled,
    required this.onChanged,
  });

  @override
  State<_LendingPayloadFields> createState() => _LendingPayloadFieldsState();
}

class _LendingPayloadFieldsState extends State<_LendingPayloadFields> {
  late String _direction;
  late final TextEditingController _personController;
  late final TextEditingController _dateController;
  late final TextEditingController _returnDateController;

  @override
  void initState() {
    super.initState();
    _direction = widget.payload['direction'] as String? ?? 'lent';
    _personController = TextEditingController(
      text: widget.payload['person'] as String? ?? '',
    );
    _dateController = TextEditingController(
      text: widget.payload['date'] as String? ?? '',
    );
    _returnDateController = TextEditingController(
      text: widget.payload['returnDate'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _personController.dispose();
    _dateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return _LendingSummary(
        direction: _direction,
        person: _personController.text,
        date: _dateController.text,
        returnDate: _returnDateController.text,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _DirectionChip(
              selected: _direction == 'lent',
              enabled: widget.enabled,
              color: AppTheme.statusWant,
              icon: Icons.north_east,
              label: AppStrings.lentOut,
              onTap: () => _setDirection('lent'),
            ),
            _DirectionChip(
              selected: _direction == 'borrowed',
              enabled: widget.enabled,
              color: AppTheme.statusReading,
              icon: Icons.south_west,
              label: AppStrings.borrowed,
              onTap: () => _setDirection('borrowed'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SingleLineField(
          controller: _personController,
          enabled: widget.enabled,
          label: AppStrings.person,
          icon: Icons.person_outline,
          onChanged: (_) => _save(),
        ),
        const SizedBox(height: 8),
        _DateField(
          controller: _dateController,
          enabled: widget.enabled,
          label: AppStrings.loanDate,
          icon: Icons.calendar_today_outlined,
          onChanged: _save,
        ),
        const SizedBox(height: 8),
        _DateField(
          controller: _returnDateController,
          enabled: widget.enabled,
          label: AppStrings.returnDate,
          icon: Icons.event_available_outlined,
          onChanged: _save,
        ),
      ],
    );
  }

  void _setDirection(String direction) {
    if (!widget.enabled || _direction == direction) return;
    setState(() => _direction = direction);
    _save();
  }

  void _save() {
    widget.onChanged({
      'direction': _direction,
      'person': _personController.text,
      'date': _dateController.text,
      'returnDate': _returnDateController.text,
    });
  }
}

class _LendingSummary extends StatelessWidget {
  final String direction;
  final String person;
  final String date;
  final String returnDate;

  const _LendingSummary({
    required this.direction,
    required this.person,
    required this.date,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    final isBorrowed = direction == 'borrowed';
    final color = isBorrowed ? AppTheme.statusReading : AppTheme.statusWant;
    final label = isBorrowed ? AppStrings.borrowed : AppStrings.lentOut;
    final name = person.trim().isEmpty ? '-' : person.trim();
    final details = [
      if (date.trim().isNotEmpty) date.trim(),
      if (returnDate.trim().isNotEmpty) 'Retur $returnDate',
    ].join(' · ');

    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isBorrowed ? Icons.south_west : Icons.north_east,
            size: 17,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: $name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (details.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  details,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressPayloadFields extends StatefulWidget {
  final Map<String, dynamic> payload;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _ProgressPayloadFields({
    required this.payload,
    required this.enabled,
    required this.onChanged,
  });

  @override
  State<_ProgressPayloadFields> createState() => _ProgressPayloadFieldsState();
}

class _ProgressPayloadFieldsState extends State<_ProgressPayloadFields> {
  late final TextEditingController _currentPageController;
  late final TextEditingController _totalPagesController;
  late final TextEditingController _updatedController;

  @override
  void initState() {
    super.initState();
    _currentPageController = TextEditingController(
      text: (widget.payload['currentPage'] ?? widget.payload['pagesRead'])
              ?.toString() ??
          '',
    );
    _totalPagesController = TextEditingController(
      text: widget.payload['totalPages']?.toString() ?? '',
    );
    _updatedController = TextEditingController(
      text: widget.payload['lastUpdated'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _currentPageController.dispose();
    _totalPagesController.dispose();
    _updatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = int.tryParse(_currentPageController.text) ?? 0;
    final totalPages = int.tryParse(_totalPagesController.text) ?? 0;
    final progress =
        totalPages <= 0 ? 0.0 : (currentPage / totalPages).clamp(0.0, 1.0);
    final progressLabel = totalPages <= 0
        ? '$currentPage sider'
        : '$currentPage / $totalPages sider';
    final percentage = '${(progress * 100).round()}%';
    final lastUpdated = _updatedController.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              percentage,
              style: const TextStyle(
                color: AppTheme.statusReading,
                fontSize: 34,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    progressLabel,
                    softWrap: true,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(999),
                    backgroundColor: AppTheme.surfaceVariant,
                    color: AppTheme.statusReading,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!widget.enabled && lastUpdated.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.update, size: 14, color: AppTheme.textSecondary),
              const SizedBox(width: 5),
              Text(
                '${AppStrings.lastUpdated}: $lastUpdated',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
        if (widget.enabled) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              _PageStepButton(
                icon: Icons.remove,
                onPressed: () => _addPages(-1),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SingleLineField(
                  controller: _currentPageController,
                  enabled: widget.enabled,
                  label: 'Lest',
                  icon: Icons.menu_book_outlined,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    setState(() {});
                    _save(updateDate: true);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SingleLineField(
                  controller: _totalPagesController,
                  enabled: widget.enabled,
                  label: 'Totalt',
                  icon: Icons.format_list_numbered,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    setState(() {});
                    _save(updateDate: true);
                  },
                ),
              ),
              const SizedBox(width: 8),
              _PageStepButton(
                icon: Icons.add,
                onPressed: () => _addPages(1),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _addPages(5),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('5 sider'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _DateField(
            controller: _updatedController,
            enabled: widget.enabled,
            label: AppStrings.lastUpdated,
            icon: Icons.update,
            onChanged: () => _save(updateDate: false),
          ),
        ],
      ],
    );
  }

  void _addPages(int amount) {
    final current = int.tryParse(_currentPageController.text) ?? 0;
    final total = int.tryParse(_totalPagesController.text);
    final rawNext = current + amount;
    final next =
        total == null ? rawNext.clamp(0, 999999) : rawNext.clamp(0, total);

    _currentPageController.text = next.toString();
    setState(() {});
    _save(updateDate: true);
  }

  void _save({required bool updateDate}) {
    if (updateDate) {
      _updatedController.text = DateFormat('d. MMM y').format(DateTime.now());
    }
    widget.onChanged({
      'currentPage': _currentPageController.text,
      'totalPages': _totalPagesController.text,
      'lastUpdated': _updatedController.text,
    });
  }
}

class _PageStepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _PageStepButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: icon == Icons.add ? 'Legg til side' : 'Trekk fra side',
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      style: IconButton.styleFrom(
        fixedSize: const Size(38, 38),
        padding: EdgeInsets.zero,
        backgroundColor: AppTheme.statusReading.withValues(alpha: 0.12),
        foregroundColor: AppTheme.statusReading,
      ),
    );
  }
}

class _GalleryPayloadFields extends StatefulWidget {
  final Map<String, dynamic> payload;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _GalleryPayloadFields({
    required this.payload,
    required this.enabled,
    required this.onChanged,
  });

  @override
  State<_GalleryPayloadFields> createState() => _GalleryPayloadFieldsState();
}

class _GalleryPayloadFieldsState extends State<_GalleryPayloadFields> {
  late List<_GalleryImage> _images;

  @override
  void initState() {
    super.initState();
    _images = _stringList(widget.payload['images']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_images.isEmpty)
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                AppStrings.noImages,
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
          )
        else
          SizedBox(
            height: 240,
            child: PageView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final image = _images[index];
                final imagePath = image.path;
                final cacheWidth = (MediaQuery.sizeOf(context).width *
                        MediaQuery.devicePixelRatioOf(context))
                    .round();
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        cacheWidth: cacheWidth,
                        gaplessPlayback: true,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppTheme.surfaceVariant,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    if (image.caption.trim().isNotEmpty)
                      Positioned(
                        left: 12,
                        top: 10,
                        right: widget.enabled ? 58 : 12,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.58),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: Text(
                                image.caption,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (widget.enabled)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: Colors.black54,
                          shape: const CircleBorder(),
                          child: IconButton(
                            tooltip: AppStrings.remove,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () => _removeImage(imagePath),
                          ),
                        ),
                      ),
                    Positioned(
                      left: 12,
                      bottom: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Text(
                            '${index + 1} / ${_images.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        if (widget.enabled) ...[
          const SizedBox(height: 12),
          if (_images.isNotEmpty)
            _CaptionEditor(
              key: ValueKey(_images.map((image) => image.path).join('|')),
              images: _images,
              onChanged: (index, caption) {
                setState(() {
                  _images[index] = _images[index].copyWith(caption: caption);
                });
                _save();
              },
            ),
          if (_images.isNotEmpty) const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _showImagePicker(context),
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: const Text(AppStrings.addImage),
          ),
        ],
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Velg fra galleri'),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickImage(picker.ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Ta bilde'),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickImage(picker.ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(picker.ImageSource source) async {
    final imagePicker = picker.ImagePicker();
    final picked = await imagePicker.pickImage(
      source: source,
      imageQuality: 78,
      maxWidth: 1600,
      maxHeight: 1600,
    );
    if (picked == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'book-widget-${DateTime.now().millisecondsSinceEpoch}.jpg';
    final saved = await File(picked.path).copy('${dir.path}/$fileName');

    setState(() => _images = [..._images, _GalleryImage(path: saved.path)]);
    _save();
  }

  void _removeImage(String imagePath) {
    setState(
      () =>
          _images = _images.where((image) => image.path != imagePath).toList(),
    );
    _save();
  }

  void _save() {
    widget.onChanged({
      'images': _images.map((image) => image.toJson()).toList(),
    });
  }

  List<_GalleryImage> _stringList(dynamic value) {
    if (value is List) {
      return value
          .map((item) {
            if (item is Map) {
              return _GalleryImage(
                path: item['path']?.toString() ?? '',
                caption: item['caption']?.toString() ?? '',
              );
            }
            return _GalleryImage(path: item.toString());
          })
          .where((image) => image.path.isNotEmpty)
          .toList();
    }
    return [];
  }
}

class _GalleryImage {
  final String path;
  final String caption;

  const _GalleryImage({required this.path, this.caption = ''});

  _GalleryImage copyWith({String? caption}) {
    return _GalleryImage(path: path, caption: caption ?? this.caption);
  }

  Map<String, String> toJson() => {'path': path, 'caption': caption};
}

class _CaptionEditor extends StatefulWidget {
  final List<_GalleryImage> images;
  final void Function(int index, String caption) onChanged;

  const _CaptionEditor({
    super.key,
    required this.images,
    required this.onChanged,
  });

  @override
  State<_CaptionEditor> createState() => _CaptionEditorState();
}

class _CaptionEditorState extends State<_CaptionEditor> {
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = widget.images
        .map((image) => TextEditingController(text: image.caption))
        .toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.images.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == widget.images.length - 1 ? 0 : 8,
          ),
          child: _SingleLineField(
            controller: _controllers[index],
            enabled: true,
            label: '${AppStrings.imageCaption} ${index + 1}',
            icon: Icons.short_text,
            onChanged: (value) => widget.onChanged(index, value),
          ),
        );
      }),
    );
  }
}

class _LocationPayloadFields extends StatefulWidget {
  final Map<String, dynamic> payload;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const _LocationPayloadFields({
    required this.payload,
    required this.enabled,
    required this.onChanged,
  });

  @override
  State<_LocationPayloadFields> createState() => _LocationPayloadFieldsState();
}

class _LocationPayloadFieldsState extends State<_LocationPayloadFields> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.payload['location'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MultilineField(
      controller: _controller,
      enabled: widget.enabled,
      hint: AppStrings.locationHint,
      onChanged: (value) => widget.onChanged({'location': value}),
    );
  }
}

InputDecoration _bookWidgetInputDecoration({
  required String hintText,
  Widget? suffixIcon,
  EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 12,
  ),
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppTheme.divider.withValues(alpha: 0.9)),
  );
  final disabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: AppTheme.divider.withValues(alpha: 0.35)),
  );

  return InputDecoration(
    hintText: hintText,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: Color.alphaBlend(
      AppTheme.background.withValues(alpha: 0.62),
      AppTheme.surface,
    ),
    contentPadding: contentPadding,
    border: border,
    enabledBorder: border,
    disabledBorder: disabledBorder,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppTheme.primary, width: 1.3),
    ),
    hintStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
  );
}

class _Subsection extends StatelessWidget {
  final String label;
  final Widget child;

  const _Subsection({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _MultilineField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String hint;
  final ValueChanged<String> onChanged;

  const _MultilineField({
    required this.controller,
    required this.enabled,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      readOnly: !enabled,
      maxLines: null,
      minLines: 2,
      decoration: _bookWidgetInputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.textPrimary,
        height: 1.5,
      ),
      onChanged: onChanged,
    );
  }
}

class _IndexedField extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final bool enabled;
  final String hint;
  final ValueChanged<String> onChanged;

  const _IndexedField({
    required this.index,
    required this.controller,
    required this.enabled,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                '$index.',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                  height: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _MultilineField(
              controller: controller,
              enabled: enabled,
              hint: hint,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleLineField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChanged;

  const _SingleLineField({
    required this.controller,
    required this.enabled,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(icon: icon, label: label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          readOnly: !enabled,
          keyboardType: keyboardType,
          decoration: _bookWidgetInputDecoration(
            hintText: label,
          ),
          style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String label;
  final IconData icon;
  final VoidCallback onChanged;

  const _DateField({
    required this.controller,
    required this.enabled,
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(icon: icon, label: label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          readOnly: true,
          onTap: enabled ? () => _pickDate(context) : null,
          decoration: _bookWidgetInputDecoration(
            hintText: AppStrings.optionalDate,
            suffixIcon: !enabled
                ? null
                : controller.text.isEmpty
                    ? const Icon(Icons.calendar_today_outlined, size: 18)
                    : IconButton(
                        tooltip: AppStrings.clearDate,
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          controller.clear();
                          onChanged();
                        },
                      ),
          ),
          style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 80),
      lastDate: DateTime(now.year + 20),
    );
    if (picked == null) return;
    controller.text = DateFormat('d. MMM y').format(picked);
    onChanged();
  }
}

class _FieldLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FieldLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppTheme.primary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _DirectionChip extends StatelessWidget {
  final bool selected;
  final bool enabled;
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DirectionChip({
    required this.selected,
    required this.enabled,
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background =
        selected ? color.withValues(alpha: 0.16) : AppTheme.surfaceVariant;
    final foreground = selected ? color : AppTheme.textSecondary;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: foreground),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic> _decodePayload(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
  } catch (_) {
    return {};
  }
  return {};
}
