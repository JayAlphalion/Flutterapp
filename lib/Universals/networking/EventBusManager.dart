import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';


class EventBusManager{
  static final EventBus chatBusManager= EventBus();
  static final EventBus getNewLoadRequestData=EventBus();
  static final EventBus userJoinedOnRoom=EventBus();
  static final EventBus messageBox=EventBus();
  static final EventBus messageResponse=EventBus();
  static final EventBus audioRecorderEventBuss=EventBus();
  static final EventBus videoRecorderEventBuss=EventBus();
}