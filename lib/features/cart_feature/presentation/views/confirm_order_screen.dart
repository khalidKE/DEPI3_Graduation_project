import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/features/cart_feature/presentation/views/set_location_screen.dart';
import 'package:books/features/cart_feature/presentation/views/order_recieved_screen.dart';

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
    if (!mounted) return;
    
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const SetLocationScreen(),
      ),
    );

    if (result != null && mounted) {
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
      return AppLocalizations.of(context)!.choose_date_and_time;
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
          padding: Responsive.responsivePadding(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Responsive.responsiveSpacing(context, 40),
                  height: 4,
                  margin: EdgeInsets.only(
                    bottom: Responsive.responsiveSpacing(context, 12),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.order_details,
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.product_subtotal,
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 14),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$85.00',
                    style: TextStyle(
                      fontSize: Responsive.responsiveFontSize(context, 14),
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.shipping,
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 14),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$2.00',
                    style: TextStyle(
                      fontSize: Responsive.responsiveFontSize(context, 14),
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '${AppLocalizations.of(context)!.tax} (5%)',
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 14),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$4.25',
                    style: TextStyle(
                      fontSize: Responsive.responsiveFontSize(context, 14),
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.discount,
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 14),
                        color: Colors.green,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '-\$2.15',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: Responsive.responsiveFontSize(context, 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 12)),
              const Divider(),
              SizedBox(height: Responsive.responsiveSpacing(context, 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.total_payment,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.responsiveFontSize(context, 16),
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$89.10',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.responsiveFontSize(context, 16),
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 20)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C47FF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.responsiveSpacing(context, 12),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Responsive.responsiveBorderRadius(context, 8),
                      ),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.close,
                    style: TextStyle(
                      fontSize: Responsive.responsiveFontSize(context, 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _proceedToOrder() {
    if (!mounted) return;
    
    if (_addressData['name'] != null && _addressData['name']!.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderReceivedScreen(),
        ),
      );
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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: Responsive.responsiveIconSize(context, 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.order_details,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
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
                      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 12),
                        ),
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
                            padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 8)),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                Responsive.responsiveBorderRadius(context, 8),
                              ),
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: const Color(0xFF6C47FF),
                              size: Responsive.responsiveIconSize(context, 20),
                            ),
                          ),
                          SizedBox(width: Responsive.responsiveSpacing(context, 12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _addressData['name'] ?? AppLocalizations.of(context)!.no_address_set,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.responsiveFontSize(context, 16),
                                    color: Theme.of(context).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                SizedBox(height: Responsive.responsiveSpacing(context, 4)),
                                Text(
                                  _addressData['fullAddress'] ??
                                      AppLocalizations.of(context)!.please_set_address,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                  ),
                                ),
                                SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                                TextButton(
                                  onPressed: _updateAddress,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.change,
                                    style: TextStyle(
                                      color: const Color(0xFF6C47FF),
                                      fontSize: Responsive.responsiveFontSize(context, 14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: Responsive.responsiveIconSize(context, 16),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),

                    // Summary Box
                    Container(
                      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 12),
                        ),
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
                          Text(
                            AppLocalizations.of(context)!.summary,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.responsiveFontSize(context, 16),
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!.price,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '\$87.10',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                  fontSize: Responsive.responsiveFontSize(context, 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!.shipping,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '\$2',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                  fontSize: Responsive.responsiveFontSize(context, 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!.total_payment,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Responsive.responsiveFontSize(context, 16),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '\$89.10',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                  fontSize: Responsive.responsiveFontSize(context, 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),

                          // See details button
                          InkWell(
                            onTap: _showOrderDetails,
                            borderRadius: BorderRadius.circular(
                              Responsive.responsiveBorderRadius(context, 6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.see_details,
                                  style: TextStyle(
                                    color: const Color(0xFF6C47FF),
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: Responsive.responsiveSpacing(context, 4)),
                                Icon(
                                  Icons.chevron_right,
                                  color: const Color(0xFF6C47FF),
                                  size: Responsive.responsiveIconSize(context, 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),

                    // Date & Time
                    GestureDetector(
                      onTap: _selectDateTime,
                      child: Container(
                        padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(
                            Responsive.responsiveBorderRadius(context, 12),
                          ),
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
                              padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 8)),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(context, 8),
                                ),
                              ),
                              child: Icon(
                                Icons.calendar_month,
                                color: const Color(0xFF6C47FF),
                                size: Responsive.responsiveIconSize(context, 20),
                              ),
                            ),
                            SizedBox(width: Responsive.responsiveSpacing(context, 12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.date_and_time,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Responsive.responsiveFontSize(context, 16),
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  Text(
                                    _getFormattedDateTime(),
                                    style: TextStyle(
                                      color: _selectedDateTime != null
                                          ? const Color(0xFF6C47FF)
                                          : Colors.grey,
                                      fontSize: Responsive.responsiveFontSize(context, 14),
                                      fontWeight: _selectedDateTime != null
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: Responsive.responsiveIconSize(context, 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: Responsive.responsiveSpacing(context, 20),
                    ),

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
          ));
        
      },
    ),
    );
  }
}
