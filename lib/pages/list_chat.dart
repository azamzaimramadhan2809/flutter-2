import 'package:flutter/material.dart';
import 'detail_chat.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Apple Official',
      'message': 'Hi, welcome to our store',
      'time': '12:30',
      'avatar': 'assets/images/avatar/apple.png',
      'unread': 1,
      'online': true,
    },
    {
      'name': 'Legion Center',
      'message': 'Hi, welcome to our store',
      'time': '01:30',
      'avatar': 'assets/images/avatar/logolegion.jpg',
      'unread': 1,
      'online': false,
    },
  ];

  List<Map<String, dynamic>> get filteredChats {
    if (selectedTab == 1) {
      return chats
          .where(
            (chat) => (chat['unread'] as int) > 0,
          )
          .toList();
    }

    return chats;
  }

  void _openChat(Map<String, dynamic> chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          contactName: chat['name'],
          avatarPath: chat['avatar'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = chats
        .where(
          (chat) => (chat['unread'] as int) > 0,
        )
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        automaticallyImplyLeading: true,

        iconTheme: const IconThemeData(
          color: Color(0xFF1E3A5F),
        ),

        title: const Text(
          'Messages',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 14,
            ),

            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor:
                    const Color(0xFFF1F5F9),
              ),

              icon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF1E3A5F),
                size: 22,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // ==========================================================
          // HEADER
          // ==========================================================

          Container(
            width: double.infinity,

            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              18,
            ),

            color: Colors.white,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Your conversations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9CA3AF),
                  ),
                ),

                const SizedBox(height: 16),

                // ==================================================
                // TAB
                // ==================================================

                Container(
                  height: 48,

                  padding: const EdgeInsets.all(4),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius:
                        BorderRadius.circular(14),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTab(
                          title: 'All',
                          selected: selectedTab == 0,
                          badge: null,
                          onTap: () {
                            setState(() {
                              selectedTab = 0;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: _buildTab(
                          title: 'Unread',
                          selected: selectedTab == 1,
                          badge: unreadCount,
                          onTap: () {
                            setState(() {
                              selectedTab = 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ==========================================================
          // CHAT LIST
          // ==========================================================

          Expanded(
            child: filteredChats.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding:
                        const EdgeInsets.fromLTRB(
                      16,
                      14,
                      16,
                      20,
                    ),

                    itemCount:
                        filteredChats.length,

                    itemBuilder:
                        (context, index) {
                      final chat =
                          filteredChats[index];

                      return _buildChatItem(
                        chat,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // TAB
  // ================================================================

  Widget _buildTab({
    required String title,
    required bool selected,
    required int? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200),

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF1E3A5F)
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(11),

          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(
                      0xFF1E3A5F,
                    ).withValues(
                      alpha: 0.15,
                    ),

                    blurRadius: 8,
                    offset:
                        const Offset(0, 3),
                  ),
                ]
              : null,
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Text(
              title,

              style: TextStyle(
                color: selected
                    ? Colors.white
                    : const Color(
                        0xFF64748B,
                      ),

                fontSize: 14,

                fontWeight:
                    selected
                        ? FontWeight.bold
                        : FontWeight.w500,
              ),
            ),

            if (badge != null &&
                badge > 0) ...[
              const SizedBox(width: 7),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),

                decoration:
                    BoxDecoration(
                  color: selected
                      ? Colors.white
                      : const Color(
                          0xFF1E3A5F,
                        ),

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  '$badge',

                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        FontWeight.bold,

                    color: selected
                        ? const Color(
                            0xFF1E3A5F,
                          )
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ================================================================
  // CHAT ITEM
  // ================================================================

  Widget _buildChatItem(
    Map<String, dynamic> chat,
  ) {
    final int unread = chat['unread'];

    return GestureDetector(
      onTap: () => _openChat(chat),

      child: Container(
        margin:
            const EdgeInsets.only(bottom: 10),

        padding:
            const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color: const Color(
              0xFFE5E7EB,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.025,
              ),

              blurRadius: 8,

              offset:
                  const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            // ======================================================
            // AVATAR
            // ======================================================

            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,

                  decoration:
                      BoxDecoration(
                    shape: BoxShape.circle,

                    color: const Color(
                      0xFFF1F5F9,
                    ),

                    border: Border.all(
                      color: const Color(
                        0xFFE5E7EB,
                      ),
                    ),
                  ),

                  child: ClipOval(
                    child: Image.asset(
                      chat['avatar'],

                      fit: BoxFit.cover,

                      errorBuilder:
                          (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Icon(
                          Icons.person,
                          color: Color(
                            0xFF94A3B8,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                if (chat['online'] == true)
                  Positioned(
                    right: 1,
                    bottom: 1,

                    child: Container(
                      width: 15,
                      height: 15,

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF22C55E,
                        ),

                        shape:
                            BoxShape.circle,

                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 14),

            // ======================================================
            // CHAT INFO
            // ======================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['name'],

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Color(
                              0xFF1F2937,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        chat['time'],

                        style:
                            const TextStyle(
                          fontSize: 11,
                          color:
                              Color(
                            0xFF9CA3AF,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['message'],

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 13,

                            color: unread > 0
                                ? const Color(
                                    0xFF374151,
                                  )
                                : const Color(
                                    0xFF9CA3AF,
                                  ),

                            fontWeight:
                                unread > 0
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                          ),
                        ),
                      ),

                      if (unread > 0)
                        Container(
                          margin:
                              const EdgeInsets.only(
                            left: 8,
                          ),

                          width: 21,
                          height: 21,

                          alignment:
                              Alignment.center,

                          decoration:
                              const BoxDecoration(
                            color:
                                Color(
                              0xFF1E3A5F,
                            ),

                            shape:
                                BoxShape.circle,
                          ),

                          child: Text(
                            '$unread',

                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // EMPTY
  // ================================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Container(
            width: 80,
            height: 80,

            decoration:
                const BoxDecoration(
              color: Color(0xFFEFF3F8),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.mark_chat_unread_outlined,
              size: 38,
              color: Color(0xFF1E3A5F),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No unread messages',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'You are all caught up!',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}