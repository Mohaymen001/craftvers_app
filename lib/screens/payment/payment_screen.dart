import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';
import '../../models/product.dart';
import '../../routes/app_routes.dart';

class PaymentScreen extends StatefulWidget {
  final Product product;
  final int quantity;

  const PaymentScreen({super.key, required this.product, this.quantity = 1});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  bool _isProcessing = false;

  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _addressController = TextEditingController();

  final paymentMethods = [
    {'icon': Icons.credit_card, 'label': 'Credit Card'},
    {'icon': Icons.account_balance_wallet_outlined, 'label': 'PayPal'},
    {'icon': Icons.apple, 'label': 'Apple Pay'},
  ];

  double get subtotal => widget.product.price * widget.quantity;
  double get shipping => subtotal > 100 ? 0 : 9.99;
  double get tax => subtotal * 0.08;
  double get total => subtotal + shipping + tax;

  void _processPayment() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isProcessing = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 16),
              const Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your order has been placed successfully.\nWe\'ll notify you when it ships.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textLight, height: 1.5),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Order Summary ──
            _sectionTitle('Order Summary'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.product.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 70, height: 70,
                        color: AppColors.lightGrey,
                        child: const Icon(Icons.image_outlined, color: AppColors.textLight),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Qty: ${widget.quantity}',
                          style: const TextStyle(color: AppColors.textLight, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textDark),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Shipping Address ──
            _sectionTitle('Shipping Address'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: TextField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Enter your full shipping address...',
                  prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.textLight),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Payment Method ──
            _sectionTitle('Payment Method'),
            Container(
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  // Method Selector
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: List.generate(paymentMethods.length, (index) {
                        final isSelected = _selectedPaymentMethod == index;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedPaymentMethod = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(right: index < paymentMethods.length - 1 ? 8 : 0),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.accent.withOpacity(0.1) : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? AppColors.accent : Colors.grey.shade200,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    paymentMethods[index]['icon'] as IconData,
                                    color: isSelected ? AppColors.accent : AppColors.textLight,
                                    size: 22,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    paymentMethods[index]['label'] as String,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? AppColors.accent : AppColors.textLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Card Fields (only for credit card)
                  if (_selectedPaymentMethod == 0) ...[
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                              _CardNumberFormatter(),
                            ],
                            decoration: const InputDecoration(
                              hintText: '1234 5678 9012 3456',
                              labelText: 'Card Number',
                              prefixIcon: Icon(Icons.credit_card, color: AppColors.textLight),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _cardNameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'Ahmed Mohamed',
                              labelText: 'Cardholder Name',
                              prefixIcon: Icon(Icons.person_outline, color: AppColors.textLight),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _expiryController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    _ExpiryFormatter(),
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: 'MM/YY',
                                    labelText: 'Expiry',
                                    prefixIcon: Icon(Icons.calendar_today_outlined, color: AppColors.textLight),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: '•••',
                                    labelText: 'CVV',
                                    prefixIcon: Icon(Icons.lock_outline, color: AppColors.textLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ] else
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'You\'ll be redirected to complete payment via ${paymentMethods[_selectedPaymentMethod]['label']}.',
                        style: const TextStyle(color: AppColors.textLight, fontSize: 13, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Price Breakdown ──
            _sectionTitle('Price Details'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  _priceRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  _priceRow(
                    'Shipping',
                    shipping == 0 ? 'FREE' : '\$${shipping.toStringAsFixed(2)}',
                    valueColor: shipping == 0 ? AppColors.success : null,
                  ),
                  const SizedBox(height: 10),
                  _priceRow('Tax (8%)', '\$${tax.toStringAsFixed(2)}'),
                  const Divider(height: 20),
                  _priceRow(
                    'Total',
                    '\$${total.toStringAsFixed(2)}',
                    isBold: true,
                    valueColor: AppColors.accent,
                  ),
                ],
              ),
            ),

            if (shipping == 0) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.local_shipping_outlined, color: AppColors.success, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'You qualify for FREE shipping! 🎉',
                      style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 100),
          ],
        ),
      ),

      // ── Place Order Button ──
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processPayment,
          child: _isProcessing
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                    Text('Processing...'),
                  ],
                )
              : Text('Place Order  •  \$${total.toStringAsFixed(2)}'),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
      ],
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? AppColors.textDark : AppColors.textLight,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? (isBold ? AppColors.textDark : AppColors.textLight),
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            fontSize: isBold ? 18 : 14,
          ),
        ),
      ],
    );
  }
}

// ── Input Formatters ──────────────────────────────────────────
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) buffer.write(' ');
      buffer.write(text[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
