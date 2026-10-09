import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/validators.dart';
import '../controller/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spaceLg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spaceLg),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header Branding
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(AppConstants.spaceSm),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.local_hospital,
                                size: 36,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spaceSm),
                            // FIX 1: Flexible lets the title shrink instead of overflowing
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  AppConstants.appName,
                                  maxLines: 1,
                                  style: theme.textTheme.displayMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.spaceSm),
                        Text(
                          'Clinic Patient Management System',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceLg),

                        // Role Selector
                        Text(
                          'Select User Role',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: AppConstants.spaceSm),
                        Obx(
                              () => DropdownButtonFormField<UserRole>(
                            // FIX 2: isExpanded gives items the full field width
                            isExpanded: true,
                            initialValue: controller.selectedRole.value,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.badge_outlined),
                            ),
                            items: UserRole.values.map((role) {
                              return DropdownMenuItem<UserRole>(
                                value: role,
                                child: Row(
                                  children: [
                                    Icon(role.icon, size: 20),
                                    const SizedBox(width: AppConstants.spaceSm),
                                    // Expanded + ellipsis stops long role names overflowing
                                    Expanded(
                                      child: Text(
                                        role.displayName,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (role) {
                              if (role != null) controller.setRole(role);
                            },
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceMd),

                        // Username Field
                        Text(
                          'Username or Email',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: AppConstants.spaceSm),
                        TextFormField(
                          controller: controller.usernameController,
                          validator: (v) =>
                              FormValidators.validateRequired(v, 'Username'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Enter your username',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceMd),

                        // Password Field
                        Text(
                          'Password',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: AppConstants.spaceSm),
                        Obx(
                              () => TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.isPasswordObscured.value,
                            validator: (v) =>
                                FormValidators.validateRequired(v, 'Password'),
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordObscured.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                                tooltip: controller.isPasswordObscured.value
                                    ? 'Show password'
                                    : 'Hide password',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceMd),

                        // Error message if any
                        Obx(() {
                          if (controller.errorMessage.value.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppConstants.spaceMd),
                            child: Container(
                              padding: const EdgeInsets.all(
                                  AppConstants.spaceSm + 2),
                              decoration: BoxDecoration(
                                color:
                                AppColors.destructive.withValues(alpha: 0.1),
                                borderRadius:
                                BorderRadius.circular(AppConstants.radiusSm),
                                border: Border.all(
                                  color: AppColors.destructive
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 20,
                                    color: AppColors.destructive,
                                  ),
                                  const SizedBox(width: AppConstants.spaceSm),
                                  Expanded(
                                    child: Text(
                                      controller.errorMessage.value,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: AppColors.destructive,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                        // Login Submit Button
                        Obx(
                              () {
                            final isLoading =
                                controller.viewState.value == ViewState.loading;
                            return ElevatedButton(
                              onPressed: isLoading ? null : controller.login,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColors.onAccent,
                                ),
                              )
                                  : const Text(
                                'Sign In to CarePulse',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}