import 'package:flutter/material.dart';

class RedLineChart extends StatelessWidget {
  const RedLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 200), // 그래프 크기 지정
      painter: RedLineChartPainter(),
    );
  }
}

class RedLineChartPainter extends CustomPainter {
  final List<Offset> points = [
    const Offset(10, 180), // 시작점 (5일, 0)
    const Offset(50, 20), // 피크 (5일, 높은 값)
    const Offset(90, 180), // 다시 0
    const Offset(130, 100), // 중간 값 (18일)
    const Offset(170, 180), // 다시 0
    const Offset(210, 100), // 중간 값 (19일)
    const Offset(250, 180), // 다시 0
    const Offset(290, 20), // 피크 (20일)
    const Offset(330, 180), // 다시 0
    const Offset(370, 100), // 중간 값 (21일)
    const Offset(410, 180), // 다시 0
    const Offset(450, 20), // 피크 (22일)
    const Offset(490, 180), // 다시 0
    const Offset(530, 100), // 중간 값 (23일)
    const Offset(570, 180), // 다시 0
    const Offset(610, 20), // 피크 (24일)
    const Offset(650, 180), // 다시 0
    const Offset(690, 100), // 중간 값 (25일)
    const Offset(730, 180), // 다시 0
    const Offset(770, 20), // 피크 (26일)
    const Offset(810, 180), // 다시 0
    const Offset(850, 100), // 중간 값 (27일)
    const Offset(890, 180), // 다시 0
    const Offset(930, 20), // 피크 (28일)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.red[900]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class YellowLineChart extends StatelessWidget {
  const YellowLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 200), // 그래프 크기 지정
      painter: YellowLineChartPainter(),
    );
  }
}

class YellowLineChartPainter extends CustomPainter {
  final List<Offset> points = [
    const Offset(10, 180), // 시작점 (5일, 0)
    const Offset(50, 20), // 피크 (5일, 높은 값)
    const Offset(90, 180), // 다시 0
    const Offset(130, 100), // 중간 값 (18일)
    const Offset(170, 180), // 다시 0
    const Offset(210, 100), // 중간 값 (19일)
    const Offset(250, 180), // 다시 0
    const Offset(290, 20), // 피크 (20일)
    const Offset(330, 180), // 다시 0
    const Offset(370, 100), // 중간 값 (21일)
    const Offset(410, 180), // 다시 0
    const Offset(450, 20), // 피크 (22일)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.yellow[900]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class GreenLineChart extends StatelessWidget {
  const GreenLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 200), // 그래프 크기 지정
      painter: GreenLineChartPainter(),
    );
  }
}

class GreenLineChartPainter extends CustomPainter {
  final List<Offset> points = [
    const Offset(10, 180), // 시작점 (5일, 0)
    const Offset(50, 20), // 피크 (5일, 높은 값)
    const Offset(90, 180), // 다시 0
    const Offset(130, 100), // 중간 값 (18일)
    const Offset(170, 180), // 다시 0
    const Offset(210, 100), // 중간 값 (19일)
    const Offset(250, 180), // 다시 0
    const Offset(290, 20), // 피크 (20일)
    const Offset(330, 180), // 다시 0
    const Offset(370, 100), // 중간 값 (21일)
    const Offset(410, 180), // 다시 0
    const Offset(450, 20), // 피크 (22일)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.green[900]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
