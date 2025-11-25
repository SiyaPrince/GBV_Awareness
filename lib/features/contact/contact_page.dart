import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gbv_awareness/features/dashboard/widgets/support_help_card.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _isAnonymous = false;

  // Form field validators
  String? _validateName(String? value) {
    if (_isAnonymous) return null; // Skip validation if anonymous
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (_isAnonymous) return null; // Skip validation if anonymous
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }
    if (value.length < 10) {
      return 'Message must be at least 10 characters';
    }
    if (value.length > 1000) {
      return 'Message must be less than 1000 characters';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Prepare data for Firestore
      final messageData = {
        'message': _messageController.text.trim(),
        'createdAt': Timestamp.now(),
        'status': 'new',
        'read': false,
        'isAnonymous': _isAnonymous,
      };

      // Add name and email only if not anonymous
      if (!_isAnonymous) {
        messageData['name'] = _nameController.text.trim();
        messageData['email'] = _emailController.text.trim();
      } else {
        messageData['name'] = 'Anonymous';
        messageData['email'] = 'anonymous@example.com';
      }

      await FirebaseFirestore.instance.collection('messages').add(messageData);

      // Show success dialog based on anonymous status
      _showSuccessDialog();

      // Clear form after success
      _resetForm();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $error'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Thank you for reaching out!',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          content: Text(
            _isAnonymous
                ? 'Your anonymous message has been sent successfully.'
                : 'Your message has been sent successfully. We will reply as soon as possible.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    setState(() {
      _isAnonymous = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Header
          _buildPageHeader(theme),
          const SizedBox(height: 24),

          // Contact Form
          _buildContactForm(theme),

          const SizedBox(height: 24),

          // Use the existing SupportHelpCard instead of creating a new safety notice
          const SupportHelpCard(),
        ],
      ),
    );
  }

  Widget _buildPageHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.contact_mail, color: theme.primaryColor, size: 32),
            const SizedBox(width: 12),
            Text(
              'Contact Us',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Get in touch with us. We\'re here to help and support you.',
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildContactForm(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form Header
              Row(
                children: [
                  Icon(Icons.message, color: theme.primaryColor, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Send us a Message',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'We\'re here to help. Fill out the form below and we\'ll respond as soon as possible.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Anonymous Checkbox
              Card(
                elevation: 1,
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAnonymous,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAnonymous = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Send anonymously',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Your name and email will not be shared',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              TextFormField(
                controller: _nameController,
                enabled: !_isAnonymous, // Disable when anonymous
                decoration: InputDecoration(
                  labelText: 'Your Name *',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Enter your full name',
                  filled: _isAnonymous,
                  fillColor: _isAnonymous ? Colors.grey[100] : null,
                ),
                validator: _validateName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),

              // Email Field
              TextFormField(
                controller: _emailController,
                enabled: !_isAnonymous, // Disable when anonymous
                decoration: InputDecoration(
                  labelText: 'Email Address *',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'your.email@example.com',
                  filled: _isAnonymous,
                  fillColor: _isAnonymous ? Colors.grey[100] : null,
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),

              // Message Field
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Your Message *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Tell us how we can help you...',
                ),
                validator: _validateMessage,
                maxLines: 6,
                maxLength: 1000,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8),
              Text(
                '${_messageController.text.length}/1000 characters',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.primaryColor,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Reset Button
              if (!_isSubmitting)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _resetForm,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: theme.primaryColor),
                    ),
                    child: Text(
                      'Clear Form',
                      style: TextStyle(fontSize: 16, color: theme.primaryColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
