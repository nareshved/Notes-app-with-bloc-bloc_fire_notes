class NoteModel {
  String noteTitle;
  String noteDes;
  String noteTime;

  NoteModel(
      {required this.noteDes, required this.noteTime, required this.noteTitle});

  factory NoteModel.fromDoc(Map<String, dynamic> json) {
    return NoteModel(
        noteDes: json["noteDes"],
        noteTime: json["noteTime"],
        noteTitle: json["noteTitle"]);
  }

  Map<String, dynamic> toDoc() {
    return {
      "noteTitle": noteTitle,
      "noteDes": noteDes,
      "noteTime": noteTime,
    };
  }
}
