// book_detail_state.dart
import 'dart:io';

import 'package:book_worm/models/book_notes.dart';
import 'package:book_worm/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:book_worm/models/book.dart';
import 'package:book_worm/models/user_book_entry.dart';
import 'package:book_worm/models/finished_book_note.dart';
import 'package:flutter_svg/svg.dart';

class BookDetailState extends ChangeNotifier {
  final Book book;
  final UserBookEntry userData;
  final FinishedBookNote? finalNote;
  bool isEditMode = false;
  bool somethingChanged = false;

  BookDetailState({
    required this.book,
    required this.userData,
    this.finalNote,
  });

  void toggleEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  void toggleSomethingChanged() {
    somethingChanged = !somethingChanged;
    notifyListeners();
  }

  void discardChanges() {
    isEditMode = false;
    notifyListeners();
  }

  void saveChanges() {
    isEditMode = false;
    userData.finishedNote.value = finalNote;
    IsarService().updateBookEntry(book);
    IsarService().updateUserDataEntry(userData);
    notifyListeners();
  }

  void updateBookSummary(String newSummary) {
    book.summary = newSummary;
    notifyListeners();
  }

  void updateBookTitle(String newTitle) {
    book.title = newTitle;
    notifyListeners();
  }

  void updateBookAuthor(String newAuthor) {
    book.author = newAuthor;
    notifyListeners();
  }

  void updateBookStatus(BookStatus newStatus) {
    userData.status = newStatus;
    userData.dateOfCurrentStatus = DateTime.now();
    notifyListeners();
  }

  void updateStartDate(DateTime newDate) {
    userData.timeStarted = newDate;
    notifyListeners();
  }

  void updateFinishDate(DateTime newDate) {
    if (finalNote != null) {
      finalNote!.timeEnded = newDate;
      notifyListeners();
    }
  }

  void addTag(String tag) {
    if (finalNote != null) {
      finalNote!.tags.add(tag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    if (finalNote != null) {
      finalNote!.tags.remove(tag);
      notifyListeners();
    }
  }

  void addImageToGallery(String imagePath) {
    userData.gallery.add(imagePath);
    notifyListeners();
  }

  void removeImageFromGallery(int index) {
    userData.gallery.removeAt(index);
    notifyListeners();
  }

  void addNote(BookNotes note) {
    userData.bookNote.add(note);
    notifyListeners();
  }

  void updateNote(int index, String newContent) {
    var toUpdate = userData.bookNote.elementAtOrNull(index);
    if (toUpdate != null) {
      toUpdate.noteContent = newContent;
      notifyListeners();
    }
  }

  void deleteNote(BookNotes noteToRemove) {
    userData.bookNote.remove(noteToRemove);
    notifyListeners();
  }

  void updateRating(int newRating) {
    if (finalNote != null) {
      finalNote!.rating = newRating;
      notifyListeners();
    }
  }

  void updateFinalNote(FinishedBookNote updatedNote) {
    IsarService().saveFinalBookNote(updatedNote);
  }

  Color getStatusColor() {
    return _getCorrespondingColor(userData.status);
  }

  Widget getStatusIcon() {
    return _getCorrespondingIcon(userData.status);
  }

  bool get isFinished => userData.status == BookStatus.finished;

  void updateDate(String dateType, DateTime date) {
    switch (dateType) {
      case 'Started':
        userData.timeStarted = date;
        break;
      case 'Finished':
        finalNote?.timeEnded = date;
        break;
      case 'Stopped':
      case 'Added':
        userData.dateOfCurrentStatus = date;
        break;
    }
    notifyListeners();
  }

  void deleteGalleryImage(int index) {
    File(userData.gallery[index]).delete();
    userData.gallery.removeAt(index);
    IsarService().updateUserDataEntry(userData);
    notifyListeners();
  }

  void addGalleryImage(String imagePath) {
    userData.gallery.add(imagePath);
    IsarService().updateUserDataEntry(userData);
    notifyListeners();
  }

  Color _getCorrespondingColor(BookStatus status) {
    switch (status) {
      case BookStatus.finished:
        return Colors.green;
      case BookStatus.reading:
        return Colors.teal;
      case BookStatus.listening:
        return Colors.amber;
      case BookStatus.dropped:
        return Colors.red;
      case BookStatus.added:
        return Colors.black;
    }
  }

  Widget _getCorrespondingIcon(BookStatus status) {
    switch (status) {
      case BookStatus.finished:
        return SvgPicture.asset("assets/icons/finished_medal.svg",
            width: 75.0, height: 75.0);
      case BookStatus.reading:
        return SvgPicture.asset("assets/icons/reading_icon.svg",
            width: 75.0, height: 75.0);
      case BookStatus.listening:
        return const Icon(Icons.headphones, size: 75);
      case BookStatus.dropped:
        return const Icon(Icons.block_outlined, size: 75);
      case BookStatus.added:
        return SvgPicture.asset("assets/icons/added_icon.svg",
            width: 75.0, height: 75.0);
    }
  }

  navigateBack(BuildContext context) {
    Navigator.pop(context);
  }
}
