import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmpltyTodo extends StatelessWidget {
  const EmpltyTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      ///https://rive.app/a/Overman/files/flare/events-empty-data-set
      child: SizedBox(
        width: 200,
        height: 200,
        child: FlareActor.asset(
          AssetFlare(bundle: rootBundle, name: 'assets/animation/empty.flr'),
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: 'Idle',
        ),
      ),
    );
  }
}
