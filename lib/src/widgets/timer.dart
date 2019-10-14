// import 'dart:async';
// import 'package:flutter/material.dart';

// class WeekCountdown extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _WeekCountdownState();
// }

// class _WeekCountdownState extends State<WeekCountdown> {
//   Timer _timer;
//   DateTime _currentTime;

//   @override
//   void initState() {
//     super.initState();
//     _currentTime = DateTime.now();
//     _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void _onTimeChange(Timer timer) {
//     setState(() {
//       _currentTime = DateTime.now();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final startOfNextWeek = calculateStartOfNextWeek(_currentTime);
//     final remaining = startOfNextWeek.difference(_currentTime);

//     final days = remaining.inDays;
//     final hours = remaining.inHours - remaining.inDays * 24;
//     final minutes = remaining.inMinutes - remaining.inHours * 60;
//     final seconds = remaining.inSeconds - remaining.inMinutes * 60;

//     final formattedRemaining = '$days : $hours : $minutes : $seconds';

//     return Text(formattedRemaining,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25));
//   }
// }

// DateTime calculateStartOfNextWeek(DateTime time) {
//   final daysUntilNextWeek = 8 - time.weekday;
//   return DateTime(time.year, time.month, time.day + daysUntilNextWeek);
// }
library countdown.base;

// class CountDown {
//   /// reference point for start and resume
//   DateTime _begin;
//   Timer _timer;
//   Duration _duration;
//   Duration remainingTime;
//   bool isPaused = false;
//   StreamController<Duration> _controller;
//   Duration _refresh;
//   /// provide a way to send less data to the client but keep the data of the timer up to date
//   int _everyTick, counter = 0;
//   /// once you instantiate the CountDown you need to register to receive information
//   CountDown(Duration duration, {Duration refresh: const Duration(milliseconds: 10), int everyTick: 1}) {
//     _refresh = refresh;
//     _everyTick = everyTick;

//     this._duration = duration;
//     _controller = new StreamController<Duration>(onListen: _onListen, onPause: _onPause, onResume: _onResume, onCancel: _onCancel);
//   }
//   Stream<Duration> get stream => _controller.stream;
//   /// _onListen
//   /// invoke when the first subscriber has subscribe and not before to avoid leak of memory
//   _onListen() {
//     // reference point
//     _begin = new DateTime.now();
//     _timer = new Timer.periodic(_refresh, _tick);
//   }
//   /// the remaining time is set at '_refresh' ms accurate
//   _onPause() {
//     isPaused = true;
//     _timer.cancel();
//     _timer = null;
//   }
//   /// ...restart the timer with the new duration
//   _onResume() {
//     _begin = new DateTime.now();
//     _duration = this.remainingTime;
//     isPaused = false;
//     //  lance le timer
//     _timer = new Timer.periodic(_refresh, _tick);
//   }
//   _onCancel() {
//     // on pause we already cancel the _timer
//     if (!isPaused) {
//       _timer.cancel();
//       _timer = null;
//     }
//     // _controller.close(); // close automatically the "pipe" when the sub close it by sub.cancel()
//   }

//   void _tick(Timer timer) {
//     counter++;
//     Duration alreadyConsumed = new DateTime.now().difference(_begin);
//     this.remainingTime = this._duration - alreadyConsumed;
//     if (this.remainingTime.isNegative) {
//       timer.cancel();
//       timer = null;
//       // tell the onDone's subscriber that it's finish
//       _controller.close();
//     } else {
//       // here we can control the frequency of sending data
//       if (counter % _everyTick == 0) {
//         _controller.add(this.remainingTime);
//         counter = 0;
//       }
//     }
//   }
// }
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key key,
    int secondsRemaining,
    this.countDownTimerStyle,
    this.whenTimeExpires,
    this.countDownFormatter,
  })  : secondsRemaining = secondsRemaining,
        super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function countDownFormatter;
  final TextStyle countDownTimerStyle;

  State createState() => new _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Duration duration;
  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  String get timerDisplayString {
    Duration duration = _controller.duration * _controller.value;
    return widget.countDownFormatter != null
        ? widget.countDownFormatter(duration.inSeconds)
        : formatHHMMSS(duration.inSeconds);
    // In case user doesn't provide formatter use the default one
    // for that create a method which will be called formatHHMMSS or whatever you like
  }

  @override
  void initState() {
    super.initState();
    duration = new Duration(seconds: widget.secondsRemaining);
    _controller = new AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @override
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return Text(
                timerDisplayString,
                style: widget.countDownTimerStyle,
              );
            }));
  }
}
