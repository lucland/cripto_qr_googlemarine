/*import 'package:cripto_qr_googlemarine/pages/editar/editar.dart';
import 'package:cripto_qr_googlemarine/utils/formatter.dart';
import 'package:cripto_qr_googlemarine/utils/ui/ui.dart';
import 'package:cripto_qr_googlemarine/widgets/checkout_button_widget.dart';
import 'package:cripto_qr_googlemarine/widgets/print_button_widget.dart';
import 'package:cripto_qr_googlemarine/widgets/title_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../../utils/theme.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(UserRepository()),
      child: Container(
        color: CQColors.white,
        child: LoginView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoginError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is LoginLoaded) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: CQColors.background,
              foregroundColor: CQColors.iron100,
              elevation: 0,
              title: const Text(CQStrings.informacoes,
                  style: CQTheme.h2, overflow: TextOverflow.ellipsis),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          color: CQColors.iron100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(user.nome,
                                    style: CQTheme.h1.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text('|   N° ${user.numero.toString()}',
                                  style:
                                      CQTheme.h1.copyWith(color: Colors.white),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        if (user.isOnboarded)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            color: CQColors.success20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: CQColors.success120,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(CQStrings.aBordo,
                                    style: CQTheme.h1.copyWith(
                                        color: CQColors.success120,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TitleValueWidget(
                                title: CQStrings.funcao,
                                value: user.funcao,
                                color: CQColors.iron100,
                              ),
                              const SizedBox(height: 12),
                              TitleValueWidget(
                                title: CQStrings.empresaTrip,
                                value: user.empresa,
                                color: CQColors.iron100,
                              ),
                              const SizedBox(height: 12),
                              TitleValueWidget(
                                title: CQStrings.identidade,
                                value: Formatter.identidade(user.identidade),
                                color: CQColors.iron100,
                              ),
                              if (user.email != '') ...[
                                const SizedBox(height: 12),
                                TitleValueWidget(
                                  title: CQStrings.email,
                                  value: user.email,
                                  color: CQColors.iron100,
                                ),
                              ],
                              const SizedBox(height: 12),
                              TitleValueWidget(
                                title: CQStrings.embarcacao,
                                value: user.vessel,
                                color: CQColors.iron100,
                              ),
                              const SizedBox(height: 12),
                              TitleValueWidget(
                                title: CQStrings.area,
                                value: user.area,
                                color: CQColors.iron100,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: CQColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    CQStrings.validades,
                                    style: CQTheme.h1.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: Divider(
                                      color: CQColors.slate100,
                                      thickness: 0.3,
                                    ),
                                  ),
                                  TitleValueWidget(
                                    title: CQStrings.aso,
                                    value: Formatter.formatDateTime(
                                        user.ASO.toDate()),
                                    color: CQColors.iron100,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleValueWidget(
                                        title: CQStrings.nr34,
                                        value: Formatter.formatDateTime(
                                            user.NR34.toDate()),
                                        color: CQColors.iron100,
                                      ),
                                      TitleValueWidget(
                                        title: CQStrings.nr10,
                                        value: Formatter.formatDateTime(
                                            user.NR10.toDate()),
                                        color: CQColors.iron100,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleValueWidget(
                                        title: CQStrings.nr33,
                                        value: Formatter.formatDateTime(
                                            user.NR33.toDate()),
                                        color: CQColors.iron100,
                                      ),
                                      TitleValueWidget(
                                        title: CQStrings.nr35,
                                        value: Formatter.formatDateTime(
                                            user.NR35.toDate()),
                                        color: CQColors.iron100,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: CQColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        CQStrings.estadia,
                                        style: CQTheme.h1.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                        child: Divider(
                                          color: CQColors.iron100,
                                          thickness: 0.3,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            CQStrings.de,
                                            style: CQTheme.body.copyWith(
                                              color: CQColors.iron100,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            Formatter.formatDateTime(
                                                user.dataInicial.toDate()),
                                            style: CQTheme.body.copyWith(
                                              color: CQColors.iron100,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            CQStrings.ate,
                                            style: CQTheme.body.copyWith(
                                              color: CQColors.iron100,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            Formatter.formatDateTime(
                                                user.dataLimite.toDate()),
                                            style: CQTheme.body.copyWith(
                                              color: CQColors.iron100,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 16),
                          child: Card(
                            color: CQColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    CQStrings.eventos,
                                    style: CQTheme.h1.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: Divider(
                                      color: CQColors.slate100,
                                      thickness: 0.3,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.eventos.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.eventos[index].acao,
                                            style: CQTheme.body.copyWith(
                                              color: CQColors.iron100,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              Formatter.fromatHourDateTime(state
                                                  .eventos[index].createdAt
                                                  .toDate()),
                                              style: CQTheme.body.copyWith(
                                                color: CQColors.iron100,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckOutButtonWidget(
                      onPressed: () {
                        cubit.createCheckoutEvento(
                            user.identidade, user.vessel);
                      },
                      isDisabled:
                          !(state.eventos[0].acao == CQStrings.checkOut ||
                              user.isOnboarded == true),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Erro desconhecido'));
        }
      },
    );
  }
}
*/