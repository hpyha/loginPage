import '../pages/phone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardPage1 extends StatefulWidget {
  const OnBoardPage1({super.key});

  @override
  State<OnBoardPage1> createState() => _OnBoardPage1State();
}

class _OnBoardPage1State extends State<OnBoardPage1>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _floatController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slidAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    //opacity

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    //slide
    _slidAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
        );
    //float
    _floatAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _startAnimations();
    _floatController.repeat(reverse: true);
  }

  void _startAnimations() {
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  void _restartAnimation() {
    _fadeController.reset();
    _slideController.reset();
    _scaleController.reset();
    _floatController.reset();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _floatController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });

    _restartAnimation();
    _startAnimations();

    HapticFeedback.lightImpact();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PhonePage()),
      );
    }
  }

  void _perviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void skipOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PhonePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getgradiantColors(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhonePage()));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    _buildPage(
                      icon: Icons.rocket_launch_rounded,
                      title: "Welcome to fix street ",
                      description: " there is some explain on app ",
                      isFirst: true,
                    ),
                    _buildPage(
                      icon: Icons.auto_awesome_mosaic_rounded,
                      title: "title  ",
                      description: " there is some explain on app ",
                      isFirst: false,
                    ),
                    _buildPage(
                      icon: Icons.favorite_rounded,
                      title: "title ",
                      description: " there is some explain on app ",
                      isFirst: false,
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(30),
              child:Column(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    children: List.generate(3, (index) => _buildDot(index)),
                  ), 
                  SizedBox(height: 30,), 
                  _navigationButtons(),
                ],
              ) ,
              ), 

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required IconData icon,
    required String title,
    required String description,
    required bool isFirst,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slidAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,

                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(icon, size: 60, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 60),
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      margin: EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.white
            : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _navigationButtons() {
    return Row(
      children: [
        if (_currentPage > 0)
          Expanded(
            child: AnimatedContainer(
              duration: Duration(microseconds: 300),
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      
                      TextButton(
                        onPressed: _perviousPage,

                        child: Text('back',
                        
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_currentPage > 0) SizedBox(width: 16,),
          Expanded(
            child: AnimatedContainer(
              duration: Duration(microseconds: 300),
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.1), 
                  blurRadius: 10, 
                  offset: Offset(0, 5),

                )],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _nextPage,
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          _currentPage == 2 ? 'Get Started' : 'Next' , 
                          style: TextStyle(
                            color: _getgradiantColors()[0],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if(_currentPage != 2 )...[
                          SizedBox(width: 8,), 
                           Icon(
                          Icons.arrow_forward_rounded,
                          color: _getgradiantColors()[0],
                          size: 20,
                        ),
                        ]
                       
                        
                       
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          

      ],
    );
  }

  List<Color> _getgradiantColors() {
    switch (_currentPage) {
      case 0:
        return [Color.fromARGB(255, 1, 30, 55), Color(0xFF4286f4)];
      case 1:
        return [Color.fromARGB(255, 3, 51, 17), Color(0xFF3CA55C)];
      case 2:
        return [Color.fromARGB(255, 71, 4, 40), Color(0xFFD76D77)];
      default:
        return [Colors.blue, Colors.green];
    }
  }
}
