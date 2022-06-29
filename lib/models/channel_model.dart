

import 'package:butunlemeodev/models/video_model.dart';

class Channel{
  final dynamic id;
  final dynamic title;
  final dynamic profilePictureUrl;
  final dynamic subscriberCount;
  final dynamic videoCount;
  final dynamic uploadPlaylistId;
   List<Video?>  videos;

  Channel({
    required this.id,
    required this.title,
    required this.profilePictureUrl,
    required this.subscriberCount,
    required this.videoCount,
    required this.uploadPlaylistId,
    required this.videos,
  });

  factory Channel.fromMap(Map<dynamic, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
      videos:  map ['videos'] ??'' ,
    );
  }
}