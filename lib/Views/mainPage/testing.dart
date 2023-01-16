// // @dart=2.9
// import 'dart:io';

// import 'package:alpha_app/Dialogs/SelectLoadDialog.dart';
// import 'package:alpha_app/GetXController/AttachmentController.dart';
// import 'package:alpha_app/Model/ChatModel.dart';
// import 'package:alpha_app/Model/LoadDataModel.dart';
// import 'package:alpha_app/Model/SocketChatModel.dart';
// import 'package:alpha_app/Model/chat_model.dart';
// import 'package:alpha_app/Services/chat_service.dart';
// import 'package:alpha_app/Services/locator.dart';
// import 'package:alpha_app/Views/LocalImagePreviewScreen.dart';
// import 'package:alpha_app/helper/ScanController.dart';
// import 'package:alpha_app/networking/EventBusManager.dart';
// import 'package:alpha_app/networking/SocketHelper.dart';
// import 'package:alpha_app/utils/AppColors.dart';
// import 'package:alpha_app/utils/Constants.dart';
// import 'package:alpha_app/utils/ImageUtils.dart';
// import 'package:alpha_app/utils/SharedPrefConstant.dart';
// import 'package:alpha_app/widgets/ChatItemWidget.dart';
// import 'package:alpha_app/widgets/ChatLoadingShimmer.dart';
// import 'package:alpha_app/widgets/IconWithTitle.dart';
// import 'package:alpha_app/widgets/dwarer.dart';
// import 'package:edge_detection/edge_detection.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:async';
// import 'dart:developer';
// import 'dart:io' as io;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart' as firebase_core;
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// import '../../save_as/save_as.dart';

// // import 'save_as/save_as.dart';

// class ChatTabScreen extends StatefulWidget {
//   final ChatModel chat;
//   ChatTabScreen({Key key, this.chat}) : super(key: key);

//   @override
//   State<ChatTabScreen> createState() => _ChatTabScreenState();
// }

// class _ChatTabScreenState extends State<ChatTabScreen> {
//   final ImagePicker _picker = ImagePicker();
//   ScrollController controller = ScrollController();
//   TextEditingController messageController = new TextEditingController();
//   List<ChatMessage> messages = [];
//   bool isAttachment = true;
//   ChatService chatService = locator<ChatService>();
//   bool dataLoading = true;

//   @override
//   void initState() {
//     initChat();

//     super.initState();
//   }

//   initChat() {
//     // SocketService().joinRoom();
//     EventBusManager.userJoinedOnRoom.on().listen((event) {
//       dataLoading = false;
//       if (mounted) setState(() {});
//     });

//     EventBusManager.messageBox.on().listen((event) {
//       //debugger();
//       //print(event);
//       msgReceive(SocketChatModel(
//         createdAt: event['message']['created_at'],
//         msgBody: event['message']['msqBody'],
//         url: event['message']['url'],
//         deletedForEveryOne: event['message']['deletedForEveryone'],
//         deltedForMe: event['message']['deletedForMe'],
//         from: event['message']['deletedForMe'],
//         isSeen: event['message']['isSeen'],
//         seenBy: event['message']['seenBy'],
//         to: event['message']['to'],
//         typeOfMsg: event['message']['typeOfMsg'],
//         userToken: event['message']['user_token'],
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
//     return Scaffold(
//       backgroundColor: AppColors.chatBgScreenColor,
//       drawer: MyDrawer(),
//       appBar: AppBar(
//           leading: Builder(
//             builder: (context) => IconButton(
//               icon: new Icon(Icons.menu),
//               onPressed: () => Scaffold.of(context).openDrawer(),
//             ),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Chat'),
//               // Text(
//               //   '12/12/2022',
//               //   style: TextStyle(
//               //       color: Colors.white,
//               //       fontSize: 12,
//               //       fontWeight: FontWeight.w400),
//               // ),
//             ],
//           ),
//           actions: const [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Icon(Icons.more_vert),
//             ),
//           ],
//           backgroundColor: AppColors.primaryColor),
//       body: dataLoading == true
//           ? Container(
//               height: Get.height / 1,
//               child: ListView.builder(
//                   itemCount: 20,
//                   itemBuilder: ((context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(
//                           left: 10, top: 10, bottom: 10, right: 10),
//                       child: Container(
//                           child: Shimmer.fromColors(
//                               baseColor: Colors.grey[300],
//                               highlightColor: Colors.grey[500],
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.black38,
//                                 ),
//                                 height: 50,
//                                 width: Get.width / 1,
//                                 //
//                               ))),
//                     );
//                   })))
//           : Stack(
//               children: <Widget>[
//                 messages.length == 0
//                     ? ListView(
//                         controller: controller,
//                         children: [
//                           Container(
//                               height: Get.height / 1.4,
//                               child: Center(
//                                 child: Lottie.asset(
//                                   ImageUtils.EMPTY_MESSAGE_GIT,
//                                 ),
//                               ))
//                         ],
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(bottom: 50),
//                         child: ListView.builder(
//                             controller: controller,
//                             itemCount: messages.length,
//                             reverse: false,
//                             shrinkWrap: true,
//                             padding: EdgeInsets.only(top: 10, bottom: 10),
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (BuildContext context, index) {
//                               return messages[index].messageType ==
//                                       Constant.TextMessage
//                                   ? TextChatBox(
//                                       chatMessage: messages[index],
//                                     )
//                                   :
//                                   // Container();

//                                   ChatContentBox(
//                                       task: _uploadTasks[index],
//                                       onDismissed: () =>
//                                           _removeTaskAtIndex(index),
//                                       onDownloadLink: () {
//                                         return getUrl(
//                                             _uploadTasks[index].snapshot.ref);
//                                       },
//                                       onDownload: () {
//                                         if (kIsWeb) {
//                                           return _downloadBytes(
//                                               _uploadTasks[index].snapshot.ref);
//                                         } else {
//                                           return _downloadFile(
//                                               _uploadTasks[index].snapshot.ref);
//                                         }
//                                       },
//                                       chatMessage: messages[index],
//                                       index: index);
//                             }),
//                       ),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: GetBuilder<AttachmentController>(
//                       // specify type as Controller
//                       init:
//                           AttachmentController(), // intialize with the Controller
//                       builder: (attachmentController) {
//                         return Container(
//                           padding:
//                               EdgeInsets.only(left: 10, bottom: 10, top: 10),
//                           height: 60,
//                           width: double.infinity,
//                           color: Colors.white,
//                           child: Row(
//                             children: <Widget>[
//                               GestureDetector(
//                                 onTap: () {
//                                   cameraClickHandler();
//                                 },
//                                 child: Container(
//                                   height: 30,
//                                   width: 30,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.primaryColor,
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   child: Icon(
//                                     Icons.camera_alt_outlined,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 15,
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   onChanged: (val) {
//                                     if (val.isEmpty) {
//                                       attachmentController.changeState(true);
//                                     } else {
//                                       attachmentController.changeState(false);
//                                     }
//                                   },
//                                   controller: messageController,
//                                   decoration: InputDecoration(
//                                       hintText: "Write message...",
//                                       hintStyle:
//                                           TextStyle(color: Colors.black54),
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 15,
//                               ),
//                               attachmentController.isAttachmentActive == true
//                                   ? FloatingActionButton(
//                                       onPressed: () {
//                                         sentAttachment();
//                                       },
//                                       child: Icon(
//                                         Icons.attachment_outlined,
//                                         color: Colors.white,
//                                         size: 25,
//                                       ),
//                                       backgroundColor: AppColors.primaryColor,
//                                       elevation: 0,
//                                     )
//                                   : FloatingActionButton(
//                                       onPressed: () async {
//                                         messages.add(ChatMessage(
//                                             messageContent:
//                                                 'socketChatData.msgBody',
//                                             messageOwner: 'sendBy',
//                                             messageType: 'sendBy',
//                                             fileName: ''));
//                                         messageController.clear();
//                                         setState(() {
//                                           _uploadTasks = [
//                                             ..._uploadTasks,
//                                             null
//                                           ];
//                                         });
//                                         //  setState(() {});
//                                         _scrollToBottom();
//                                         // await sendMessage();
//                                         // attachmentController.changeState(true);
//                                       },
//                                       child: Icon(
//                                         Icons.send,
//                                         color: Colors.white,
//                                         size: 18,
//                                       ),
//                                       backgroundColor: AppColors.primaryColor,
//                                       elevation: 0,
//                                     ),
//                             ],
//                           ),
//                         );
//                       }),
//                 ),
//               ],
//             ),
//     );
//   }

//   void cameraClickHandler() {
//     showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Wrap(
//             children: [
//               InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                     openScanningProcess();
//                     // scanImageFromCamera();
//                   },
//                   child: iconWithTitle(
//                       imageFile: ImageUtils.Scan_file,
//                       title: 'Scan Current Load\'s BOL')),
//               SizedBox(
//                 height: 20,
//               ),
//               InkWell(
//                   onTap: () {
//                     scanImageFromCamera();
//                   },
//                   child: iconWithTitle(
//                       imageFile: ImageUtils.Scan_file, title: 'Scan')),
//               SizedBox(
//                 height: 20,
//               ),
//               InkWell(
//                 onTap: () {
//                   takeImageFromGallery();
//                 },
//                 child: iconWithTitle(
//                     imageFile: ImageUtils.Image_file, title: 'Image'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void scanImageFromCamera() async {
//     Navigator.pop(context);

//     showDialog<LoadModel>(
//         context: context,
//         //barrierColor: Colors.white.withOpacity(0),
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return SelectLoadDialog();
//         }).then((value) {
//       if (value != null) {
//         openScanningProcess();
//         //takeImageFromCamera();
//       }
//     });
//   }

//   void takeImageFromGallery() async {
//     Navigator.pop(context);
//     PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
//     // /print(pickedImage);
//     messages.add(ChatMessage(
//         messageContent: 'this is ',
//         messageOwner: Constant.Sender,
//         messageType: Constant.ImageMessage,
//         fileName: file.path));
//     _scrollToBottom();
//     handleUploadType(file);
//   }

//   void sentAttachment() async {
//     FilePickerResult result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: [
//         'jpg',
//         'pdf',
//         'xlsx',
//         'docx',
//         'dot',
//         'dotx',
//         'txt',
//       ],
//     );

//     if (result != null) {
//       File file = File(result.files.single.path);
//       messages.add(
//         ChatMessage(
//             messageContent: 'this is ',
//             messageOwner: Constant.Sender,
//             messageType: Constant.ImageMessage,
//             fileName: file.path),
//       );
//       _scrollToBottom();
//       handleUploadType(PickedFile(file.path));
//     } else {
//       // User canceled the picker
//     }
//   }

//   void takeImageFromCamera() async {
//     var pickedImage = await _picker.pickImage(source: ImageSource.camera);
//     print(pickedImage);
//   }

//   _scrollToBottom() {
//     if (controller.hasClients)
//       controller.jumpTo(controller.position.maxScrollExtent);
//   }

//   List<dynamic> _uploadTasks = [];
// //firebase_storage.UploadTask
//   /// The user selects a file, and the task is added to the list.
//   Future<firebase_storage.UploadTask> uploadFile(PickedFile file) async {
//     if (file == null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('No file was selected'),
//       ));
//     }

//     firebase_storage.UploadTask uploadTask;

//     // Create a Reference to the file
//     firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('chatdoc')
//         .child('/' + file.path.split('/').last);

//     final metadata = firebase_storage.SettableMetadata(
//         contentType: 'image/jpeg',
//         customMetadata: {'picked-file-path': file.path});

//     if (kIsWeb) {
//       uploadTask = ref.putData(await file.readAsBytes(), metadata);
//     } else {
//       uploadTask = ref.putFile(io.File(file.path), metadata);
//     }

//     return Future.value(uploadTask);
//   }

//   /// A new string is uploaded to storage.
//   firebase_storage.UploadTask uploadString() {
//     const String putStringText =
//         'This upload has been generated using the putString method! Check the metadata too!';

//     // Create a Reference to the file
//     firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('playground')
//         .child('/put-string-example.txt');

//     // Start upload of putString
//     return ref.putString(putStringText,
//         metadata: firebase_storage.SettableMetadata(
//             contentLanguage: 'en',
//             customMetadata: <String, String>{'example': 'putString'}));
//   }

//   /// Handles the user pressing the PopupMenuItem item.
//   Future<void> handleUploadType(PickedFile file) async {
//     // PickedFile file =
//     //         await ImagePicker().getImage(source: ImageSource.gallery);
//     firebase_storage.UploadTask task = await uploadFile(file);
//     if (task != null) {
//       setState(() {
//         _uploadTasks = [..._uploadTasks, task];
//       });

//       uploadFile(file);
//     }
//   }

//   Future<void> _downloadBytes(firebase_storage.Reference ref) async {
//     final bytes = await ref.getData();
//     debugger();
//     print(ref);
//     // Download...
//     await saveAsBytes(bytes, 'some-image.jpg');
//   }

//   Future<void> _downloadLink(firebase_storage.Reference ref) async {
//     final link = await ref.getDownloadURL();

//     await Clipboard.setData(ClipboardData(
//       text: link,
//     ));

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text(
//           'Success!\n Copied download URL to Clipboard!',
//         ),
//       ),
//     );
//   }

//   Future<String> getUrl(firebase_storage.Reference ref) async {
//     final link = await ref.getDownloadURL();
//     return link;
//   }

//   Future<void> _downloadFile(firebase_storage.Reference ref) async {
//     final io.Directory systemTempDir = io.Directory.systemTemp;
//     final io.File tempFile = io.File('${systemTempDir.path}/temp-${ref.name}');
//     if (tempFile.existsSync()) await tempFile.delete();

//     await ref.writeToFile(tempFile);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
//           'at path: ${ref.fullPath} \n'
//           'Wrote "${ref.fullPath}" to tmp-${ref.name}.txt',
//         ),
//       ),
//     );
//   }

//   void _removeTaskAtIndex(int index) {
//     setState(() {
//       _uploadTasks = _uploadTasks..removeAt(index);
//     });
//   }

//   void openScanningProcess() async {
//     String _imagePath = await ScanController().getImage();
//     if (_imagePath != null) {
//       messages.add(ChatMessage(
//           messageContent: 'this is ',
//           messageOwner: Constant.Sender,
//           messageType: Constant.ImageMessage,
//           fileName: _imagePath));
//       _scrollToBottom();
//       // setState(() {});
//       handleUploadType(PickedFile(_imagePath));
//     }
//   }

//   Future<String> getImage() async {
//     String imagePath;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       imagePath = await EdgeDetection.detectEdge;
//       print("$imagePath");
//     } on PlatformException catch (e) {
//       imagePath = e.toString();
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return '';

//     return imagePath;
//   }

//   Future<void> sendMessage() async {
//     SharedPreferences session = await SharedPreferences.getInstance();
//     String token = session.getString(SharedPrefConstant.TOKEN);
//     SocketService().sendMessage(SocketChatModel(
//         msgBody: messageController.text,
//         createdAt: '',
//         deletedForEveryOne: '',
//         deltedForMe: '',
//         deliveredTime: '',
//         from: '',
//         url: '',
//         isSeen: '',
//         seenBy: [],
//         to: '',
//         typeOfMsg: 'text',
//         userToken: token));
//   }

//   void msgReceive(SocketChatModel socketChatData) async {
//     print(socketChatData.toString());
//     //   SharedPreferences session = await SharedPreferences.getInstance();
//     //   String myToken = session.getString(SharedPrefConstant.TOKEN);
//     //   String sendBy = myToken == socketChatData.userToken
//     //       ? Constant.Sender
//     //       : Constant.Reciver;
//     //   String msgType = socketChatData.typeOfMsg;

//     messages.add(ChatMessage(
//         messageContent: 'socketChatData.msgBody',
//         messageOwner: 'sendBy',
//         messageType: 'sendBy',
//         fileName: ''));
//     messageController.clear();
//     setState(() {
//       _uploadTasks = [..._uploadTasks, null];
//     });
//     //  setState(() {});
//     _scrollToBottom();
//   }
// }
