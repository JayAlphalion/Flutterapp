import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
    required this.client,
    required this.channel,
  }) : super(key: key);

  final StreamChatClient client;

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      home: StreamChannel(
        channel: channel,
        child: const ChannelPage(),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Chat'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
        backgroundColor: Color(0xff1C5AA3),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            // Set border width
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Text(
                            "intransit",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, //font color
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            // Set border width
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Text(
                            "ETA- 12:09 AM",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, //font color
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Load No: 9180",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, //font color
                          ),
                        ),
                        Text(
                          "Dispatch No: 918099",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, //font color
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Customer: XPO Logistics",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, //font color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //   StreamChannelHeader(),
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}
