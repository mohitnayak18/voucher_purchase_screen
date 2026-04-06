import 'package:flutter/material.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool isFocused = false;
  int quantity = 1;
  String paymentMethod = 'UPI';

  double get amount => double.tryParse(_amountController.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 16),
                    _imageAsset(),
                    const SizedBox(height: 16),
                    _buildAmountField(),
                    const SizedBox(height: 16),
                    _buildSummaryCard(),
                    const SizedBox(height: 16),
                    _buildPaymentMethod(),
                    const SizedBox(height: 16),
                    _buildQuantityStepper(),
                  ],
                ),
              ),
            ),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.share, size: 14),
                Text(
                  "Refer & Earn ₹100",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          const Icon(Icons.close),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Buy Voucher",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget _imageAsset() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("assets/images.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Focus(
      onFocusChange: (value) {
        setState(() => isFocused = value);
      },
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixText: "₹ ",
          hintText: "Enter amount",
          suffixText: "Max ₹5000",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isFocused ? Colors.green : Colors.grey,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    double savings = amount * 0.1;
    double pay = (amount - savings) * quantity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _row("YOU PAY", "₹ ${pay.toStringAsFixed(0)}"),
          const SizedBox(height: 8),
          _row("SAVINGS", "₹ ${savings.toStringAsFixed(0)}"),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _paymentTile('UPI'),
            const SizedBox(width: 10),
            _paymentTile('Card'),
          ],
        ),
      ],
    );
  }

  Widget _paymentTile(String method) {
    bool selected = paymentMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => paymentMethod = method);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected ? Colors.green.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: selected ? Colors.green : Colors.grey),
          ),
          child: Center(child: Text(method)),
        ),
      ),
    );
  }

  Widget _buildQuantityStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (quantity > 1) setState(() => quantity--);
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(quantity.toString()),
            IconButton(
              onPressed: () {
                setState(() => quantity++);
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.green,
          ),
          onPressed: () {},
          child: const Text("Pay Now", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
