import 'package:flutter/material.dart';
import 'dart:math' as math;

class RugbyField extends StatefulWidget {
  final Function(Offset offset) onPositionClicked;
  final Offset position;
  RugbyField({required this.onPositionClicked, required this.position});

  @override
  State<RugbyField> createState() => _RugbyFieldState();
}

class _RugbyFieldState extends State<RugbyField> {
  Offset _touchPosition = Offset(10, 10);
  @override
  void initState() {
    _touchPosition = widget.position;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (TapDownDetails details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset localPosition = box.globalToLocal(details.globalPosition);
            widget.onPositionClicked(localPosition);
            setState(() {
              _touchPosition = localPosition;
            });
          },
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: CustomPaint(
              painter: _RugbyFieldPainter(touchPosition: _touchPosition),
            ),
          ),
        );
      },
    );
  }
}

class _RugbyFieldPainter extends CustomPainter {
  final Offset touchPosition;
  _RugbyFieldPainter({required this.touchPosition});

  double _mtc(Size canvasSize, double meters,
      {double fieldWidthMeters = 120, double fieldHeightMeters = 50}) {
    // Calcola il fattore di scala per entrambe le dimensioni
    double scaleX = canvasSize.width / fieldWidthMeters;
    double scaleY = canvasSize.height / fieldHeightMeters;

    // Usa la media dei fattori di scala per mantenere le proporzioni
    double scaleFactor = (scaleX + scaleY) / 2;

    // Converte i metri in unità del canvas
    double canvasUnits = meters * scaleFactor;

    return canvasUnits;
  }

  void drawDashedLine(
      {required Canvas canvas,
      required Offset p1,
      required Offset p2,
      required int dashWidth,
      required int dashSpace,
      required Paint paint}) {
    // Get normalized distance vector from p1 to p2
    var dx = p2.dx - p1.dx;
    var dy = p2.dy - p1.dy;
    final magnitude = math.sqrt(dx * dx + dy * dy);
    dx = dx / magnitude;
    dy = dy / magnitude;

    // Compute number of dash segments
    final steps = magnitude ~/ (dashWidth + dashSpace);

    var startX = p1.dx;
    var startY = p1.dy;

    for (int i = 0; i < steps; i++) {
      final endX = startX + dx * dashWidth;
      final endY = startY + dy * dashWidth;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      startX += dx * (dashWidth + dashSpace);
      startY += dy * (dashWidth + dashSpace);
    }
    //draw last dash if needed and calculate remaining space
    final remaining = magnitude - steps * (dashWidth + dashSpace);
    if (remaining > dashWidth) {
      final endX = startX + dx * dashWidth;
      final endY = startY + dy * dashWidth;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    } else if (remaining > 0) {
      final endX = startX + dx * remaining;
      final endY = startY + dy * remaining;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, paint);

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    final yellowLinePaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2.0;
    final alphaYellowLinePaint = Paint()
      ..color = Colors.yellow.withAlpha(90)
      ..strokeWidth = 2.0;
    double goalAreaWidth = _mtc(size, 10);
    // Disegna la linea centrale
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      linePaint,
    );

    //disegna le linee dei 5 metri
    drawDashedLine(
        canvas: canvas,
        p1: Offset(goalAreaWidth + _mtc(size, 5), 0),
        p2: Offset(
          goalAreaWidth + _mtc(size, 5),
          size.height,
        ),
        paint: linePaint,
        dashSpace: 20,
        dashWidth: 10);

    drawDashedLine(
        canvas: canvas,
        p1: Offset(size.width - goalAreaWidth - _mtc(size, 5), 0),
        p2: Offset(
          size.width - goalAreaWidth - _mtc(size, 5),
          size.height,
        ),
        paint: linePaint,
        dashSpace: 20,
        dashWidth: 10);

    // Disegna le linee dei 10 metri
    drawDashedLine(
        canvas: canvas,
        p1: Offset((size.width / 2) - _mtc(size, 10), 0),
        p2: Offset(
          (size.width / 2) - _mtc(size, 10),
          size.height,
        ),
        paint: linePaint,
        dashSpace: 2,
        dashWidth: 5);

    drawDashedLine(
        canvas: canvas,
        p1: Offset((size.width / 2) + _mtc(size, 10), 0),
        p2: Offset(
          (size.width / 2) + _mtc(size, 10),
          size.height,
        ),
        paint: linePaint,
        dashSpace: 2,
        dashWidth: 5);

    //disegna i 5 metri laterali
    drawDashedLine(
        canvas: canvas,
        p1: Offset(goalAreaWidth, _mtc(size, 5)),
        p2: Offset(size.width - goalAreaWidth, _mtc(size, 5)),
        paint: yellowLinePaint,
        dashSpace: 10,
        dashWidth: 5);
    drawDashedLine(
        canvas: canvas,
        p1: Offset(goalAreaWidth, size.height - _mtc(size, 5)),
        p2: Offset(size.width - goalAreaWidth, size.height - _mtc(size, 5)),
        paint: yellowLinePaint,
        dashSpace: 10,
        dashWidth: 5);

    //disegna i 15 metri laterali
    drawDashedLine(
        canvas: canvas,
        p1: Offset(goalAreaWidth, _mtc(size, 15)),
        p2: Offset(size.width - goalAreaWidth, _mtc(size, 15)),
        paint: yellowLinePaint,
        dashSpace: 20,
        dashWidth: 30);

    drawDashedLine(
        canvas: canvas,
        p1: Offset(goalAreaWidth, size.height - _mtc(size, 15)),
        p2: Offset(size.width - goalAreaWidth, size.height - _mtc(size, 15)),
        paint: yellowLinePaint,
        dashSpace: 20,
        dashWidth: 30);

    //disegna i 22 metri
    canvas.drawLine(Offset(goalAreaWidth + _mtc(size, 22), 0),
        Offset(goalAreaWidth + _mtc(size, 22), size.height), linePaint);

    canvas.drawLine(
        Offset(size.width - (_mtc(size, 22) + goalAreaWidth), 0),
        Offset(size.width - (_mtc(size, 22) + goalAreaWidth), size.height),
        linePaint);

    // Disegna le aree di ingaggio

    canvas.drawRect(
      Rect.fromLTWH(0, 0, goalAreaWidth, size.height),
      alphaYellowLinePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width - goalAreaWidth, 0, goalAreaWidth, size.height),
      alphaYellowLinePaint,
    );

    // Imposta il Paint per disegnare il cerchio
    final redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Disegna un cerchio sulla posizione del tocco
    if (touchPosition != Offset.zero) {
      canvas.drawCircle(touchPosition, 10.0, redPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RugbyFieldPainter oldDelegate) {
    return oldDelegate.touchPosition != touchPosition;
  }
}
