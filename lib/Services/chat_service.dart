import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatService {
  var client;
  var channel;
  String a = 'fk2dvf4yen73';
  ChatService() {
    client = StreamChatClient(
      a,
      logLevel: Level.INFO,
    );
  }

  initChat(
      String id, String token, String channelId, String channelName) async {
    channel = client.channel(channelName, id: channelId);
    await client.connectUser(
      User(id: id),
      token,
    );

    await channel.watch();
  }
}
