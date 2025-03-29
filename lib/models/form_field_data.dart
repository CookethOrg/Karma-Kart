class FormFieldData {
  final String id;
  final String label;
  final bool required;
  final String? type;
  final String? placeholder;
  final String? hint;

  const FormFieldData({
    required this.id,
    required this.label,
    required this.required,
    this.type,
    this.placeholder,
    this.hint,
  });
}