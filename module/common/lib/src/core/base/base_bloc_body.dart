import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BaseBlocBody] : BlocBuilder yapısını her view'da tekrar yazmamak için.
/// [VM] -> ViewModel türü (örnek: CemeteriesViewModel)
/// [S]  -> State türü (örnek: CemeteriesState)
final class BaseBlocBody<VM extends StateStreamable<S>, S>
    extends StatelessWidget {
  const BaseBlocBody({
    super.key,
    required this.bloc,
    required this.builder,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  final VM bloc;
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S state) isLoading;
  final String? Function(S state) error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<VM, S>(
      bloc: bloc,
      builder: (context, state) {
        if (isLoading(state)) {
          return const Center(child: CircularProgressIndicator());
        }
        if (error(state) != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hata: ${error(state)!}',
                  style: TextStyle(color: cs.error),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          );
        }
        // Normal durum: success state
        return builder(context, state);
      },
    );
  }
}
