import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'data_backup_home.dart';

class DataBackupCompletedPage extends AnimatedWidget {
  DataBackupCompletedPage({Animation<double> endingAnimation})
      : super(listenable: endingAnimation);
  Animation get animation => (listenable as Animation);
  @override
  Widget build(BuildContext context) {
    return animation.value > 0
        ? Positioned.fill(
          child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomPaint(
                        foregroundPainter: _DataBackupCompletedPainter(animation),
                        child: Container(
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),

                  TweenAnimationBuilder(
                    tween: Tween(begin: 0.0,end: 1.0),
                    duration: Duration(milliseconds: 400,),
                    onEnd: (){

                    },
                    builder: (_,value,child){
                      return Opacity(opacity: value,
                        child: Transform.translate(
                            offset: Offset(0.0, 50 * (1- value),),
                            child: child),);},

                    child: Column(
                      children: [
                        Text(
                          'data has successfully\nuploaded',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        OutlineButton(
                          child: Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: mainDataBackupColor,
                                ),
                              )),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
        )
        : SizedBox.shrink();
  }
}

class _DataBackupCompletedPainter extends CustomPainter {

  _DataBackupCompletedPainter(
      this.animation,
      ): super(repaint:  animation);
  final Animation<double> animation;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint()..color = mainDataBackupColor..style = PaintingStyle.stroke..strokeWidth = 1.0;
    final circlePath = Path();
    circlePath.addArc(Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: size.width, height: size.height), vector.radians(-90.0), vector.radians(360.0 * animation.value));

    final leftline = size.width * 0.2;
    final rightline = size.height * 0.3;

    final leftPercent = animation.value > 0.5 ? 1.0 : animation.value / 0.5;
    final rightPercent = animation.value > 0.5 ? 0.0 : (animation.value - 0.5)/ 0.5;

    canvas.save();

    canvas.translate(size.width /3, size.height /2);
    canvas.rotate(vector.radians(-45));
    canvas.drawLine(Offset.zero, Offset(0.0, leftline * leftPercent), paint);
    canvas.drawLine(Offset(0.0, leftline), Offset(rightline * leftPercent, leftline ), paint);
    canvas.restore();
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  }

