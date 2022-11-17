part of 'message_cubit.dart';

class MessageState extends Equatable {
  final LoadStatus? loadData;
  final String? userId;
  final String? name;
  final String? myId;
  final String? content;
  final String? fileUrl;
  final String? messageGroupId;
  final List<MessageEntity> messageList;

  const MessageState({
    this.userId,
    this.loadData = LoadStatus.initial,
    this.name,
    this.myId,
    this.content,
    this.fileUrl,
    this.messageGroupId,
    this.messageList = const [],
  });

  @override
  List<Object?> get props => [
        loadData,
        userId,
        name,
        myId,
        fileUrl,
        content,
        messageList,
        messageGroupId
      ];

  MessageState copyWith({
    String? userId,
    LoadStatus? loadData,
    String? name,
    String? myId,
    String? content,
    String? fileUrl,
    String? messageGroupId,
    List<MessageEntity>? messageList,
  }) {
    return MessageState(
      loadData: loadData ?? this.loadData,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      myId: myId ?? this.myId,
      content: content ?? this.content,
      fileUrl: fileUrl ?? this.fileUrl,
      messageGroupId: messageGroupId ?? this.messageGroupId,
      messageList: messageList ?? this.messageList,
    );
  }
}
