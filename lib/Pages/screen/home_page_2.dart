import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: SwipeCardAnimatedStack()));
}

class SwipeCardAnimatedStack extends StatefulWidget {
  @override
  _SwipeCardAnimatedStackState createState() => _SwipeCardAnimatedStackState();
}

class _SwipeCardAnimatedStackState extends State<SwipeCardAnimatedStack>
    with TickerProviderStateMixin {
  List<CardData> cards = [
    CardData("Amazon Pay", "₹42,436.41", Colors.black),
    CardData("ICICI Platinum", "₹12,300.00", Colors.deepPurple),
    CardData("Federal Bank", "₹8,400.23", Colors.teal),
    CardData("Axis Flipkart", "₹3,120.00", Colors.blueGrey),
  ];

  late AnimationController _swipeController;
  late Animation<Offset> _swipeAnimation;
  late Animation<double> _opacityAnimation;

  bool isAnimating = false;

  @override
  void initState() {
    super.initState();

    _swipeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _swipeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -2),
    ).animate(CurvedAnimation(
      parent: _swipeController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_swipeController);
  }

  void _onSwipeUp() async {
    if (isAnimating) return;
    setState(() => isAnimating = true);

    await _swipeController.forward();

    final first = cards.removeAt(0);
    cards.add(first);

    _swipeController.reset();

    setState(() => isAnimating = false);
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -100) {
            _onSwipeUp();
          }
        },
        child: Center(
          child: SizedBox(
            height: 230,
            child: Stack(
              children: List.generate(cards.length, (index) {
                final card = cards[index];
                final isTop = index == 0;

                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: index * 10.0,
                  left: 0,
                  right: 0,
                  child: isTop
                      ? SlideTransition(
                          position: _swipeAnimation,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: CardWidget(card),
                          ),
                        )
                      : Transform.scale(
                          scale: 1.0 - (index * 0.04),
                          child: CardWidget(card),
                        ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class CardData {
  final String title;
  final String amount;
  final Color color;

  CardData(this.title, this.amount, this.color);
}

class CardWidget extends StatelessWidget {
  final CardData data;

  const CardWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.all(20),
      height: 205,
      decoration: BoxDecoration(
        color: data.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 20),
          const Icon(Icons.credit_card, size: 40, color: Colors.white),
          const SizedBox(height: 20),
          Text(data.amount,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          const Text("Swipe up to continue",
              style: TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }
}
