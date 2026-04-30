import 'package:book_worm/utility/app_theme.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final Future<void> Function() onGetStarted;

  const OnboardingPage({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/worm.png',
                  width: 112,
                  height: 112,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Velkommen til Bokorm',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Din personlige boklogg for lesing, vurderinger, notater og fremdrift.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 15,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 28),
              const _OnboardingTip(
                icon: Icons.add_circle_outline,
                title: 'Legg til bøker',
                text:
                    'Trykk på Legg til bok for å søke, skanne strekkode eller registrere manuelt.',
              ),
              const _OnboardingTip(
                icon: Icons.edit_outlined,
                title: 'Rediger detaljer',
                text:
                    'Åpne en bok og trykk på redigeringsikonet for status, vurdering, sjanger og seksjoner.',
              ),
              const _OnboardingTip(
                icon: Icons.drag_handle,
                title: 'Tilpass seksjoner',
                text:
                    'I redigeringsmodus kan du dra seksjonskort for å endre rekkefølgen.',
              ),
              const _OnboardingTip(
                icon: Icons.delete_outline,
                title: 'Slett bøker',
                text:
                    'Hold inne en bok i biblioteket for å slette den etter bekreftelse.',
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: onGetStarted,
                child: const Text('Kom i gang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingTip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _OnboardingTip({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.divider.withValues(alpha: 0.65)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppTheme.primary, size: 21),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      text,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
