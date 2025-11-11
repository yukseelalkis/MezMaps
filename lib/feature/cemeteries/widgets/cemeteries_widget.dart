part of '../view/cemeteries_view.dart';

/// The `_AllMapButton` class is a StatelessWidget in Dart that represents a button widget used in the
/// UI. Here's a breakdown of what it does:
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

/// The `_CemeteriesCard` class in Dart is a StatelessWidget that represents a card widget used in the
/// UI to display information about a cemetery. Here's a breakdown of what it does:
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
        contentPadding: PaddingManager.listItemPadding(context),
        title: Text(c.name),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),

        onTap: onTap,
      ),
    );
  }
}

/// The `_CemeteriesEmptyState` class in Dart is a `StatelessWidget` that represents a widget used in
/// the UI to display a message when there are no cemetery records available for a selected province and
/// district.
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

/// The `_CemeteriesList` class in Dart is a `StatelessWidget` that represents a list widget used in
/// the UI to display a list of cemetery items. Here's a breakdown of what it does:

@immutable
final class _CemeteriesList extends StatelessWidget {
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
          onTap: () async {
            final ok = await viewModel.openCemeteryMap(c);

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
