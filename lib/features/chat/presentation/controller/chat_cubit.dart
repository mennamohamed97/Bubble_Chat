import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../../core/utililes/constants.dart';
import '../../data/model/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
//to make state of messages fixed
  List<Message> messagesList = [];
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {kMessage: message, kCreatedAt: DateTime.now(), 'id': email},
      );
    } on Exception catch (e) {
      //can but if message failed to sent
    }
  }

  void getMessages() {
    // This is the stream, so we need to listen to it like a StreamBuilder
    // `event` includes all docs of the collection
    // `event` is of type snapshot, so it includes all data
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      // List<Message> messagesList = [];
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc.data() as Map<String, dynamic>));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }

  //  to track what happened in states
  //replace with bloc observer
  // @override
  // void onChange(Change<ChatState> change) {
  //   print(change);
  //   super.onChange(change);
  // }
}
