import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/account_page.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_ecommerce/ui/widget/CategoriesWidget.dart';
import 'package:ui_ecommerce/ui/widget/ItemWidget.dart';
import 'package:ui_ecommerce/ui/widget/HomeAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,

        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        children: const [
          HomePageContent(),
          CartPage(),
          AccountPage(),
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        color: const Color(0xFF1E3A5F),

        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),

          Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),

          Icon(
            Icons.account_circle_sharp,
            size: 30,
            color: Colors.white,
          ),
        ],

        index: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}


// ============================================================
// HOME PAGE CONTENT
// ============================================================

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() =>
      _HomePageContentState();
}

class _HomePageContentState
    extends State<HomePageContent> {

  // ============================================================
  // CATEGORY
  // ============================================================

  String selectedCategory = 'All';

  // ============================================================
  // SEARCH
  // ============================================================

  final TextEditingController _searchController =
      TextEditingController();

  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        searchQuery =
            _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // REFRESH SEARCH
  // ============================================================

  void _refreshSearch() {
    setState(() {
      searchQuery =
          _searchController.text.trim().toLowerCase();
    });

    FocusScope.of(context).unfocus();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HomeAppBar(),

        Container(
          padding: const EdgeInsets.only(
            top: 15,
          ),

          decoration: const BoxDecoration(
            color: Color(0xFF1E3A5F),

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),

          child: Column(
            children: [

              // ==================================================
              // SEARCH BAR
              // ==================================================

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),

                height: 50,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(30),
                ),

                child: Row(
                  children: [

                    // SEARCH ICON
                    const Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                      size: 23,
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    // TEXT FIELD
                    Expanded(
                      child: TextFormField(
                        controller:
                            _searchController,

                        textInputAction:
                            TextInputAction.search,

                        onFieldSubmitted: (_) {
                          _refreshSearch();
                        },

                        decoration:
                            const InputDecoration(
                          border: InputBorder.none,

                          hintText:
                              'Search here...',

                          hintStyle:
                              TextStyle(
                            color:
                                Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),

                    // REFRESH / SEARCH BUTTON
                    InkWell(
                      borderRadius:
                          BorderRadius.circular(20),

                      onTap: _refreshSearch,

                      child: Container(
                        width: 38,
                        height: 38,

                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFF1E3A5F,
                          ),

                          shape:
                              BoxShape.circle,
                        ),

                        child:
                            const Icon(
                          Icons.search,
                          color:
                              Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // CATEGORIES TITLE
              // ==================================================

              Container(
                alignment:
                    Alignment.centerLeft,

                margin:
                    const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),

                child: const Text(
                  'Categories',

                  style: TextStyle(
                    fontSize: 25,

                    fontWeight:
                        FontWeight.bold,

                    color: Colors.white,
                  ),
                ),
              ),

              // ==================================================
              // CATEGORIES
              // ==================================================

              CategoriesWidget(
                selectedCategory:
                    selectedCategory,

                onCategorySelected:
                    (category) {
                  setState(() {
                    selectedCategory =
                        category;
                  });
                },
              ),

              // ==================================================
              // PRODUCT TITLE
              // ==================================================

              Container(
                alignment:
                    Alignment.centerLeft,

                margin:
                    const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),

                child: Text(
                  selectedCategory == 'All'
                      ? 'Best Item'
                      : selectedCategory,

                  style:
                      const TextStyle(
                    fontSize: 25,

                    fontWeight:
                        FontWeight.bold,

                    color: Colors.white,
                  ),
                ),
              ),

              // ==================================================
              // PRODUCTS
              // ==================================================

              ItemWidget(
                selectedCategory:
                    selectedCategory,

                searchQuery:
                    searchQuery,
              ),

              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}