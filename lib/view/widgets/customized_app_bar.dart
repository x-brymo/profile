import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:reflect_ui/reflect_ui.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomizedAppBar({
    super.key,
    this.leading,
    required this.title,
    this.actions,
  });

  final Widget? leading;
  final Widget title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12);
    Widget? leadingWidget = leading;
    if (leadingWidget == null) {
      if (canPop) {
        padding = const EdgeInsets.symmetric(horizontal: 6);
        leadingWidget = IconButton(
          useCloseButton
              ? FluentIcons.dismiss_20_regular
              : FluentIcons.chevron_left_24_regular,
          variant: IconButtonVariant.outlined,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      }
    }

    return SafeArea(
      child: Container(
        height: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            if (leadingWidget != null)
              Container(
                padding: const EdgeInsets.only(right: 4),
                child: leadingWidget,
              ),
            const SizedBox(width: 4),
            DefaultTextStyle(
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              child: title,
            ),
            Expanded(child: Container()),
            if ((actions ?? []).isNotEmpty)
              GappedRow(
                gap: 4,
                children: actions!,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}