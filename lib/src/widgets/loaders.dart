import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white
      ),
    );
  }
}

class LoadingBars extends StatelessWidget {
  final int count;
  final int active;
  const LoadingBars({
    Key? key,
    this.count = 3,
    this.active = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
          children:[
            for (int i=0; i<count; i++)
              Flexible(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: (i+1 == count) ? 0 : 12
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(111),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        backgroundColor: Colors.blue.withOpacity(.2),
                        color: active >= i+1 ? Colors.blue : Colors.transparent,
                        value: active > i+1 ? 1 : null,
                      ),
                    ),
                  )
              )

          ]
      ),
    );
  }
}