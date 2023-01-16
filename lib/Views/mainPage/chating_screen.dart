// import 'package:alpha_app/utils/AppColors.dart';
// import 'package:flutter/material.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// import '../../Model/chat_model.dart';
// import '../../Services/chat_service.dart';
// import '../../Services/locator.dart';
// import '../../widgets/chat_screen.dart';

// class ChattingPage extends StatefulWidget {
//   final ChatModel chat;
//   ChattingPage({Key? key, required this.chat}) : super(key: key);

//   @override
//   State<ChattingPage> createState() => _ChattingPageState();
// }

// class _ChattingPageState extends State<ChattingPage> {
//   ChatService chatService = locator<ChatService>();

//   @override
//   void initState() {
//     initChat();

//     super.initState();
//   }

//   initChat() {
//     ChatModel? chat = widget.chat; //  await checkUserAndInitiateChat();
//     chatService.initChat(
//         chat.userId, chat.token, chat.channelId, chat.channelName);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner:false,
//       builder: (context, widget) {
//         return StreamChat(
//           client: chatService.client,
//           child: widget,
//         );
//       },
//       home: widget.chat.channelId == null || widget.chat.channelId.isEmpty
//           ? Scaffold(
//               // drawer: MyDrawer(),
//               appBar: AppBar(
//                 leading: Builder(
//                   builder: (context) => IconButton(
//                     icon: new Icon(Icons.menu),
//                     onPressed: () => Scaffold.of(context).openDrawer(),
//                   ),
//                 ),
//                 title: const Text('Chat'),
//                 actions: const [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                     child: Icon(Icons.more_vert),
//                   ),
//                 ],
//                 backgroundColor: const Color(0xff1C5AA3),
//               ),
//               body: const Center(
//                 child: Card(
//                     child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text("No load assigned",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           color: Colors.teal)),
//                 )),
//               ),
//             )
//           : chatService.channel == null
//               ? Scaffold(
//                   // drawer: MyDrawer(),
//                   appBar: AppBar(
//                     leading: Builder(
//                       builder: (context) => IconButton(
//                         icon: new Icon(Icons.menu),
//                         onPressed: () => Scaffold.of(context).openDrawer(),
//                       ),
//                     ),
//                     title: const Text('Chat'),
//                     actions: const [
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Icon(Icons.more_vert),
//                       ),
//                     ],
//                     backgroundColor: AppColors.primaryColor
//                   ),
//                   body: const Center(
//                     child: CircularProgressIndicator(),
//                   ))
//               : StreamChannel(
//                   channel: chatService.channel,
//                   child: const ChatScreen(),
//                   showLoading: true,
//                 ),
//     );
//   }
// }

