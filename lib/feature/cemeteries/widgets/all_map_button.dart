part of '../view/cemeteries_view.dart';

@immutable
final class _AllMapButton extends StatelessWidget {
  const _AllMapButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.normalPaddingAll(context),
      child: FilledButton(
        onPressed: onPressed,
        child: const Text(ProjectString.allMapButton),
      ),
    );
  }
}

@immutable
final class _CemeteriesCard extends StatelessWidget {
  const _CemeteriesCard({required this.onTap, required this.c});

  final Cemetery c;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          c.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),

        onTap: onTap,
      ),
    );
  }
}

// CemeteriesView dosyasının altında (Private Widget olarak)
@immutable
final class _CemeteriesEmptyState extends StatelessWidget {
  const _CemeteriesEmptyState({
    required this.selectedProvince,
    required this.selectedDistrict,
  });

  final String? selectedProvince;
  final String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        selectedProvince == null
            ? ProjectString.selectProvince
            : '$selectedProvince / ${selectedDistrict ?? '-'} için kayıt yok',
      ),
    );
  }
}

class _CemeteriesList extends StatelessWidget {
  const _CemeteriesList({required this.cemeteries, required this.viewModel});

  final List<Cemetery> cemeteries;
  final CemetriesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: PaddingManager.lessPaddingAll(context),
      itemCount: cemeteries.length,
      separatorBuilder: (context, _) =>
          SizedBox(height: PaddingManager.normalPadding(context)),
      itemBuilder: (context, i) {
        final c = cemeteries[i];
        return _CemeteriesCard(
          c: c,
          // onTap mantığını burada tanımlıyoruz
          onTap: () async {
            // ViewModel'deki mantığı çağır
            final ok = await viewModel.openCemeteryMap(c);

            // UI'a ait hata gösterimini burada tutuyoruz
            if (!ok && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(ProjectString.errorMapMessage)),
              );
            }
          },
        );
      },
    );
  }
}
