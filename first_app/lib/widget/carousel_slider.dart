import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/model/model_movie.dart';
import 'package:first_app/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  // final List<Movie> movies;
  final dynamic movies;
  CarouselImage({this.movies});
  _CarouselIamgeState createState() => _CarouselIamgeState();
}

class _CarouselIamgeState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;

  int _currentPage = 0;
  late String _currentKeyword;
  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((e) => Image.asset('./images/' + e.poster)).toList();
    keywords = movies.map((e) => e.keyword).toList();
    likes = movies.map((e) => e.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      likes[_currentPage]
                          ? IconButton(
                              onPressed: () {}, icon: Icon(Icons.check))
                          : IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                          Padding(padding: EdgeInsets.all(3)),
                          Text(
                            "재생",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) {
                                return DetailScreen(
                                    movie: movies[_currentPage]);
                              }));
                        },
                        icon: Icon(
                          Icons.info,
                        ),
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currnetPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currnetPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }
  return results;
}
