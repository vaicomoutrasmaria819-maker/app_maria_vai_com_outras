import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/message.dart';

/// Tela de chat MVP para comunicação entre cliente e prestadora
/// Funciona localmente sem Firebase
class ChatPage extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String otherUserName;
  final String? serviceId;

  const ChatPage({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUserName,
    this.serviceId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _addInitialMessages();
  }

  void _addInitialMessages() {
    // Adicionar algumas mensagens de exemplo
    setState(() {
      _messages.addAll([
        Message(
          id: _uuid.v4(),
          senderId: widget.otherUserId,
          receiverId: widget.currentUserId,
          content: 'Olá! Vi que você solicitou um serviço.',
          type: MessageType.text,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          isRead: true,
          serviceId: widget.serviceId,
        ),
        Message(
          id: _uuid.v4(),
          senderId: widget.currentUserId,
          receiverId: widget.otherUserId,
          content: 'Sim, preciso de ajuda com a reforma do banheiro.',
          type: MessageType.text,
          createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
          isRead: true,
          serviceId: widget.serviceId,
        ),
        Message(
          id: _uuid.v4(),
          senderId: widget.otherUserId,
          receiverId: widget.currentUserId,
          content: 'Perfeito! Posso dar uma olhada no local para avaliar o trabalho.',
          type: MessageType.text,
          createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
          isRead: true,
          serviceId: widget.serviceId,
        ),
      ]);
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(
        id: _uuid.v4(),
        senderId: widget.currentUserId,
        receiverId: widget.otherUserId,
        content: text,
        type: MessageType.text,
        createdAt: DateTime.now(),
        isRead: false,
        serviceId: widget.serviceId,
      ));
    });

    _messageController.clear();
    _scrollToBottom();

    // Simular resposta automática após 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(Message(
            id: _uuid.v4(),
            senderId: widget.otherUserId,
            receiverId: widget.currentUserId,
            content: _getAutoResponse(text),
            type: MessageType.text,
            createdAt: DateTime.now(),
            isRead: false,
            serviceId: widget.serviceId,
          ));
        });
        _scrollToBottom();
      }
    });
  }

  String _getAutoResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    
    if (lowerMessage.contains('preço') || lowerMessage.contains('valor') || lowerMessage.contains('quanto')) {
      return 'Vou fazer um orçamento depois de avaliar o serviço. Posso passar na sua casa para dar uma olhada?';
    } else if (lowerMessage.contains('horário') || lowerMessage.contains('quando') || lowerMessage.contains('dia')) {
      return 'Estou disponível de segunda a sexta, das 8h às 18h. Qual horário fica melhor para você?';
    } else if (lowerMessage.contains('obrigado') || lowerMessage.contains('valeu')) {
      return 'Por nada! Estou à disposição. Se precisar de mais alguma coisa, é só chamar!';
    } else {
      return 'Entendi! Vou anotar isso. Tem mais alguma dúvida sobre o serviço?';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat com ${widget.otherUserName}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma mensagem ainda',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isFromMe = message.senderId == widget.currentUserId;
                      
                      return _MessageBubble(
                        message: message,
                        isFromMe: isFromMe,
                      );
                    },
                  ),
          ),
          _MessageInput(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isFromMe;

  const _MessageBubble({
    required this.message,
    required this.isFromMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isFromMe
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.content,
                  style: GoogleFonts.poppins(
                    color: isFromMe ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.createdAt),
                  style: GoogleFonts.poppins(
                    color: isFromMe ? Colors.white70 : Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Agora';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${dateTime.day}/${dateTime.month}';
    }
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInput({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Digite sua mensagem...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onSend,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}