import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radix_icons/radix_icons.dart';
import '../../providers/trade_provider.dart';

class CustomTagSelector extends StatefulWidget {
  final List<String>? initialTags; // Optional initial tags
  // final Function(List<String>)? onTagsChanged; // Callback when tags change

  const CustomTagSelector({
    super.key,
    this.initialTags,
    // this.onTagsChanged,
  });

  @override
  State<CustomTagSelector> createState() => _CustomTagSelectorState();
}

class _CustomTagSelectorState extends State<CustomTagSelector> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isSearching = false;
  double _overlayOffset = 0;
  bool _showAbove = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Add a small delay to ensure keyboard is fully shown before showing overlay
        Future.delayed(const Duration(milliseconds: 100), () {
          if (!_isDisposed) {
            _showOverlay();
          }
        });
      } else {
        _hideOverlay();
      }
    });

    // Initialize with any provided tags
    if (widget.initialTags != null && widget.initialTags!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isDisposed && mounted) {
          final provider = Provider.of<TradeProvider>(context, listen: false);
          for (final tag in widget.initialTags!) {
            provider.addTag(tag);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _hideOverlay();
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showOverlay() {
    if (_isDisposed || !mounted) return;
    
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // Calculate visible area considering keyboard
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final position = renderBox.localToGlobal(Offset.zero);

    // Available space below the input field
    final availableSpaceBelow =
        screenHeight - position.dy - size.height - keyboardHeight;
    // Available space above the input field
    final availableSpaceAbove = position.dy;

    // Desired dropdown height
    final dropdownHeight = 200.h;

    // Determine whether to show above or below
    _showAbove =
        availableSpaceBelow < dropdownHeight &&
        availableSpaceAbove > availableSpaceBelow;

    if (_showAbove) {
      // Position above with proper offset (negative to go up)
      _overlayOffset = -dropdownHeight;
    } else {
      // Position below with small gap
      _overlayOffset = size.height + 1.h;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, _overlayOffset),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12.r),
            color: const Color(0xFF1A1E2E),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    _showAbove
                        ? min(dropdownHeight, availableSpaceAbove - 16.h)
                        : min(dropdownHeight, availableSpaceBelow - 16.h),
                maxWidth: size.width,
              ),
              child: _buildSearchDropdown(),
            ),
          ),
        ),
      ),
    );

    if (!_isDisposed && mounted) {
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isSearching = true);
    }
  }

  // Helper function to get the minimum of two numbers
  double min(double a, double b) => a < b ? a : b;

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    
    if (!_isDisposed && mounted) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  Widget _buildSearchDropdown() {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        final selectedTags = tradeProvider.selectedTags;
        final allTags = tradeProvider.availableTags;

        final filteredTags =
            allTags
                .where(
                  (tag) =>
                      tag.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      ) &&
                      !selectedTags.contains(tag),
                )
                .toList();

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: true,
            overscroll: false,
            physics: const ClampingScrollPhysics(),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: filteredTags.length,
            itemBuilder: (context, index) {
              final tag = filteredTags[index];
              return ListTile(
                dense: true,
                title: Text(
                  tag,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                onTap: () {
                  tradeProvider.addTag(tag);

                  // Call the callback with updated tags
                  tradeProvider.onChangeTags(tradeProvider.selectedTags);

                  _searchController.clear();
                  _focusNode.unfocus();
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                hoverColor: Colors.white.withOpacity(0.1),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        final selectedTags = tradeProvider.selectedTags;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Tags',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),
            CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF141625),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color:
                        _isSearching
                            ? Colors.white.withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      style: TextStyle(color: Colors.white, fontSize: 22.sp),
                      decoration: InputDecoration(
                        hintText:
                            selectedTags.length < 5
                                ? "Search or add tags (up to 5)"
                                : "Maximum 5 tags reached",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 22.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        suffixIcon:
                            _isSearching
                                ? IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 24.sp,
                                  ),
                                  onPressed: null,
                                )
                                : null,
                      ),
                      onChanged: (value) {
                        if (_overlayEntry != null) {
                          _overlayEntry!.markNeedsBuild();
                        }
                      },
                      enabled: selectedTags.length < 5,
                    ),
                    if (selectedTags.isNotEmpty) SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children:
                          selectedTags.map((tag) {
                            return _buildTagChip(tag, tradeProvider);
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTagChip(String tag, TradeProvider tradeProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F2E),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tag, style: TextStyle(color: Colors.white, fontSize: 20.sp)),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () {
              tradeProvider.removeTag(tag);
              tradeProvider.onChangeTags(tradeProvider.selectedTags);
            },
            child: Icon(
              RadixIcons.Cross_1,
              size: 18.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}