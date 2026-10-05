// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_service_request_input.dart';

// **************************************************************************
// ReactiveFormsGenerator
// **************************************************************************

class ReactiveCreateServiceRequestInputFormConsumer extends StatelessWidget {
  const ReactiveCreateServiceRequestInputFormConsumer({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget? child;

  final Widget Function(BuildContext context,
      CreateServiceRequestInputForm formModel, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveCreateServiceRequestInputForm.of(context);

    if (formModel is! CreateServiceRequestInputForm) {
      throw FormControlParentNotFoundException(this);
    }
    return builder(context, formModel, child);
  }
}

class CreateServiceRequestInputFormInheritedStreamer
    extends InheritedStreamer<dynamic> {
  const CreateServiceRequestInputFormInheritedStreamer({
    Key? key,
    required this.form,
    required Stream<dynamic> stream,
    required Widget child,
  }) : super(
          stream,
          child,
          key: key,
        );

  final CreateServiceRequestInputForm form;
}

class ReactiveCreateServiceRequestInputForm extends StatelessWidget {
  const ReactiveCreateServiceRequestInputForm({
    Key? key,
    required this.form,
    required this.child,
    this.canPop,
    this.onPopInvokedWithResult,
  }) : super(key: key);

  final Widget child;

  final CreateServiceRequestInputForm form;

  final bool Function(FormGroup formGroup)? canPop;

  final ReactiveFormPopInvokedWithResultCallback<dynamic>?
      onPopInvokedWithResult;

  static CreateServiceRequestInputForm? of(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<
              CreateServiceRequestInputFormInheritedStreamer>()
          ?.form;
    }

    final element = context.getElementForInheritedWidgetOfExactType<
        CreateServiceRequestInputFormInheritedStreamer>();
    return element == null
        ? null
        : (element.widget as CreateServiceRequestInputFormInheritedStreamer)
            .form;
  }

  @override
  Widget build(BuildContext context) {
    return CreateServiceRequestInputFormInheritedStreamer(
      form: form,
      stream: form.form.statusChanged,
      child: ReactiveFormPopScope(
        canPop: canPop,
        onPopInvokedWithResult: onPopInvokedWithResult,
        child: child,
      ),
    );
  }
}

extension ReactiveReactiveCreateServiceRequestInputFormExt on BuildContext {
  CreateServiceRequestInputForm? createServiceRequestInputFormWatch() =>
      ReactiveCreateServiceRequestInputForm.of(this);

  CreateServiceRequestInputForm? createServiceRequestInputFormRead() =>
      ReactiveCreateServiceRequestInputForm.of(this, listen: false);
}

class CreateServiceRequestInputFormBuilder extends StatefulWidget {
  const CreateServiceRequestInputFormBuilder({
    Key? key,
    this.model,
    this.child,
    this.canPop,
    this.onPopInvokedWithResult,
    required this.builder,
    this.initState,
  }) : super(key: key);

  final CreateServiceRequestInput? model;

  final Widget? child;

  final bool Function(FormGroup formGroup)? canPop;

  final ReactiveFormPopInvokedWithResultCallback<dynamic>?
      onPopInvokedWithResult;

  final Widget Function(BuildContext context,
      CreateServiceRequestInputForm formModel, Widget? child) builder;

  final void Function(
      BuildContext context, CreateServiceRequestInputForm formModel)? initState;

  @override
  _CreateServiceRequestInputFormBuilderState createState() =>
      _CreateServiceRequestInputFormBuilderState();
}

class _CreateServiceRequestInputFormBuilderState
    extends State<CreateServiceRequestInputFormBuilder> {
  late CreateServiceRequestInputForm _formModel;

  StreamSubscription<LogRecord>? _logSubscription;

  @override
  void initState() {
    _formModel = CreateServiceRequestInputForm(
        CreateServiceRequestInputForm.formElements(widget.model), null);

    if (_formModel.form.disabled) {
      _formModel.form.markAsDisabled();
    }

    widget.initState?.call(context, _formModel);

    _logSubscription =
        _logCreateServiceRequestInputForm.onRecord.listen((LogRecord e) {
      // use `dumpErrorToConsole` for severe messages to ensure that severe
      // exceptions are formatted consistently with other Flutter examples and
      // avoids printing duplicate exceptions
      if (e.level >= Level.SEVERE) {
        final Object? error = e.error;
        FlutterError.dumpErrorToConsole(
          FlutterErrorDetails(
            exception: error is Exception ? error : Exception(error),
            stack: e.stackTrace,
            library: e.loggerName,
            context: ErrorDescription(e.message),
          ),
        );
      } else {
        log(
          e.message,
          time: e.time,
          sequenceNumber: e.sequenceNumber,
          level: e.level.value,
          name: e.loggerName,
          zone: e.zone,
          error: e.error,
          stackTrace: e.stackTrace,
        );
      }
    });

    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant CreateServiceRequestInputFormBuilder oldWidget) {
    if (widget.model != oldWidget.model) {
      _formModel.updateValue(widget.model);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _formModel.form.dispose();
    _logSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveCreateServiceRequestInputForm(
      key: ObjectKey(_formModel),
      form: _formModel,
      // canPop: widget.canPop,
      // onPopInvoked: widget.onPopInvoked,
      child: ReactiveFormBuilder(
        form: () => _formModel.form,
        canPop: widget.canPop,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        builder: (context, formGroup, child) =>
            widget.builder(context, _formModel, widget.child),
        child: widget.child,
      ),
    );
  }
}

final _logCreateServiceRequestInputForm =
    Logger.detached('CreateServiceRequestInputForm');

class CreateServiceRequestInputForm
    implements FormModel<CreateServiceRequestInput, CreateServiceRequestInput> {
  CreateServiceRequestInputForm(
    this.form,
    this.path,
  );

  static const String serviceTypeControlName = "serviceType";

  static const String descriptionControlName = "description";

  static const String preferredDateControlName = "preferredDate";

  static const String isUrgentControlName = "isUrgent";

  static const String imagePathControlName = "imagePath";

  final FormGroup form;

  final String? path;

  final Map<String, bool> _disabled = {};

  String serviceTypeControlPath() => pathBuilder(serviceTypeControlName);

  String descriptionControlPath() => pathBuilder(descriptionControlName);

  String preferredDateControlPath() => pathBuilder(preferredDateControlName);

  String isUrgentControlPath() => pathBuilder(isUrgentControlName);

  String imagePathControlPath() => pathBuilder(imagePathControlName);

  ServiceType? get _serviceTypeValue => serviceTypeControl.value;

  String get _descriptionValue => descriptionControl.value ?? '';

  DateTime? get _preferredDateValue => preferredDateControl.value;

  bool get _isUrgentValue => isUrgentControl.value ?? false;

  String? get _imagePathValue => imagePathControl.value;

  ServiceType? get _serviceTypeRawValue => serviceTypeControl.value;

  String get _descriptionRawValue => descriptionControl.value ?? '';

  DateTime? get _preferredDateRawValue => preferredDateControl.value;

  bool get _isUrgentRawValue => isUrgentControl.value ?? false;

  String? get _imagePathRawValue => imagePathControl.value;

  @Deprecated(
      'Generator completely wraps the form and ensures at startup that all controls are present inside the form so we do not need this additional step')
  bool get containsServiceType {
    try {
      form.control(serviceTypeControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  @Deprecated(
      'Generator completely wraps the form and ensures at startup that all controls are present inside the form so we do not need this additional step')
  bool get containsDescription {
    try {
      form.control(descriptionControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  @Deprecated(
      'Generator completely wraps the form and ensures at startup that all controls are present inside the form so we do not need this additional step')
  bool get containsPreferredDate {
    try {
      form.control(preferredDateControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  @Deprecated(
      'Generator completely wraps the form and ensures at startup that all controls are present inside the form so we do not need this additional step')
  bool get containsIsUrgent {
    try {
      form.control(isUrgentControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  @Deprecated(
      'Generator completely wraps the form and ensures at startup that all controls are present inside the form so we do not need this additional step')
  bool get containsImagePath {
    try {
      form.control(imagePathControlPath());
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, Object>? get serviceTypeErrors => serviceTypeControl.errors;

  Map<String, Object> get descriptionErrors => descriptionControl.errors;

  Map<String, Object>? get preferredDateErrors => preferredDateControl.errors;

  Map<String, Object> get isUrgentErrors => isUrgentControl.errors;

  Map<String, Object>? get imagePathErrors => imagePathControl.errors;

  void get serviceTypeFocus => form.focus(serviceTypeControlPath());

  void get descriptionFocus => form.focus(descriptionControlPath());

  void get preferredDateFocus => form.focus(preferredDateControlPath());

  void get isUrgentFocus => form.focus(isUrgentControlPath());

  void get imagePathFocus => form.focus(imagePathControlPath());

  @Deprecated(
      'Generator completely wraps the form so manual fields removal could lead to unexpected crashes')
  void serviceTypeRemove({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (containsServiceType) {
      final controlPath = path;
      if (controlPath == null) {
        form.removeControl(
          serviceTypeControlName,
          updateParent: updateParent,
          emitEvent: emitEvent,
        );
      } else {
        final formGroup = form.control(controlPath);

        if (formGroup is FormGroup) {
          formGroup.removeControl(
            serviceTypeControlName,
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }
      }
    }
  }

  @Deprecated(
      'Generator completely wraps the form so manual fields removal could lead to unexpected crashes')
  void preferredDateRemove({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (containsPreferredDate) {
      final controlPath = path;
      if (controlPath == null) {
        form.removeControl(
          preferredDateControlName,
          updateParent: updateParent,
          emitEvent: emitEvent,
        );
      } else {
        final formGroup = form.control(controlPath);

        if (formGroup is FormGroup) {
          formGroup.removeControl(
            preferredDateControlName,
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }
      }
    }
  }

  @Deprecated(
      'Generator completely wraps the form so manual fields removal could lead to unexpected crashes')
  void imagePathRemove({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (containsImagePath) {
      final controlPath = path;
      if (controlPath == null) {
        form.removeControl(
          imagePathControlName,
          updateParent: updateParent,
          emitEvent: emitEvent,
        );
      } else {
        final formGroup = form.control(controlPath);

        if (formGroup is FormGroup) {
          formGroup.removeControl(
            imagePathControlName,
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }
      }
    }
  }

  void serviceTypeValueUpdate(
    ServiceType? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    serviceTypeControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void descriptionValueUpdate(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    descriptionControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void preferredDateValueUpdate(
    DateTime? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    preferredDateControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void isUrgentValueUpdate(
    bool value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    isUrgentControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void imagePathValueUpdate(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    imagePathControl.updateValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void serviceTypeValuePatch(
    ServiceType? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    serviceTypeControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void descriptionValuePatch(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    descriptionControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void preferredDateValuePatch(
    DateTime? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    preferredDateControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void isUrgentValuePatch(
    bool value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    isUrgentControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void imagePathValuePatch(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    imagePathControl.patchValue(value,
        updateParent: updateParent, emitEvent: emitEvent);
  }

  void serviceTypeValueReset(
    ServiceType? value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      serviceTypeControl.reset(
        value: value,
        updateParent: updateParent,
        emitEvent: emitEvent,
        removeFocus: removeFocus,
        disabled: disabled,
      );

  void descriptionValueReset(
    String value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      descriptionControl.reset(
        value: value,
        updateParent: updateParent,
        emitEvent: emitEvent,
        removeFocus: removeFocus,
        disabled: disabled,
      );

  void preferredDateValueReset(
    DateTime? value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      preferredDateControl.reset(
        value: value,
        updateParent: updateParent,
        emitEvent: emitEvent,
        removeFocus: removeFocus,
        disabled: disabled,
      );

  void isUrgentValueReset(
    bool value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      isUrgentControl.reset(
        value: value,
        updateParent: updateParent,
        emitEvent: emitEvent,
        removeFocus: removeFocus,
        disabled: disabled,
      );

  void imagePathValueReset(
    String? value, {
    bool updateParent = true,
    bool emitEvent = true,
    bool removeFocus = false,
    bool? disabled,
  }) =>
      imagePathControl.reset(
        value: value,
        updateParent: updateParent,
        emitEvent: emitEvent,
        removeFocus: removeFocus,
        disabled: disabled,
      );

  FormControl<ServiceType> get serviceTypeControl =>
      form.control(serviceTypeControlPath()) as FormControl<ServiceType>;

  FormControl<String> get descriptionControl =>
      form.control(descriptionControlPath()) as FormControl<String>;

  FormControl<DateTime> get preferredDateControl =>
      form.control(preferredDateControlPath()) as FormControl<DateTime>;

  FormControl<bool> get isUrgentControl =>
      form.control(isUrgentControlPath()) as FormControl<bool>;

  FormControl<String> get imagePathControl =>
      form.control(imagePathControlPath()) as FormControl<String>;

  void serviceTypeSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      serviceTypeControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      serviceTypeControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void descriptionSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      descriptionControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      descriptionControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void preferredDateSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      preferredDateControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      preferredDateControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void isUrgentSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      isUrgentControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      isUrgentControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  void imagePathSetDisabled(
    bool disabled, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (disabled) {
      imagePathControl.markAsDisabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    } else {
      imagePathControl.markAsEnabled(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  @override
  CreateServiceRequestInput get model {
    final isValid = !currentForm.hasErrors && currentForm.errors.isEmpty;

    if (!isValid) {
      _logCreateServiceRequestInputForm.warning(
        'Avoid calling `model` on invalid form.Possible exceptions for non-nullable fields which should be guarded by `required` validator.',
        null,
        StackTrace.current,
      );
    }
    return CreateServiceRequestInput(
        serviceType: _serviceTypeValue,
        description: _descriptionValue,
        preferredDate: _preferredDateValue,
        isUrgent: _isUrgentValue,
        imagePath: _imagePathValue);
  }

  @override
  CreateServiceRequestInput get rawModel {
    return CreateServiceRequestInput(
        serviceType: _serviceTypeRawValue,
        description: _descriptionRawValue,
        preferredDate: _preferredDateRawValue,
        isUrgent: _isUrgentRawValue,
        imagePath: _imagePathRawValue);
  }

  @override
  void toggleDisabled({
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    final currentFormInstance = currentForm;

    if (currentFormInstance is! FormGroup) {
      return;
    }

    if (_disabled.isEmpty) {
      currentFormInstance.controls.forEach((key, control) {
        _disabled[key] = control.disabled;
      });

      currentForm.markAsDisabled(
          updateParent: updateParent, emitEvent: emitEvent);
    } else {
      currentFormInstance.controls.forEach((key, control) {
        if (_disabled[key] == false) {
          currentFormInstance.controls[key]?.markAsEnabled(
            updateParent: updateParent,
            emitEvent: emitEvent,
          );
        }

        _disabled.remove(key);
      });
    }
  }

  @override
  bool equalsTo(CreateServiceRequestInput? other) {
    final currentForm = this.currentForm;

    return const DeepCollectionEquality().equals(
      currentForm is FormControlCollection<dynamic>
          ? currentForm.rawValue
          : currentForm.value,
      CreateServiceRequestInputForm.formElements(other).rawValue,
    );
  }

  @override
  void submit({
    required void Function(CreateServiceRequestInput model) onValid,
    void Function()? onNotValid,
  }) {
    currentForm.markAllAsTouched();
    if (currentForm.valid) {
      onValid(model);
    } else {
      _logCreateServiceRequestInputForm.info('Errors');
      _logCreateServiceRequestInputForm.info('┗━━ ${form.errors}');
      onNotValid?.call();
    }
  }

  AbstractControl<dynamic> get currentForm {
    return path == null ? form : form.control(path!);
  }

  @override
  void updateValue(
    CreateServiceRequestInput? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.updateValue(
          CreateServiceRequestInputForm.formElements(value).rawValue,
          updateParent: updateParent,
          emitEvent: emitEvent);

  @override
  void reset({
    CreateServiceRequestInput? value,
    bool updateParent = true,
    bool emitEvent = true,
  }) =>
      form.reset(
          value: value != null ? formElements(value).rawValue : null,
          updateParent: updateParent,
          emitEvent: emitEvent);

  String pathBuilder(String? pathItem) =>
      [path, pathItem].whereType<String>().join(".");

  static FormGroup formElements(
          CreateServiceRequestInput? createServiceRequestInput) =>
      FormGroup({
        serviceTypeControlName: FormControl<ServiceType>(
            value: createServiceRequestInput?.serviceType,
            validators: [RequiredValidator()],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        descriptionControlName: FormControl<String>(
            value: createServiceRequestInput?.description,
            validators: [
              RequiredValidator(),
              NotBlankValidator(),
              MinLengthValidator(kMinDescriptionLength)
            ],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        preferredDateControlName: FormControl<DateTime>(
            value: createServiceRequestInput?.preferredDate,
            validators: [RequiredValidator()],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        isUrgentControlName: FormControl<bool>(
            value: createServiceRequestInput?.isUrgent,
            validators: [],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false),
        imagePathControlName: FormControl<String>(
            value: createServiceRequestInput?.imagePath,
            validators: [],
            asyncValidators: [],
            asyncValidatorsDebounceTime: 250,
            disabled: false,
            touched: false)
      },
          validators: [],
          asyncValidators: [],
          asyncValidatorsDebounceTime: 250,
          disabled: false);
}

class ReactiveCreateServiceRequestInputFormArrayBuilder<
        ReactiveCreateServiceRequestInputFormArrayBuilderT>
    extends StatelessWidget {
  const ReactiveCreateServiceRequestInputFormArrayBuilder({
    Key? key,
    this.control,
    this.formControl,
    this.builder,
    required this.itemBuilder,
    this.emptyBuilder,
    this.controlFilter,
  })  : assert(control != null || formControl != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final FormArray<ReactiveCreateServiceRequestInputFormArrayBuilderT>?
      formControl;

  final FormArray<ReactiveCreateServiceRequestInputFormArrayBuilderT>? Function(
      CreateServiceRequestInputForm formModel)? control;

  final Widget Function(BuildContext context, List<Widget> itemList,
      CreateServiceRequestInputForm formModel)? builder;

  final Widget Function(
      BuildContext context,
      int i,
      FormControl<ReactiveCreateServiceRequestInputFormArrayBuilderT> control,
      ReactiveCreateServiceRequestInputFormArrayBuilderT? item,
      CreateServiceRequestInputForm formModel) itemBuilder;

  final Widget Function(BuildContext context)? emptyBuilder;

  final bool Function(
      FormControl<ReactiveCreateServiceRequestInputFormArrayBuilderT>
          control)? controlFilter;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveCreateServiceRequestInputForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final builder = this.builder;
    final itemBuilder = this.itemBuilder;

    return ReactiveFormArrayItemBuilder<
        ReactiveCreateServiceRequestInputFormArrayBuilderT>(
      formControl: formControl ?? control?.call(formModel),
      builder: builder != null
          ? (context, itemList) => builder(
                context,
                itemList,
                formModel,
              )
          : null,
      itemBuilder: (
        context,
        i,
        control,
        item,
      ) =>
          itemBuilder(context, i, control, item, formModel),
      emptyBuilder: emptyBuilder,
      controlFilter: controlFilter,
    );
  }
}

class ReactiveCreateServiceRequestInputFormArrayBuilder2<
        ReactiveCreateServiceRequestInputFormArrayBuilderT>
    extends StatelessWidget {
  const ReactiveCreateServiceRequestInputFormArrayBuilder2({
    Key? key,
    this.control,
    this.formControl,
    this.builder,
    required this.itemBuilder,
    this.emptyBuilder,
    this.controlFilter,
  })  : assert(control != null || formControl != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final FormArray<ReactiveCreateServiceRequestInputFormArrayBuilderT>?
      formControl;

  final FormArray<ReactiveCreateServiceRequestInputFormArrayBuilderT>? Function(
      CreateServiceRequestInputForm formModel)? control;

  final Widget Function(
      ({
        BuildContext context,
        List<Widget> itemList,
        CreateServiceRequestInputForm formModel
      }) params)? builder;

  final Widget Function(
      ({
        BuildContext context,
        int i,
        FormControl<ReactiveCreateServiceRequestInputFormArrayBuilderT> control,
        ReactiveCreateServiceRequestInputFormArrayBuilderT? item,
        CreateServiceRequestInputForm formModel
      }) params) itemBuilder;

  final Widget Function(BuildContext context)? emptyBuilder;

  final bool Function(
      FormControl<ReactiveCreateServiceRequestInputFormArrayBuilderT>
          control)? controlFilter;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveCreateServiceRequestInputForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final builder = this.builder;
    final itemBuilder = this.itemBuilder;

    return ReactiveFormArrayItemBuilder<
        ReactiveCreateServiceRequestInputFormArrayBuilderT>(
      formControl: formControl ?? control?.call(formModel),
      builder: builder != null
          ? (context, itemList) => builder((
                context: context,
                itemList: itemList,
                formModel: formModel,
              ))
          : null,
      itemBuilder: (
        context,
        i,
        control,
        item,
      ) =>
          itemBuilder((
        context: context,
        i: i,
        control: control,
        item: item,
        formModel: formModel
      )),
      emptyBuilder: emptyBuilder,
      controlFilter: controlFilter,
    );
  }
}

class ReactiveCreateServiceRequestInputFormFormGroupArrayBuilder<
        ReactiveCreateServiceRequestInputFormFormGroupArrayBuilderT>
    extends StatelessWidget {
  const ReactiveCreateServiceRequestInputFormFormGroupArrayBuilder({
    Key? key,
    this.extended,
    this.getExtended,
    this.builder,
    required this.itemBuilder,
  })  : assert(extended != null || getExtended != null,
            "You have to specify `control` or `formControl`!"),
        super(key: key);

  final ExtendedControl<List<Map<String, Object?>?>,
          List<ReactiveCreateServiceRequestInputFormFormGroupArrayBuilderT>>?
      extended;

  final ExtendedControl<List<Map<String, Object?>?>,
          List<ReactiveCreateServiceRequestInputFormFormGroupArrayBuilderT>>
      Function(CreateServiceRequestInputForm formModel)? getExtended;

  final Widget Function(BuildContext context, List<Widget> itemList,
      CreateServiceRequestInputForm formModel)? builder;

  final Widget Function(
      BuildContext context,
      int i,
      ReactiveCreateServiceRequestInputFormFormGroupArrayBuilderT? item,
      CreateServiceRequestInputForm formModel) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final formModel = ReactiveCreateServiceRequestInputForm.of(context);

    if (formModel == null) {
      throw FormControlParentNotFoundException(this);
    }

    final value = (extended ?? getExtended?.call(formModel))!;

    return StreamBuilder<List<Map<String, Object?>?>?>(
      stream: value.control.valueChanges,
      builder: (context, snapshot) {
        final itemList = (value.value() ??
                <ReactiveCreateServiceRequestInputFormFormGroupArrayBuilderT>[])
            .asMap()
            .map((i, item) => MapEntry(
                  i,
                  itemBuilder(
                    context,
                    i,
                    item,
                    formModel,
                  ),
                ))
            .values
            .toList();

        return builder?.call(
              context,
              itemList,
              formModel,
            ) ??
            Column(children: itemList);
      },
    );
  }
}
