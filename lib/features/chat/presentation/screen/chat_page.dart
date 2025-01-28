import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat/features/auth/login/presentation/screen/login_page.dart';
import 'package:my_chat/features/chat/presentation/controller/chat_cubit.dart';
import '../../../../core/utililes/constants.dart';
import '../../data/model/message.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';

  final _controller = ScrollController();
  List<Message> messagesList = [];
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(" "),
            Image.asset(
              kLogo,
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Are you sure you want to log out?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, LoginPage.id);
                                  },
                                  child: const Text(
                                    'Log Out',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                'assets/images/logout.png',
                height: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/chatBackground.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child:
                    //to make state of messages fixed
                    BlocBuilder<ChatCubit, ChatState>(
                  // BlocConsumer<ChatCubit, ChatState>(
                  // listener: (context, state) {
                  //   if (state is ChatSuccess) {
                  //     messagesList = state.messages;
                  //   }
                  // },
                  builder: (context, state) {
                    var messagesList =
                        BlocProvider.of<ChatCubit>(context).messagesList;

                    return ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : ChatBubbleForFriend(message: messagesList[index]);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.emoji_emotions_outlined,
                            color: Colors.black54),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          cursorColor: Colors.black87,
                          onSubmitted: (data) {
                            BlocProvider.of<ChatCubit>(context).sendMessage(
                              message: data,
                              email: email as String,
                            );
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          decoration: InputDecoration(
                            hintText: 'Type message....',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: kPrimaryColor),
                        onPressed: () {
                          final data = controller.text;
                          BlocProvider.of<ChatCubit>(context).sendMessage(
                            message: data,
                            email: email as String,
                          );

                          if (data.isNotEmpty) {
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
