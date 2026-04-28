import 'package:book_worm/states/book_detail_state.dart';
import 'package:book_worm/utility/app_strings.dart';
import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';

class BookDetailNonFictionCard extends StatefulWidget {
  final BookDetailState state;

  const BookDetailNonFictionCard({super.key, required this.state});

  @override
  State<BookDetailNonFictionCard> createState() =>
      _BookDetailNonFictionCardState();
}

class _BookDetailNonFictionCardState extends State<BookDetailNonFictionCard> {
  final _tagController = TextEditingController();

  // Controllers for indexed list fields (3 sentences, 3 quotes)
  late final List<TextEditingController> _sentenceControllers;
  late final List<TextEditingController> _quoteControllers;
  late final TextEditingController _impressionsCtrl;
  late final TextEditingController _whoCtrl;
  late final TextEditingController _howCtrl;

  @override
  void initState() {
    super.initState();
    final s = widget.state;
    _sentenceControllers = List.generate(
      3,
      (i) => TextEditingController(
          text: i < s.inThreeSentences.length ? s.inThreeSentences[i] : ''),
    );
    _quoteControllers = List.generate(
      3,
      (i) => TextEditingController(
          text: i < s.topThreeQuotes.length ? s.topThreeQuotes[i] : ''),
    );
    _impressionsCtrl = TextEditingController(text: s.impressions ?? '');
    _whoCtrl = TextEditingController(text: s.whoShouldRead ?? '');
    _howCtrl = TextEditingController(text: s.howChangedMe ?? '');
  }

  @override
  void dispose() {
    for (final c in _sentenceControllers) {
      c.dispose();
    }
    for (final c in _quoteControllers) {
      c.dispose();
    }
    _impressionsCtrl.dispose();
    _whoCtrl.dispose();
    _howCtrl.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final editMode = state.isEditMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          label: AppStrings.inThreeSentences,
          child: Column(
            children: List.generate(3, (i) {
              return _IndexedField(
                index: i + 1,
                controller: _sentenceControllers[i],
                enabled: editMode,
                hint: 'Setning ${i + 1}',
                onChanged: (v) => state.updateInThreeSentences(i, v),
              );
            }),
          ),
        ),
        const SizedBox(height: 12),
        _Section(
          label: AppStrings.impressions,
          child: _MultilineField(
            controller: _impressionsCtrl,
            enabled: editMode,
            hint: AppStrings.impressionsHint,
            onChanged: state.updateImpressions,
          ),
        ),
        const SizedBox(height: 12),
        _Section(
          label: AppStrings.whoShouldRead,
          child: _MultilineField(
            controller: _whoCtrl,
            enabled: editMode,
            hint: AppStrings.whoShouldReadHint,
            onChanged: state.updateWhoShouldRead,
          ),
        ),
        const SizedBox(height: 12),
        _Section(
          label: AppStrings.howChangedMe,
          child: _MultilineField(
            controller: _howCtrl,
            enabled: editMode,
            hint: AppStrings.howChangedMeHint,
            onChanged: state.updateHowChangedMe,
          ),
        ),
        const SizedBox(height: 12),
        _Section(
          label: AppStrings.topThreeQuotes,
          child: Column(
            children: List.generate(3, (i) {
              return _IndexedField(
                index: i + 1,
                controller: _quoteControllers[i],
                enabled: editMode,
                hint: 'Sitat ${i + 1}',
                onChanged: (v) => state.updateTopThreeQuotes(i, v),
              );
            }),
          ),
        ),
        const SizedBox(height: 12),
        _Section(
          label: AppStrings.tags,
          child: _TagsField(state: state, controller: _tagController, editMode: editMode),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final Widget child;

  const _Section({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
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
      maxLines: null,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        filled: false,
        contentPadding: EdgeInsets.zero,
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
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 10),
            child: Text(
              '$index.',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              maxLines: null,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                filled: false,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.5,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagsField extends StatefulWidget {
  final BookDetailState state;
  final TextEditingController controller;
  final bool editMode;

  const _TagsField({
    required this.state,
    required this.controller,
    required this.editMode,
  });

  @override
  State<_TagsField> createState() => _TagsFieldState();
}

class _TagsFieldState extends State<_TagsField> {
  void _addTag() {
    final tag = widget.controller.text.trim();
    if (tag.isNotEmpty) {
      widget.state.addTag(tag);
      widget.controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tags = widget.state.tags;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tags.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: tags.map((tag) {
              return Chip(
                label: Text(tag,
                    style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary)),
                backgroundColor: AppTheme.primaryLight,
                side: BorderSide.none,
                deleteIcon: widget.editMode
                    ? const Icon(Icons.close, size: 16, color: AppTheme.textSecondary)
                    : null,
                onDeleted: widget.editMode ? () => widget.state.removeTag(tag) : null,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
        if (widget.editMode) ...[
          if (tags.isNotEmpty) const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: AppStrings.addTag,
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
                  onSubmitted: (_) => _addTag(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 20, color: AppTheme.primary),
                onPressed: _addTag,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ] else if (tags.isEmpty)
          const Text(
            '—',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
      ],
    );
  }
}
