part of 'message_cubit.dart';

class MessageState extends Equatable {
  final String? userId;
  final String? name;
  final String? myId;
  final String? content;
  final String? fileUrl;

  const MessageState({
    this.userId,
    this.name,
    this.myId,
    this.content,
    this.fileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId, name, myId, fileUrl, content];

  MessageState copyWith(
      {String? userId,
      String? name,
      String? myId,
      String? content,
      String? fileUrl}) {
    return MessageState(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      myId: myId ?? this.myId,
      content: content ?? this.content,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
