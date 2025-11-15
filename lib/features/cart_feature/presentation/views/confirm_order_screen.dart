import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/utils/responsive.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  Map<String, String> _addressData = {
    'name': 'Utama Street No.20',
    'governorate': 'New York',
    'city': 'Dumbo',
    'fullAddress': 'Dumbo Street No.20, Dumbo, New York 10001, United States',
  };

  DateTime? _selectedDateTime;

  Future<void> _updateAddress() async {
    final result = await Navigator.pushNamed(context, '/setLocation');

    if (result != null && result is Map<String, String>) {
      setState(() {
        _addressData = result;
        _addressData['name'] = '${result['name']} - ${result['city']}';
        _addressData['fullAddress'] =
            '${result['name']}, ${result['city']}, ${result['governorate']}';
      });
    }
  }

  Future<void> _selectDateTime() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C47FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null || !mounted) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C47FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null) return;

    final DateTime combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    setState(() {
      _selectedDateTime = combinedDateTime;
    });
  }

  String _getFormattedDateTime() {
    if (_selectedDateTime == null) {
      return 'Choose date and time';
    }
    return DateFormat('MMM d, yyyy - h:mm a').format(_selectedDateTime!);
  }

  void _showOrderDetails() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.order_details,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.product_subtotal),
                  const Text('\$85.00'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.shipping),
                  const Text('\$2.00'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${AppLocalizations.of(context)!.tax} (5%)'),
                  const Text('\$4.25'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.discount),
                  const Text('-\$2.15', style: TextStyle(color: Colors.green)),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total Payment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$89.10',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C47FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _proceedToOrder() {
    if (_addressData['name'] != null && _addressData['name']!.isNotEmpty) {
      Navigator.pushNamed(context, '/orderReceived');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.please_set_address),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: Responsive.responsiveIconSize(context, 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.order_details,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
        actions: const [
          LanguageToggleButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.maxContentWidth(context);
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? double.infinity,
              ),
              child: SingleChildScrollView(
                padding: Responsive.responsivePadding(context),
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF6C47FF),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _addressData['name'] ?? 'No Address Set',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _addressData['fullAddress'] ??
                              AppLocalizations.of(context)!.please_set_address,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _updateAddress,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              color: Color(0xFF6C47FF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Price', style: TextStyle(color: Colors.grey)),
                      Text('\$87.10', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.shipping, style: const TextStyle(color: Colors.grey)),
                      const Text('\$2', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Total Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '\$89.10',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ✅ See details button (New Style)
                  InkWell(
                    onTap: _showOrderDetails,
                    borderRadius: BorderRadius.circular(6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'See details',
                          style: TextStyle(
                            color: Color(0xFF6C47FF),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xFF6C47FF),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Date & Time
            GestureDetector(
              onTap: _selectDateTime,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Color(0xFF6C47FF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date & time',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            _getFormattedDateTime(),
                            style: TextStyle(
                              color: _selectedDateTime != null
                                  ? const Color(0xFF6C47FF)
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: _selectedDateTime != null
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _proceedToOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C47FF),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.responsiveSpacing(context, 16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.responsiveBorderRadius(context, 12),
                          ),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.proceed_to_checkout,
                        style: TextStyle(
                          fontSize: Responsive.responsiveFontSize(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           ) );
        },
      ),
    );
  }
}
