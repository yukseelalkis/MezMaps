part of '../view/grave_search_view.dart';

/// Label:Value satırı gösteren küçük, tekrar kullanılabilir widget.
@immutable
final class KeyValueText extends StatelessWidget {
  const KeyValueText({
    super.key,
    required this.label,
    this.value,
    this.bold = true,
    this.color,
    this.gap = 4.0,
    this.placeholder = '—',
  });

  final String label;
  final String? value;
  final bool bold;
  final Color? color;
  final double gap;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? Theme.of(context).colorScheme.onSurface;
    final displayValue = (value == null || value!.trim().isEmpty)
        ? placeholder
        : value!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: baseColor.withValues(),
          ),
        ),
        SizedBox(width: gap),
        Text(displayValue, style: TextStyle(color: baseColor)),
      ],
    );
  }
}



@immutable
final class ResultCountText extends StatelessWidget {
  const ResultCountText({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      '${ProjectString.registerGrave} $count',
      style: TextStyle(color: cs.onSurfaceVariant),
    );
  }
}

@immutable
final class _SearchButton extends StatelessWidget {
  const _SearchButton({
    required this.formKey,
    required this.state,
    required this.viewModel,
  });

  final GlobalKey<FormState> formKey;
  final GraveSearchState state;
  final GraveSearchViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: const Icon(Icons.search),
        label: const Text(ProjectString.searchButton),
        onPressed: state.isLoading
            ? null
            : () {
                final ok = formKey.currentState!.validate();
                if (!ok) {
                  viewModel.enableAutovalidate();
                  return;
                }

                /// genelleme yapabilriiz
                if (!viewModel.validateBeforeSearch()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(ProjectString.errorSearchMessage),
                    ),
                  );
                  return;
                }

                viewModel.search();
              },
      ),
    );
  }
}

@immutable
final class GraveSearchForm extends StatefulWidget {
  const GraveSearchForm({
    super.key,
    required this.state,
    required this.viewModel,
    required this.formKey,
  });

  final GraveSearchState state;
  final GraveSearchViewModel viewModel;
  final GlobalKey<FormState> formKey;

  @override
  State<GraveSearchForm> createState() => _GraveSearchFormState();
}

class _GraveSearchFormState extends State<GraveSearchForm>
    with FormValidatorMixin {
  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final vm = widget.viewModel;

    return Form(
      key: widget.formKey,
      autovalidateMode: state.autovalidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Ad alanı
          Padding(
            padding: PaddingManager.verticalItemGap(context),
            child: CustomTextField(
              controller: state.nameCtrl,
              hintText: ProjectString.nameController,
              textInputAction: TextInputAction.next,

              validator: (v) => minLenOrNull(v, min: 2),
            ),
          ),

          /// Soyad alanı
          Padding(
            padding: PaddingManager.verticalItemGap(context),
            child: CustomTextField(
              controller: state.surnameCtrl,
              hintText: ProjectString.surnameController,

              textInputAction: TextInputAction.done,
              validator: (v) => minLenOrNull(v, min: 2),
            ),
          ),

          /// İl / İlçe alanı
          Padding(
            padding: PaddingManager.verticalItemGap(context),
            child: ProvinceDistrictRow(
              province: ProjectString.province,
              district: ProjectString.district,
              dataManager: vm,
            ),
          ),
        ],
      ),
    );
  }
}
