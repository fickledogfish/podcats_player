import 'package:flutter/material.dart';
import 'package:podcats_player/view/components/deboncer.dart';

typedef SearchCallback = void Function(String);

class SearchTextField extends StatefulWidget {
  final String? hintText;

  final IconData searchIcon;
  final IconData clearTextIcon;

  final _controller = TextEditingController();
  final Debouncer? _debouncer;
  final SearchCallback _callback;

  SearchTextField({
    super.key,
    this.hintText,
    this.searchIcon = Icons.search,
    this.clearTextIcon = Icons.delete_outline,
    required SearchCallback callback,
  })  : _debouncer = null,
        _callback = callback;

  SearchTextField.withDebounce({
    super.key,
    this.hintText,
    this.searchIcon = Icons.search,
    this.clearTextIcon = Icons.delete_outline,
    Duration delay = const Duration(milliseconds: 500),
    required SearchCallback callback,
  })  : _debouncer = Debouncer(delay: delay),
        _callback = callback;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Widget get _prefixIcon => widget._controller.text.isEmpty
      ? Icon(widget.searchIcon)
      : IconButton(
          icon: Icon(widget.clearTextIcon),
          onPressed: _didPressClearSearch,
        );

  @override
  Widget build(BuildContext context) => TextField(
        controller: widget._controller,
        onChanged: _didChangeText,
        onSubmitted: _didSubmit,
        decoration: InputDecoration(
          prefixIcon: _prefixIcon,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(0),
        ),
      );

  void _didSubmit(String text) {
    if (widget._debouncer != null) return;
    widget._callback(text);
  }

  void _didChangeText(String text) {
    widget._debouncer?.run(() => widget._callback(text));
    setState(() {}); // To update the icon
  }

  void _didPressClearSearch() {
    widget._controller.clear();
    widget._debouncer?.cancel();
    setState(() {}); // To update the icon
  }
}
