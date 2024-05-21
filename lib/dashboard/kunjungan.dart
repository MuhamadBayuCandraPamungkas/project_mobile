import 'package:flutter/material.dart';
import 'package:pantau_pro/register/Home_page.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KunjunganPage extends StatefulWidget {
  const KunjunganPage({Key? key}) : super(key: key);

  @override
  _KunjunganPageState createState() => _KunjunganPageState();
}

class _KunjunganPageState extends State<KunjunganPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();
  final TextEditingController _asalinstansiController = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _namaIsFilled = true;
  bool _alamatIsFilled = true;
  bool _keperluanIsFilled = true;
  bool _perusahaanIsFilled = true;
  bool _kontakIsFilled = true;
  bool _keteranganIsFilled = true;
  String _selectedDepartemen = 'keuangan';
  String _selectedSeksi = 'kurikulum/penilaian';
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

  Future<void> postData() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    String formattedTime =
        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
    try {
      final url =
          'http://localhost:8000/api/vip_flutter'; // Sesuaikan dengan URL API Laravel Anda
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nama': _namaController.text,
          'alamat': _alamatController.text,
          'keperluan': _keperluanController.text,
          'asal_instansi': _asalinstansiController.text,
          'no_hp': _kontakController.text,
          'tanggal': formattedDate,
          'jam': formattedTime,
          'departemen': _selectedDepartemen,
          'seksi': _selectedSeksi,
          'ket': _keteranganController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Data VIP berhasil disimpan');
        // Reset form fields
        _resetForm();
        // Show success message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data VIP berhasil disimpan'),
          duration: Duration(seconds: 2),
        ));
      } else {
        print('Gagal menyimpan data VIP: ${response.statusCode}');
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menyimpan data VIP: ${response.statusCode}'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void _resetForm() {
    _namaController.clear();
    _alamatController.clear();
    _keperluanController.clear();
    _asalinstansiController.clear();
    _kontakController.clear();
    _keteranganController.clear();
    setState(() {
      _namaIsFilled = true;
      _alamatIsFilled = true;
      _keperluanIsFilled = true;
      _perusahaanIsFilled = true;
      _kontakIsFilled = true;
      _keteranganIsFilled = true;
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
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
                        onChanged: (value) {
                          setState(() {
                            _namaIsFilled = value.isNotEmpty;
                          });
                        },
                        isFilled: _namaIsFilled,
                      ),
                      _buildTextField(
                        controller: _alamatController,
                        labelText: 'Alamat *',
                        hintText: 'Masukkan alamat',
                        onChanged: (value) {
                          setState(() {
                            _alamatIsFilled = value.isNotEmpty;
                          });
                        },
                        isFilled: _alamatIsFilled,
                      ),
                      _buildTextField(
                        controller: _keperluanController,
                        labelText: 'Tujuan Kunjungan *',
                        hintText: 'Masukkan tujuan kunjungan',
                        onChanged: (value) {
                          setState(() {
                            _keperluanIsFilled = value.isNotEmpty;
                          });
                        },
                        isFilled: _keperluanIsFilled,
                      ),
                      _buildTextField(
                        controller: _asalinstansiController,
                        labelText: 'Asal Instansi *',
                        hintText: 'Masukkan nama Instansi',
                        onChanged: (value) {
                          setState(() {
                            _perusahaanIsFilled = value.isNotEmpty;
                          });
                        },
                        isFilled: _perusahaanIsFilled,
                      ),
                      _buildTextField(
                        controller: _kontakController,
                        labelText: 'Nomor Telepon *',
                        hintText: 'Masukkan Nomor Telepon',
                        onChanged: (value) {
                          setState(() {
                            _kontakIsFilled = value.isNotEmpty;
                          });
                        },
                        isFilled: _kontakIsFilled,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        controller: _keteranganController,
                        labelText: 'Keterangan',
                        hintText: 'Masukkan keterangan',
                        onChanged: (value) {
                          setState(() {
                            _keteranganIsFilled = value.isNotEmpty;
                          });
                        },
                        isFilled: _keteranganIsFilled,
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate form before navigating
                    if (_validateForm()) {
                      // Post data if form is complete
                      postData();
                      // Navigate to home page if form is complete
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  },
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required ValueChanged<String> onChanged,
    required bool isFilled,
    bool readOnly = false,
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
          onChanged: onChanged,
          readOnly: readOnly,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            errorText: isFilled ? null : '$labelText harus diisi!',
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

  bool _validateForm() {
    _namaIsFilled = _namaController.text.isNotEmpty;
    _alamatIsFilled = _alamatController.text.isNotEmpty;
    _keperluanIsFilled = _keperluanController.text.isNotEmpty;
    _perusahaanIsFilled = _asalinstansiController.text.isNotEmpty;
    _kontakIsFilled = _kontakController.text.isNotEmpty;

    setState(() {});

    return _namaIsFilled &&
        _alamatIsFilled &&
        _keperluanIsFilled &&
        _perusahaanIsFilled &&
        _kontakIsFilled;
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
