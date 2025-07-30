import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardSection extends StatefulWidget {
  @override
  _CardSectionState createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection>
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
      end: const Offset(0, -1),
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
    return  GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -100) {
            _onSwipeUp();
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 250,
              child: Stack(
                children: List.generate(cards.length, (index) {
                  final card = cards[index];
                  final isTop = index == 4;

                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    top: index * 5,
                    left: index * -2,
                    right: index * 1,
                    child: isTop
                        ? SlideTransition(
                      position: _swipeAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: CardWidget(card),
                      ),
                    )
                        : Transform.scale(
                      scale: 1.1 - (index * 0.01),

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
      margin: const EdgeInsets.symmetric(horizontal: 32,vertical: 15),
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
          // const Spacer(),
        ],
      ),
    );
  }
}
