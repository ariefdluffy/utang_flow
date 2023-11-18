import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utang_flow/service/db_service.dart';
import 'package:utang_flow/shared/util/validator/validator.dart';
import 'package:utang_flow/shared/widget/form/button/button.dart';
import 'package:utang_flow/shared/widget/form/textfield/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controller/login_controller.dart';
import '../state/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = LoginController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => controller,
      child: BlocListener<LoginController, LoginState>(
        listener: (context, state) {},
        child: BlocBuilder<LoginController, LoginState>(
          builder: (context, state) {
            final bloc = context.read<LoginController>();
            return buildView(context, bloc, state);
          },
        ),
      ),
    );
  }

  Widget buildView(
    BuildContext context,
    LoginController controller,
    LoginState state,
  ) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0.0, 10, 0),
                      child: Icon(
                        MdiIcons.monitor,
                        size: 64.0,
                        color: Color(0xff263238),
                      ),
                    ),
                    Text(
                      "Utang",
                      style: GoogleFonts.akayaKanadaka(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -10, 0),
                      child: Text(
                        "Flow",
                        style: GoogleFonts.blackOpsOne(
                          fontSize: 16.0,
                          color: Color(0xff263238),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              QTextField(
                label: "Email",
                validator: Validator.email,
                suffixIcon: Icons.email,
                value: controller.state.email,
                onChanged: (value) {
                  controller.state.email = value;
                  DBService.set("email", value);
                },
              ),
              QTextField(
                label: "Password",
                obscure: true,
                validator: Validator.required,
                suffixIcon: Icons.password,
                value: controller.state.password,
                onChanged: (value) {
                  controller.state.password = value;
                  // DBService.set("password", value);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              QButton(
                label: "Login",
                onPressed: () {
                  bool isValid = formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  controller.login();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
