import 'package:adm_botecaria/modules/home/asp/actions.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../../asp/atoms.dart';
import '../../../providers/states/gen_ai_states.dart';
import 'circle_painter.dart';
import 'loading_indicator.dart';

class AiGenWidget extends StatefulWidget {
  const AiGenWidget({super.key, required this.child});

  final Widget child;

  @override
  State<AiGenWidget> createState() => _AiGenWidgetState();
}

class _AiGenWidgetState extends State<AiGenWidget>
    with SingleTickerProviderStateMixin, HookStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _tlAlignAmin;
  late Animation<Alignment> _brAlignAmin;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _tlAlignAmin = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_controller);

    _brAlignAmin = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_controller);

    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final genAiState = useAtomState(genAiStateAtom);
    final prompState = useAtomState(promptAtom);

    return Stack(
      children: [
        ClipPath(
          clipper:
              genAiState is GenAiStatesSearchable
                  ? _CenterCutPath(radius: 20, thickness: 2)
                  : null,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),

                  gradient: LinearGradient(
                    begin: _tlAlignAmin.value,
                    end: _brAlignAmin.value,
                    colors: [Colors.red, Colors.blue],
                  ),
                ),
              );
            },
          ),
        ),
        genAiState is GenAiStatesInitial || genAiState is GenAiStatesSuccess
            ? Positioned(child: widget.child)
            : SizedBox(),
        genAiState is GenAiStatesSearchable
            ? Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Search by Product in English...'),
                  ),
                  onChanged: (value) => setPromptAction(value),
                ),
              ),
            )
            : SizedBox(),

        genAiState is GenAiStatesSearchable && prompState.isNotEmpty
            ? Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  generationImagesAction();
                },
                child: Text('Gerar'),
              ),
            )
            : genAiState is GenAiStatesSearchable && prompState.isEmpty
            ? Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: setGenAiStateInitialAction.call,
                child: Text('Cancelar'),
              ),
            )
            : SizedBox(),

        genAiState is GenAiStatesLoading ? LoadingIndicator() : SizedBox(),
      ],
    );
  }
}

class _CenterCutPath extends CustomClipper<Path> {
  final double radius;
  final double thickness;
  _CenterCutPath({this.radius = 0, this.thickness = 1});

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
      -size.width,
      -size.width,
      size.width * 2,
      size.height * 2,
    );
    final double width = size.width - thickness * 2;
    final double height = size.height - thickness * 2;

    final path =
        Path()
          ..fillType = PathFillType.evenOdd
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(thickness, thickness, width, height),
              Radius.circular(radius - thickness),
            ),
          )
          ..addRect(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant _CenterCutPath oldClipper) {
    return oldClipper.radius != radius || oldClipper.thickness != thickness;
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GradientCircle(
              color1: g1c1,
              color2: g1c2,
              diameter: 75,
              tweens: tweens,
            ),
            GradientCircle(
              color1: g2c1,
              color2: g2c2,
              diameter: 75,
              tweens: tweens.sublist(2) + tweens.sublist(0, 2),
            ),
            GradientCircle(
              color1: g3c1,
              color2: g3c2,
              diameter: 75,
              tweens: tweens.sublist(4) + tweens.sublist(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCircle extends StatefulWidget {
  final Color color1;
  final Color color2;
  final List<TweenSequenceItem> tweens;

  final double diameter;

  const GradientCircle({
    super.key,
    required this.color1,
    required this.color2,
    required this.diameter,
    required this.tweens,
  });

  @override
  State<GradientCircle> createState() => _GradientCircleState();
}

class _GradientCircleState extends State<GradientCircle>
    with TickerProviderStateMixin {
  late final tweenSequence = TweenSequence(
    widget.tweens,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

  late final rotationTween = Tween(
    begin: 0.0,
    end: pi * 2,
  ).animate(CurvedAnimation(parent: _rotationController, curve: Curves.linear));

  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );
  late final _rotationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  @override
  void initState() {
    _controller.repeat();
    _rotationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: SizedBox(
        height: widget.diameter,
        width: widget.diameter,
        child: CustomPaint(
          size: Size(widget.diameter, widget.diameter),
          painter: CirclePainter(
            gradient: LinearGradient(colors: [widget.color1, widget.color2]),
          ),
        ),
      ),
      builder: (context, child) {
        return Transform.translate(
          offset: tweenSequence.value,
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(angle: rotationTween.value, child: child);
            },
            child: child!,
          ),
        );
      },
    );
  }
}
