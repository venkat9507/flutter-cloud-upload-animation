



import 'package:data_backup_animation/data_backup_animation/data_backup_home.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 500);
enum DataBackupState {
  initial,
  start,
  end,
}

class DataBackupInitialPage extends StatefulWidget {
  const DataBackupInitialPage({Key key, this.onAnimationStarted, this.progressAnimation}) : super(key: key);
  final VoidCallback  onAnimationStarted;
  final Animation<double> progressAnimation;


  @override
  _DataBackupInitialPageState createState() => _DataBackupInitialPageState();
}

class _DataBackupInitialPageState extends State<DataBackupInitialPage> {
  DataBackupState _currentState = DataBackupState.initial;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Text('Cloud storage',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,

          ),),
        ),
        if(_currentState == DataBackupState.end)
          Expanded(
            flex: 2,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 1.0,end: 1.0),
                duration: _duration,
              builder: (_,value,child){
                  return Opacity(opacity: value,
                  child: child,);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Uploading files',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,

                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ProgressCounter(widget.progressAnimation),
                    ),
                  ))
                ],
              ),
            ),
          ),
        if(_currentState != DataBackupState.end)
        Expanded(
          flex: 2,
          child: TweenAnimationBuilder(
            tween: Tween(begin: 1.0,end: _currentState != DataBackupState.initial ? 0.0 : 1.0),
            duration: _duration,
            onEnd: (){
              setState(() {
                _currentState = DataBackupState.end;
              });
    },
            builder: (_,value,child){
              return Opacity(opacity: value,
              child: Transform.translate(
                  offset: Offset(0.0, 100 * value),
                  child: child),);
    },
            child: Column(
              children: [
                Text('last backup:'),
                SizedBox(
                  height: 5,
                ),
                Text('10 march 2021',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: _duration,
          child:  _currentState == DataBackupState.initial ? InkWell(
            onTap: (){
              setState(() {
                _currentState = DataBackupState.start;
              });
              widget.onAnimationStarted();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: mainDataBackupColor,
                ),
                height: MediaQuery.of(context).size.height * 0.05,

                  child: Center(child: Text('Create Backup',style: TextStyle(color: Colors.white),)),
                  ),
            ),
          ) : OutlineButton(
              child: Text('Cancel',style: TextStyle(color: mainDataBackupColor,),),
              onPressed: null)
        )
      ],
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  ProgressCounter(Animation<double> animation) : super(listenable: animation);

  double get value => (listenable as Animation).value;
  @override
  Widget build(BuildContext context) {
    return Text('${(value *100).truncate().toString()} %');
  }
}
