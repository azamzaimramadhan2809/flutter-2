import 'dart:async';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String avatarPath;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.avatarPath,
  });

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hallo 👋',
      'isMe': true,
      'time': '12:40',
      'read': true,
    },
    {
      'text': 'Ada yang bisa di bantu?',
      'isMe': false,
      'time': '12:42',
      'read': true,
    },
  ];

  bool isTyping = false;

  Timer? _replyTimer;

  // ================================================================
  // TIME
  // ================================================================

  String _formatCurrentTime() {
    final now = TimeOfDay.now();

    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';
  }

  // ================================================================
  // SEND MESSAGE
  // ================================================================

  void _sendMessage() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    final newMessage = {
      'text': text,
      'isMe': true,
      'time': _formatCurrentTime(),
      'read': false,
    };

    setState(() {
      messages.add(newMessage);
    });

    _controller.clear();

    _scrollToBottom();

    // ==============================================================
    // LEGION
    // ==============================================================

    if (widget.contactName == 'Legion Center') {
      _replyTimer?.cancel();

      _replyTimer = Timer(
        const Duration(seconds: 10),
        () {
          if (!mounted) return;

          // 10 detik -> centang biru
          setState(() {
            newMessage['read'] = true;
            isTyping = true;
          });

          _scrollToBottom();

          // Setelah typing sebentar, balas
          Future.delayed(
            const Duration(seconds: 2),
            () {
              if (!mounted) return;

              setState(() {
                isTyping = false;

                messages.add({
                  'text':
                      'Terima kasih sudah menghubungi Legion Center 😊',
                  'isMe': false,
                  'time': _formatCurrentTime(),
                  'read': true,
                });
              });

              _scrollToBottom();
            },
          );
        },
      );
    }

    // ==============================================================
    // APPLE
    // ==============================================================

    else {
      Future.delayed(
        const Duration(milliseconds: 1200),
        () {
          if (!mounted) return;

          setState(() {
            newMessage['read'] = true;
            isTyping = true;
          });

          _scrollToBottom();

          Future.delayed(
            const Duration(seconds: 2),
            () {
              if (!mounted) return;

              setState(() {
                isTyping = false;

                messages.add({
                  'text':
                      'Terima kasih sudah menghubungi Apple Official 😊 Ada yang bisa kami bantu?',
                  'isMe': false,
                  'time': _formatCurrentTime(),
                  'read': true,
                });
              });

              _scrollToBottom();
            },
          );
        },
      );
    }
  }

  // ================================================================
  // SCROLL
  // ================================================================

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!_scrollController.hasClients) {
          return;
        }

        _scrollController.animateTo(
          _scrollController
              .position
              .maxScrollExtent,

          duration:
              const Duration(milliseconds: 300),

          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _replyTimer?.cancel();

    _controller.dispose();

    _scrollController.dispose();

    super.dispose();
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F7FA),

      appBar: _buildAppBar(),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,

              padding:
                  const EdgeInsets.fromLTRB(
                16,
                20,
                16,
                20,
              ),

              itemCount:
                  messages.length +
                      (isTyping ? 1 : 0),

              itemBuilder:
                  (context, index) {
                if (isTyping &&
                    index ==
                        messages.length) {
                  return _buildTypingIndicator();
                }

                return _buildMessage(
                  messages[index],
                );
              },
            ),
          ),

          _buildMessageInput(),
        ],
      ),
    );
  }

  // ================================================================
  // APP BAR
  // ================================================================

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,

      elevation: 0,

      shadowColor:
          Colors.black.withValues(
        alpha: 0.08,
      ),

      iconTheme: const IconThemeData(
        color: Color(0xFF1E3A5F),
      ),

      titleSpacing: 0,

      title: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 42,
                height: 42,

                decoration:
                    const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                    0xFFF1F5F9,
                  ),
                ),

                child: ClipOval(
                  child: Image.asset(
                    widget.avatarPath,

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

              Positioned(
                right: 0,
                bottom: 0,

                child: Container(
                  width: 12,
                  height: 12,

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
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                widget.contactName,

                style:
                    const TextStyle(
                  color: Color(
                    0xFF1F2937,
                  ),

                  fontSize: 16,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                isTyping
                    ? 'typing...'
                    : 'Online',

                style: TextStyle(
                  color: isTyping
                      ? const Color(
                          0xFF1E3A5F,
                        )
                      : const Color(
                          0xFF22C55E,
                        ),

                  fontSize: 11,

                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: () {},

          icon: const Icon(
            Icons.more_vert_rounded,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // MESSAGE
  // ================================================================

  Widget _buildMessage(
    Map<String, dynamic> message,
  ) {
    final bool isMe = message['isMe'];

    return Align(
      alignment: isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,

      child: Container(
        constraints:
            const BoxConstraints(
          maxWidth: 310,
        ),

        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        padding:
            const EdgeInsets.fromLTRB(
          15,
          11,
          11,
          8,
        ),

        decoration: BoxDecoration(
          color: isMe
              ? const Color(
                  0xFF1E3A5F,
                )
              : Colors.white,

          borderRadius:
              BorderRadius.only(
            topLeft:
                const Radius.circular(18),

            topRight:
                const Radius.circular(18),

            bottomLeft:
                Radius.circular(
              isMe ? 18 : 4,
            ),

            bottomRight:
                Radius.circular(
              isMe ? 4 : 18,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.035,
              ),

              blurRadius: 7,

              offset:
                  const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.end,

          children: [
            Align(
              alignment:
                  Alignment.centerLeft,

              child: Text(
                message['text'],

                style: TextStyle(
                  fontSize: 15,

                  height: 1.4,

                  color: isMe
                      ? Colors.white
                      : const Color(
                          0xFF1F2937,
                        ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisSize:
                  MainAxisSize.min,

              children: [
                Text(
                  message['time'],

                  style: TextStyle(
                    fontSize: 10,

                    color: isMe
                        ? Colors.white
                            .withValues(
                            alpha: 0.65,
                          )
                        : const Color(
                            0xFF9CA3AF,
                          ),
                  ),
                ),

                if (isMe) ...[
                  const SizedBox(width: 4),

                  Icon(
                    Icons.done_all_rounded,

                    size: 16,

                    color: message['read']
                        ? const Color(
                            0xFF38BDF8,
                          )
                        : const Color(
                            0xFF9CA3AF,
                          ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // TYPING INDICATOR
  // ================================================================

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,

      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.035,
              ),

              blurRadius: 7,

              offset:
                  const Offset(0, 2),
            ),
          ],
        ),

        child: const TypingDots(),
      ),
    );
  }

  // ================================================================
  // INPUT
  // ================================================================

  Widget _buildMessageInput() {
    return SafeArea(
      top: false,

      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          12,
          10,
          12,
          10,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.06,
              ),

              blurRadius: 10,

              offset:
                  const Offset(0, -2),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,

              decoration:
                  const BoxDecoration(
                color: Color(
                  0xFFF1F5F9,
                ),

                shape:
                    BoxShape.circle,
              ),

              child: const Icon(
                Icons.add_rounded,

                color:
                    Color(0xFF1E3A5F),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: TextField(
                controller:
                    _controller,

                textInputAction:
                    TextInputAction.send,

                onSubmitted:
                    (_) => _sendMessage(),

                decoration:
                    InputDecoration(
                  hintText:
                      'Write a message...',

                  hintStyle:
                      const TextStyle(
                    color:
                        Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),

                  filled: true,

                  fillColor:
                      const Color(
                    0xFFF7F8FA,
                  ),

                  contentPadding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 17,
                    vertical: 12,
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),

                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: _sendMessage,

              child: Container(
                width: 46,
                height: 46,

                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFF1E3A5F),

                  shape:
                      BoxShape.circle,
                ),

                child: const Icon(
                  Icons.send_rounded,

                  color:
                      Colors.white,

                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// TYPING DOTS ANIMATION
// ==================================================================

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  State<TypingDots> createState() =>
      _TypingDotsState();
}

class _TypingDotsState
    extends State<TypingDots>
    with TickerProviderStateMixin {
  late final AnimationController
      _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
      vsync: this,

      duration:
          const Duration(
        milliseconds: 900,
      ),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,

      builder: (context, child) {
        return Row(
          mainAxisSize:
              MainAxisSize.min,

          children: List.generate(
            3,
            (index) {
              final value =
                  ((_controller.value +
                              index * 0.2) %
                          1.0);

              final offset =
                  (value < 0.5
                      ? value
                      : 1 - value) *
                      10;

              return Transform.translate(
                offset:
                    Offset(0, -offset),

                child: Container(
                  width: 7,
                  height: 7,

                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 3,
                  ),

                  decoration:
                      const BoxDecoration(
                    color:
                        Color(0xFF94A3B8),

                    shape:
                        BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}