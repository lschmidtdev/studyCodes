import 'package:clean_architecture_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture_app/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:clean_architecture_app/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:clean_architecture_app/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:clean_architecture_app/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:clean_architecture_app/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  throw Exception('Unhandled state, test porpuse only: $state');
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
