import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';

@immutable
class Message {
   String title;
   String body;
   EarthquakeModel e;

   Message({
     this.title,
     this.body,
     this.e,
  });
}