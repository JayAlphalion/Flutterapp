// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:alpha_app/UserModules/DriverModules/Dialogs/SelectLoadDialog.dart';
import 'package:alpha_app/UserModules/DriverModules/GetXController/AttachmentController.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/LoadDataModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/SocketChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/ChatHistoryApiResponse.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/Universals/HelperViews/LocalImagePreviewScreen.dart';
import 'package:alpha_app/UserModules/DriverModules/bloc/ChatDataBloc.dart';
import 'package:alpha_app/Universals/helper/BgDecorationHelper.dart';
import 'package:alpha_app/Universals/helper/FileTypeHelper.dart';
import 'package:alpha_app/Universals/helper/ScanController.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/networking/EventBusManager.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/networking/SocketHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/AudioComponents/AudioFileForReceiver.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/AudioComponents/AudioFileForSender.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/AudioRecorderWidget.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/ImageOrDocComponents/ImageOrDocItemForReceiver.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/ImageOrDocComponents/ImageOrDocItemForSender.dart';
// import 'package:alpha_app/widgets/ChatLoadingShimmer.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/IconWithTitle.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/VideoComponents/VideoInChatWidgetForReceiver.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/VideoComponents/VideoInChatWidgetForSender.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/DrawersPage/drawer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_chat_flutter/scrollable_positioned_list/scrollable_positioned_list.dart';

// import 'save_as/save_as.dart';

class ChatTabScreen extends StatefulWidget {
  final groupId;
  final groupName;
  ChatTabScreen({this.groupId, this.groupName});

  @override
  State<ChatTabScreen> createState() => _ChatTabScreenState();
}

class _ChatTabScreenState extends State<ChatTabScreen> {
  final ImagePicker _picker = ImagePicker();
  ScrollController controller = ScrollController();
  TextEditingController messageController = new TextEditingController();
  List<ChatMessage> messages = [];
  bool isAttachment = true;
  ChatDataBloc chatDataBloc;
  // ChatService chatService = locator<ChatService>();
  bool dataLoading = true;
  String recordedAudioFile;
  File videoRecordedFile;
  int _recordDuration = 0;
  Timer _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState> _recordSub;
  RecordState _recordState = RecordState.stop;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  void initState() {
    chatDataBloc = ChatDataBloc();
    _audioSetup();
    _callGetChatHistoryApi();
    _handleChatHistoryResponse();
    initChat();

    super.initState();
  }

  _audioSetup() {
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });
  }

  Future<void> _start() async {
    recordedAudioFile = null;
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        // debugger();
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    try {
      final path = await _audioRecorder.stop();

      if (path != null) {
        // recordedAudioFile = path;

        sendRecordedAudio(File(path));
      }
    } catch (e) {
      // debugger();
      print(e);
    }
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  initChat() {
    EventBusManager.messageBox.on().listen((event) async {
      SharedPreferences session = await SharedPreferences.getInstance();
      String myToken = session.getString(SharedPrefConstant.USER_TOKEN);
      if (event['message']['typeOfMsg'] != 'text') {
        if (myToken == event['message']['userToken']) {
          //if both user same just ignore text messages.
        } else {
          print(event);
          msgReceive(SocketChatModel(
              userId: event['message']['userId'],
              messageId: event['message']['messageId'],
              createdAt: event['message']['createdAt'],
              msgBody: event['message']['text'],
              url: event['message']['url'],
              deletedForEveryOne: event['message']['deletedForEveryone'],
              deltedForMe: event['message']['deletedForMe'],
              from: event['message']['from'],
              isSeen: event['message']['isSeen'],
              seenBy: event['message']['seenBy'],
              to: event['message']['to'],
              typeOfMsg: event['message']['typeOfMsg'],
              userToken: event['message']['userToken'],
              fileName: event['message']['fileName'],
              groupId: event['message']['groupId']));
        }
      } else {
        //  debugger();
        // print(event);
        msgReceive(
          SocketChatModel(
              userId: event['message']['userId'],
              messageId: event['message']['messageId'],
              createdAt: event['message']['createdAt'],
              msgBody: event['message']['text'],
              url: event['message']['url'],
              deletedForEveryOne: event['message']['deletedForEveryone'],
              deltedForMe: event['message']['deletedForMe'],
              from: event['message']['from'],
              isSeen: event['message']['isSeen'],
              seenBy: event['message']['seenBy'],
              to: event['message']['to'],
              typeOfMsg: event['message']['typeOfMsg'],
              userToken: event['message']['userToken'],
              fileName: event['message']['fileName'],
              groupId: event['message']['groupId']),
        );
      }
    });

    EventBusManager.messageResponse.on().listen((event) {
      //  debugger();
      print(event);
    });
  }

  void _callGetChatHistoryApi() {
    Map parameter = {NetworkConstant.API_PARAM_GROUP_ID: widget.groupId};
    chatDataBloc.callGetChatHistoryApi(parameter);
  }

  void _handleChatHistoryResponse() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String myId = session.getString(SharedPrefConstant.USER_ID);

    chatDataBloc.getChatHistoryDataStream.listen((event) {
      // debugger();
      // print(event);
      try {
        ChatHistoryApiResponse v = ChatHistoryApiResponse.fromJson(event);

        for (int i = 0; i < v.messages.length; i++) {
          String sendBy = myId == v.messages[i].data.userId
              ? Constant.Sender
              : Constant.Reciver;
          messages.add(ChatMessage(
            messageId: v.messages[i].data.messageId.toString(),
            messageContent: v.messages[i].data.text,
            messageOwner: sendBy,
            messageType: v.messages[i].data.typeOfMsg == 'm4a'
                ? Constant.MusicFile
                : v.messages[i].data.typeOfMsg,
            fileName: v.messages[i].data.fileName,
            fileType: v.messages[i].data.typeOfMsg,
            url: v.messages[i].data.url,
            from: v.messages[i].data.from,
            dateTime: v.messages[i].data.createdAt,
            isHistory: true,
          ));

          _uploadTasks = [..._uploadTasks, null];
          setState(() {});
        }
      } catch (e) {
        print(e);
      }
      if (mounted) {
        setState(() {
          dataLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.groupName,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Load No.: 545676  Dispatch: 543213  Loc.:Kent, WA NW i-5',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: AppColors.primaryColor),
      body: dataLoading == true
          ? Container(
              height: Get.height / 1,
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: ListView.builder(
                  controller: controller,
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      child: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[500],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black38,
                                ),
                                height: 50,
                                width: Get.width / 1,
                                //
                              ))),
                    );
                  })))
          : Container(
              height: Get.height / 1,
              // decoration: BgDecorationHelper().chatBgDecoration(),
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: Stack(
                children: <Widget>[
                  messages.length == 0
                      ? ListView(
                          controller: controller,
                          children: [
                            Container(
                                height: Get.height / 1.4,
                                child: Center(
                                  child: Lottie.asset(
                                    ImageUtils.EMPTY_MESSAGE_GIT,
                                  ),
                                ))
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Container(
                            height: Get.height / 1,
                            child: ScrollablePositionedList.builder(
                                itemScrollController: itemScrollController,
                                itemPositionsListener: itemPositionsListener,
                                // controller: controller,
                                itemCount: messages.length,
                                // reverse: false,
                                // shrinkWrap: true,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                itemBuilder: (BuildContext context, index) {
                                  return messages[index].messageType ==
                                          Constant.TextMessage
                                      ? TextChatBox(
                                          chatMessage: messages[index],
                                        )
                                      : messages[index].messageType ==
                                              Constant.MusicFile
                                          ? messages[index].messageOwner ==
                                                      Constant.Sender &&
                                                  messages[index].isHistory ==
                                                      false
                                              ? AudioFileForSender(
                                                  task: _uploadTasks[index],
                                                  onDismissed: () =>
                                                      _removeTaskAtIndex(index),
                                                  onDownloadLink: () {
                                                    return getUrl(
                                                        _uploadTasks[index]
                                                            .snapshot
                                                            .ref);
                                                  },
                                                  chatMessage: messages[index],
                                                  index: index)
                                              : AudioFileForReceiver(
                                                  chatMessage: messages[index],
                                                )
                                          //for video type message
                                          : messages[index].messageType ==
                                                  Constant.VideoMessage

//for video messaging.

                                              ? messages[index].messageOwner ==
                                                          Constant.Sender &&
                                                      messages[index].isHistory ==
                                                          false
                                                  ?
                                                  //for sender
                                                  VideoInChatWidgetForSender(
                                                      task: _uploadTasks[index],
                                                      onDismissed: () =>
                                                          _removeTaskAtIndex(
                                                              index),
                                                      onDownloadLink: () {
                                                        return getUrl(
                                                            _uploadTasks[index]
                                                                .snapshot
                                                                .ref);
                                                      },
                                                      chatMessage:
                                                          messages[index],
                                                      index: index)
                                                  :
                                                  //for receiver
                                                  VideoInChatWidgetForReceiver(
                                                      chatMessage:
                                                          messages[index],
                                                      index: index)
                                              :
                                              //for doc or images.
                                              messages[index].messageOwner ==
                                                          Constant.Sender &&
                                                      messages[index].isHistory ==
                                                          false
                                                  ?
                                                  //for sender
                                                  ImageOrDocItemForSender(
                                                      task: _uploadTasks[index],
                                                      onDismissed: () =>
                                                          _removeTaskAtIndex(index),
                                                      onDownloadLink: () {
                                                        return getUrl(
                                                            _uploadTasks[index]
                                                                .snapshot
                                                                .ref);
                                                      },
                                                      chatMessage: messages[index],
                                                      index: index)
                                                  : ImageOrDocItemForReceiver(chatMessage: messages[index], index: index);
                                }),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GetBuilder<AttachmentController>(
                        init: AttachmentController(),
                        builder: (attachmentController) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: attachmentController.recordingStatus ==
                                        Constant.Recording ||
                                    attachmentController.recordingStatus ==
                                        Constant.Pause
                                ? AudioRecorderWidget(
                                    recordingStatus:
                                        attachmentController.recordingStatus,
                                    onCompletePressed: () {
                                      attachmentController
                                          .changeRecordingStatus(
                                              Constant.RecordingDone);

                                      _stop();
                                    },
                                    onPausePressed: () {
                                      attachmentController
                                          .changeRecordingStatus(
                                              Constant.Pause);
                                      _pause();
                                    },
                                    onResumed: () {
                                      attachmentController
                                          .changeRecordingStatus(
                                              Constant.Recording);
                                      _resume();
                                    },
                                  )
                                : TextField(
                                    // focusNode: focusNode,
                                    cursorColor: Colors.black,
                                    controller: messageController,
                                    minLines: 1,
                                    maxLines: 5,
                                    onChanged: (val) {
                                      if (val.isEmpty) {
                                        attachmentController.changeState(true);
                                      } else {
                                        attachmentController.changeState(false);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type Here",
                                      suffixIcon: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end, // added line
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          attachmentController
                                                      .isAttachmentActive ==
                                                  true
                                              ? InkWell(
                                                  onTap: () {
                                                    sentAttachment();
                                                  },
                                                  child: const Icon(
                                                    Icons.attachment_outlined,
                                                    color:
                                                        AppColors.primaryColor,
                                                    size: 30,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await sendTextMessage(
                                                        '', 'text', '');
                                                    messageController.clear();
                                                    attachmentController
                                                        .changeState(true);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(
                                                      Icons.send,
                                                      color: AppColors
                                                          .primaryColor,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                          attachmentController
                                                      .isAttachmentActive ==
                                                  true
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10, left: 10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      attachmentController
                                                          .changeRecordingStatus(
                                                              Constant
                                                                  .Recording);
                                                      _start();
                                                    },
                                                    child: Icon(
                                                      Icons.mic,
                                                      size: 25,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                      prefixIcon: InkWell(
                                        onTap: () {
                                          cameraClickHandler();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 25,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }

/**
 * This Method is responsible for showing user's side option for choose image or scan.
 */
  void cameraClickHandler() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    openScanningProcess();
                    // scanImageFromCamera();
                  },
                  child: iconWithTitle(
                      imageFile: ImageUtils.Scan_file,
                      title: 'Scan Current Load\'s BOL')),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    scanImageFromCamera();
                  },
                  child: iconWithTitle(
                      imageFile: ImageUtils.Scan_file, title: 'Scan')),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  takeImageFromGallery();
                },
                child: iconWithTitle(
                    imageFile: ImageUtils.Image_file, title: 'Image'),
              ),
            ],
          ),
        );
      },
    );
  }

/**
 * This Method is resposible for scan image from camera.
 */
  void scanImageFromCamera() async {
    Navigator.pop(context);

    showDialog<LoadModel>(
        context: context,
        //barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SelectLoadDialog();
        }).then((value) {
      if (value != null) {
        openScanningProcess();
        //takeImageFromCamera();
      }
    });
  }

/**
 * This Method is responsible for Take Image from gallery.
 */
  void takeImageFromGallery() async {
    Navigator.pop(context);
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);

    messages.add(ChatMessage(
        isHistory: false,
        messageId: '',
        messageContent: '',
        messageOwner: Constant.Sender,
        messageType: GetFile.getMsgType(file.path),
        fileName: file.path,
        from: '',
        dateTime: DateFormat('yyyy-MM-dd kk:mm a')
            .format(DateTime.now())
            .toString()));
    _scrollToBottom();
    // debugger();
    // print(messages);
    sendAttachmentToTheServer(File(file.path));
  }

/**
 * This Method is Responsible for sent attachment to the server.
 */
  void sentAttachment() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      messages.add(
        ChatMessage(
            fileType: file.path.split('.').last,
            url: '',
            isHistory: false,
            messageId: '',
            messageContent: '',
            messageOwner: Constant.Sender,
            messageType: GetFile.getMsgType(file.path),
            fileName: file.path,
            from: '',
            dateTime: DateFormat('yyyy-MM-dd kk:mm a')
                .format(DateTime.now())
                .toString()),
      );
      // debugger();
      // print(messages);
      _scrollToBottom();
      sendAttachmentToTheServer(file);
    } else {
      // User canceled the picker
    }
  }

  void sendAttachmentToTheServer(File file) async {
    await handleUploadTask(PickedFile(file.path));
  }

/**
 * This Method is responsible for Auto Scroll.
 */
  _scrollToBottom() {
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    itemScrollController.scrollTo(
        index: messages.length,
        duration: Duration(microseconds: 5),
        curve: Curves.easeIn);
  }

  List<dynamic> _uploadTasks = [];

/**
 * This Method is responsible for Upload files to the server.
 * [file] required parameter is file which you want to upload.
 *  */
  Future<firebase_storage.UploadTask> uploadFile(PickedFile file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
    }

    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chatdoc')
        .child('/' + file.path.split('/').last);

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);

      return Future.value(uploadTask);
    }
  }

/**
 * This Method is Resonsible for Handle Files or images uploading task.
 * [file] Required parameter is file which you want to upload.
 */
  Future<dynamic> handleUploadTask(PickedFile file) async {
    try {
      firebase_storage.UploadTask task = await uploadFile(file);
      if (task != null) {
        if (mounted) {
          setState(() {
            _uploadTasks = [..._uploadTasks, task];
          });
        }

        uploadFile(file);

        task.whenComplete(() async {
          String finalUrl = await getUrl(task.snapshot.ref);
          await sendTextMessage(
              finalUrl, file.path.split('.').last, file.path.split('/').last);
        });
      }
    } catch (e) {
      // debugger();
      print(e);
    }
  }

// /**
//  * This Method is Responsible for download files or image from firebase.
//  * [ref] Refrence is a required parameter.
//  */
//   Future<void> _downloadBytes(firebase_storage.Reference ref) async {
//     final bytes = await ref.getData();
//     await saveAsBytes(bytes, 'some-image.jpg');
//   }

/**
 * This Method is Responsible for Provide Download Files or Image link.
 * [ref] Refrence is a required parameter.
 */
  Future<void> _downloadLink(firebase_storage.Reference ref) async {
    final link = await ref.getDownloadURL();

    await Clipboard.setData(ClipboardData(
      text: link,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Success!\n Copied download URL to Clipboard!',
        ),
      ),
    );
  }

/**
 * This Method is Responsible for get File or Image Url.
 * [ref] Refrence is a required parameter.
 */
  Future<String> getUrl(firebase_storage.Reference ref) async {
    try {
      final link = await ref.getDownloadURL();
      return link;
    } catch (e) {
      getUrl(ref);
    }
  }

/**
 * This Method is Responsible for Download Files or Image from firebase..
 * [ref] Refrence is a required parameter.
 */
  Future<void> _downloadFile(firebase_storage.Reference ref) async {
    final io.Directory systemTempDir = io.Directory.systemTemp;
    final io.File tempFile = io.File('${systemTempDir.path}/temp-${ref.name}');
    if (tempFile.existsSync()) await tempFile.delete();

    await ref.writeToFile(tempFile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
          'at path: ${ref.fullPath} \n'
          'Wrote "${ref.fullPath}" to tmp-${ref.name}.txt',
        ),
      ),
    );
  }

/**
 * This Method is Responsible for Remove Uploading task from given index.
 * [index] Required Parameter is Index. 
 */
  void _removeTaskAtIndex(int index) {
    if (mounted) {
      setState(() {
        _uploadTasks = _uploadTasks..removeAt(index);
      });
    }
  }

/**
 * This Method is Responsible for Open & Scan Features.
 */
  void openScanningProcess() async {
    String _imagePath = await ScanController().getImage();
    if (_imagePath != null) {
      messages.add(
        ChatMessage(
            isHistory: false,
            messageId: '',
            messageContent: '',
            messageOwner: Constant.Sender,
            messageType: GetFile.getMsgType(_imagePath),
            fileName: _imagePath,
            from: '',
            dateTime: DateFormat('yyyy-MM-dd kk:mm a')
                .format(DateTime.now())
                .toString()),
      );
      _scrollToBottom();
      sendAttachmentToTheServer(File(_imagePath));
    }
  }

/**
 * This Method is responsible for Get Image from gallery.
 */
  Future<String> getImage() async {
    String imagePath = await ScanController().getImage();

    return imagePath;
  }

/**
 * This Method is responsible for Sent Message to the server.
 * [url] this paramter is [url] of uploaded files or images.
 * [type] this can be type of message like image or text message or files.
 * [name] This parameter will be file name if you are sending files or images.
 */

  Future<String> sendTextMessage(url, type, name) async {
    print(type);
    SharedPreferences session = await SharedPreferences.getInstance();
    String myToken = session.getString(SharedPrefConstant.USER_TOKEN);
    String userId = session.getString(SharedPrefConstant.DRIVERE_ID);

    print(DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now()).toString());
    SocketService().sendMessage(SocketChatModel(
        msgBody: messageController.text,
        createdAt:
            DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now()).toString(),
        deletedForEveryOne: '',
        deltedForMe: '',
        deliveredTime: '',
        from: '',
        url: url,
        isSeen: '',
        seenBy: [],
        to: '',
        typeOfMsg: type,
        fileName: name,
        userToken: myToken,
        groupId: widget.groupId,
        userId: userId));

    return '';
  }

/**
 * This Method is responsible for Receive message from Server.
 * [socketChatData] it will be object of server's response.
 */
  void msgReceive(SocketChatModel socketChatData) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String userId = session.getString(SharedPrefConstant.USER_ID);
    String sendBy =
        userId == socketChatData.userId ? Constant.Sender : Constant.Reciver;
    String msgType = socketChatData.typeOfMsg;
    // debugger();
    // print(sendBy);
    messages.add(ChatMessage(
        isHistory: false,
        messageId: socketChatData.messageId,
        messageContent: socketChatData.msgBody,
        messageOwner: sendBy,
        messageType: msgType,
        fileName: socketChatData.fileName,
        url: socketChatData.url,
        from: socketChatData.from,
        dateTime:
            DateFormat('yyyy-MM-dd kk:mm a').format(DateTime.now()).toString(),
        fileType: socketChatData.typeOfMsg));
    if (mounted) {
      setState(() {
        _uploadTasks = [..._uploadTasks, null];
      });
    }
    _scrollToBottom();
  }

  void sendRecordedAudio(File file) {
    messages.add(
      ChatMessage(
          fileType: file.path.split('.').last,
          url: '',
          isHistory: false,
          messageId: '',
          messageContent: '',
          messageOwner: Constant.Sender,
          messageType: Constant.MusicFile,
          fileName: file.path,
          from: '',
          dateTime: DateFormat('yyyy-MM-dd kk:mm a')
              .format(DateTime.now())
              .toString()),
    );
    sendAttachmentToTheServer(File(file.path));
  }
}
