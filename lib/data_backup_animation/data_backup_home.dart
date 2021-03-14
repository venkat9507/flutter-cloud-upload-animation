import 'package:data_backup_animation/data_backup_animation/data_backup_cloudPage.dart';
import 'package:flutter/material.dart';

import 'data_backup_completed.dart';
import 'data_backup_initial_page.dart';

const mainDataBackupColor = Color(0xFF5113AA);
const secondaryDataBackupColor = Color(0xFFBC53FA);
final backgroundColor = Colors.purpleAccent.shade100;


class DataBackupHome extends StatefulWidget {
  @override
  _DataBackupHomeState createState() => _DataBackupHomeState();
}

class _DataBackupHomeState extends State<DataBackupHome> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
Animation<double> _progressAnimation;
Animation<double> _cloudOutAnimation;
Animation<double> _endingAnimation;
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this,
    duration: Duration(
      seconds: 7,
    ));
    _progressAnimation = CurvedAnimation(parent: _animationController , curve: Interval(0.0, 0.65));
    _cloudOutAnimation = CurvedAnimation(parent: _animationController , curve: Interval(0.7, 0.85));
    _endingAnimation = CurvedAnimation(parent: _animationController , curve: Interval(0.8, 1.0));


    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            DataBackupInitialPage(
              progressAnimation: _progressAnimation,
              onAnimationStarted: (){
                _animationController.forward();
              },
            ),
            DataBackupCloudPage(
                progressAnimation :  _progressAnimation,
                cloudOutAnimation:  _cloudOutAnimation
            ),
            DataBackupCompletedPage(
                endingAnimation : _endingAnimation,
            )
          ],
        ),
      ),
    );
  }
}
