import 'package:pantau_pro/register/Home_page.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Kelas KunjunganPage sebagai StatefulWidget
class KunjunganPage extends StatefulWidget {
  const KunjunganPage({Key? key}) : super(key: key);

  @override
  _KunjunganPageState createState() => _KunjunganPageState();
}

// State dari KunjunganPage
class _KunjunganPageState extends State<KunjunganPage> {
  // Deklarasi variabel TextEditingController
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();
  final TextEditingController _perusahaanController = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();
  final TextEditingController _ketController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedDepartemen = 'keuangan';
  String _selectedSeksi = 'kurikulum/penilaian';

  // Opsi untuk dropdown Departemen dan Seksi
  List<String> departemenOptions = [
    'keuangan',
    'ketenagakerjaan',
    'paud/tk',
    'sd',
    'smp',
    'perencanaan',
    'lainnya'
  ];

  List<String> seksiOptions = [
    'kurikulum/penilaian',
    'sarana/prasarana',
    'pendidik_sd',
    'pendidik_smp',
    'lainnya'
  ];

  // Metode untuk mengirimkan form
  Future<void> _submitForm() async {
    final String apiUrl = 'http://localhost:8000/api/vip_flutter';

    Map<String, dynamic> data = {
      'nama': _namaController.text,
      'alamat': _alamatController.text,
      'keperluan': _tujuanController.text,
      'asal_instansi': _perusahaanController.text,
      'no_hp': _kontakController.text,
      'tanggal': _selectedDate.toIso8601String(),
      'jam': _selectedTime.format(context),
      'departemen': _selectedDepartemen,
      'seksi': _selectedSeksi,
      'status': 'pending', // Atur status menjadi "pending"
      'ket': _ketController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final successMessage = responseData['message'];
        showSnackBar(successMessage);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Handle non-JSON response
        showSnackBar('Terjadi kesalahan saat menyimpan data');
      }
    } catch (e) {
      print('Error: $e');
      showSnackBar('Terjadi kesalahan saat menyimpan data');
    }
  }

  // Menampilkan snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Form Kunjungan'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _namaController,
                        labelText: 'Nama *',
                        hintText: 'Masukkan nama',
                      ),
                      _buildTextField(
                        controller: _alamatController,
                        labelText: 'Alamat *',
                        hintText: 'Masukkan alamat',
                      ),
                      _buildTextField(
                        controller: _tujuanController,
                        labelText: 'Tujuan Kunjungan *',
                        hintText: 'Masukkan tujuan kunjungan',
                      ),
                      _buildTextField(
                        controller: _perusahaanController,
                        labelText: 'Asal Instansi *',
                        hintText: 'Masukkan nama Instansi',
                      ),
                      _buildTextField(
                        controller: _kontakController,
                        labelText: 'Nomor Telepon *',
                        hintText: 'Masukkan Nomor Telepon',
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        controller: _ketController,
                        labelText: 'Keterangan *',
                        hintText: 'Masukkan keterangan',
                      ),
                      _buildDropdown(
                        labelText: 'Departemen *',
                        value: _selectedDepartemen,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDepartemen = newValue.toString();
                          });
                        },
                        items: departemenOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      _buildDropdown(
                        labelText: 'Seksi *',
                        value: _selectedSeksi,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSeksi = newValue.toString();
                          });
                        },
                        items: seksiOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Tanggal Kunjungan *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            hintText: 'Pilih Tanggal Kunjungan',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${_selectedDate.toLocal()}".split(' ')[0],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Waktu Kunjungan *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            hintText: 'Pilih Waktu Kunjungan',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _selectedTime.format(context),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.access_time),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Ajukan Kunjungan',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown({
    required String labelText,
    required String value,
    required Function onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField(
          value: value,
          onChanged: onChanged as void Function(String?)?,
          items: items,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
