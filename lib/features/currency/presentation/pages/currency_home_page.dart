import 'page_views/currency_convertion_page_view.dart';
import 'page_views/historical_data_page_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../domain/entities/currency_entity.dart';
import '../widgets/currency_card_widget.dart';
import 'page_views/currency_list_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.currencyData,
  });

  final CurrencyResponseEntity currencyData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Currency Portal",
          style: getSemiBoldTextStyle(
            color: ColorManager.textPrimary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          CurrencyConversionPage(currencyData: widget.currencyData),
          HistoricalDataPage(currencyData: widget.currencyData),
          CurrencyListPageView(currencyData: widget.currencyData),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Conversion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historical Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Currencies',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorManager.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}
