import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recorder/models/AudioModel.dart';
import 'package:recorder/models/CollectionModel.dart';
import 'package:recorder/Rest/Audio/AudioProvider.dart';
import 'package:recorder/Rest/Playlist/PlaylistProvider.dart';
import 'package:rxdart/rxdart.dart';

class HomeState{
  List<CollectionItem> collections;
  List<AudioItem> audios;
  bool loading;
  bool errors;
  HomeState({
    @required this.collections,
    @required this.audios,
    @required this.loading,
    @required this.errors,
  });
}

class HomeController{
  Function(List<CollectionItem> list) onLoadCollections;
  Function(List<AudioItem> list) onLoadAudios;

  List<CollectionItem> collections;
  List<AudioItem> audios;

  final BehaviorSubject _streamController = BehaviorSubject<HomeState>();

  get stream => _streamController.stream;
  HomeController({this.onLoadCollections, this.onLoadAudios}) { load(); }

  load() async {
    loadAudios();
    loadCollections();
  }

  loadCollections() async {
    collections = await PlaylistProvider.getAll();
    onLoadCollections(collections);
    _streamController.sink.add(HomeState(collections: collections, audios: audios, loading: false, errors: false));
  }

  loadAudios() async {
    audios = await AudioProvider.getAll();
    onLoadAudios(audios);
    _streamController.sink.add(HomeState(collections: collections, audios: audios, loading: false, errors: false));
  }

  dispose(){
    _streamController.close();
  }

}