import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtobe_demo/screen/testcode/bloc/test_bloc.dart';
import 'package:youtobe_demo/screen/widget/big_text.dart';

class TestCodeScreem extends StatelessWidget {
  const TestCodeScreem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "TestCode",),
      ),
      body: BlocProvider(
        create: (context) => TestBloc()..add(LoadDataEvent()),
        child: BlocBuilder<TestBloc,  TestState>(
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                  ),
                  IconButton(onPressed: (){
                    print(_textController.value.text);
                    context.read<TestBloc>()
                        .add(AddStringEvent(text: _textController.value.text));
                  }, icon: Icon(Icons.add)),
                  if(state is TestLoaded)
                  Column(
                    children:List.generate(state.listText.length, (index) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      color: Colors.green,
                      child: BigText(text: state.listText[index],),
                    ))
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
