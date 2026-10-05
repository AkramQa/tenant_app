import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/core/presentation/providers/auth/auth_notifier.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_elevated_button.dart';
import 'package:tenant_app/core/presentation/widgets/fields/base_reactive_text_field.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/screen_loader.dart';
import 'package:tenant_app/core/presentation/widgets/screen_utils.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/theme/app_breakpoints.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/home/presentation/screens/home_screen.dart';
import 'package:tenant_app/features/auth/presentation/providers/sign_in/sign_in_notifier.dart';
import 'package:tenant_app/features/auth/presentation/ui_models/sign_in_input.dart';
import 'package:tenant_app/features/auth/presentation/widgets/demo_credentials_widget.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  static const String routePath = '/sign-in';

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> with ScreenLoader, ScreenUtils {
  @override
  Widget screen(BuildContext context) {
    ref.listen<SignInState>(signInProvider, (previous, state) {
      switch (state) {
        case SignInLoading():
          startLoading();
        case SignInFailure(:final failure):
          stopLoading();
          handleError(
            failure: failure,
            customMessages: {ServerErrorCode.wrongInput: context.l10n.incorrect_email_phone_or_password},
          );
        case SignInSuccessful(:final signInResponse):
          stopLoading();
          ref.read(authProvider.notifier).setAuthenticated(signInResponse.tenant);
          context.go(HomeScreen.routePath);
        case SignInInitial():
          break;
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SignInInputFormBuilder(
          model: SignInInput(),
          builder: (BuildContext context, SignInInputForm form, Widget? child) {
            return Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: ResponsiveCenterWidget(
                  maxWidth: AppBreakpoints.maxFormWidth,
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: BaseIconContainerWidget(
                            icon: Icons.apartment_rounded,
                            color: context.colors.primary,
                            size: 64.r,
                          ),
                        ),
                        const SpacerH24(),
                        Text(
                          context.l10n.welcome_back,
                          style: context.textTheme.headings.heading2.copyWith(color: context.colors.cardTitle),
                        ),
                        const SpacerH8(),
                        Text(
                          context.l10n.sign_in_to_manage_your_home_services,
                          style: context.bodyLarge?.copyWith(color: context.colors.cardSubTitle),
                        ),
                        const SpacerH32(),
                        BaseReactiveTextField.borderedTextField(
                          controller: form.identifierControl,
                          nextController: form.passwordControl,
                          label: context.l10n.email_or_phone_number,
                          hintText: context.l10n.email_or_phone_number_hint,
                          textInputType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email, AutofillHints.telephoneNumber],
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                        ),
                        const SpacerH16(),
                        BaseReactiveTextField.borderedTextField(
                          controller: form.passwordControl,
                          label: context.l10n.password,
                          hintText: context.l10n.enter_your_password,
                          userObscure: true,
                          autofillHints: const [AutofillHints.password],
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          onSubmitForm: () => signIn(form),
                          validationMessages: {
                            ValidationMessage.minLength: (_) =>
                                context.l10n.password_must_be_at_least_n_characters(kMinPasswordLength),
                          },
                        ),
                        const SpacerH24(),
                        BaseElevatedButton.primary(
                          label: context.l10n.sign_in,
                          onPressed: () => signIn(form),
                        ),
                        const SpacerH24(),
                        DemoCredentialsWidget(
                          onUseDemoAccount: () {
                            form.identifierValueUpdate(kDemoEmail);
                            form.passwordValueUpdate(kDemoPassword);
                            form.form.markAllAsTouched();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void signIn(SignInInputForm form) {
    if (!form.form.valid) {
      form.form.markAllAsTouched();
      return;
    }
    TextInput.finishAutofillContext();
    ref.read(signInProvider.notifier).signIn(form.model);
  }
}
