import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color? color;
  const Loader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Colors.white
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

class OverlayLoader extends StatelessWidget {
  final bool loading;
  final bool shrink;
  final Widget child;
  final String? text;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  const OverlayLoader({Key? key,
    required this.loading,
    required this.child,
    this.text,
    this.shrink = false,
    this.color,
    this.borderRadius,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: shrink ? StackFit.loose : StackFit.expand,
      children: [
        child,
        if(loading) Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: margin,
            decoration: BoxDecoration(
              color: loading ? Colors.black.withOpacity(.6) : Colors.transparent,
              borderRadius: borderRadius
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Loader(color: color),
                if(text != null) Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      text!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                        fontSize: 16
                      ),
                    ),
                  ),
                )
              ],
            )
          )
        ),
      ],
    );
  }
}