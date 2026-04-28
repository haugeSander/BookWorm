import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hjelp'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Funksjoner'),
            _buildFeatureContent(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFeatureContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem(
          'Sletting',
          'Det meste kan slettes ved å holde inne elementet og velge "Slett". Dette gjelder for eksempel notater, bilder og bøker.',
        ),
        _buildInfoItem(
          'Legge til bøker',
          'I denne versjonen legger du til bøker med den flytende knappen på biblioteksiden.',
        ),
        _buildInfoItem(
          'Legge til bilder',
          'Bilder kan legges til ved å ta et nytt bilde eller velge et bilde fra galleriet.',
        ),
        _buildInfoItem(
          'Legge til notater',
          'Slå på notater i innstillingene, åpne en faglitterær bok fra biblioteket, og trykk på redigeringsikonet for å legge til notater.',
        ),
      ],
    );
  }

  Widget _buildInfoItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
