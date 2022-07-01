import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/controllers/textfield_controller.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyApp.changeColor(const Color(0xFFF5F5F5), Brightness.dark);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MyCustomAppBar(),
            TitleWidget(),
            TaskTextField(),
            NoteWidget(),
            MyButton(),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: Get.width,
      height: 40.0,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          elevation: 0.0,
          backgroundColor: kLightBlueColor,
        ),
        onPressed: () {
          if (Get.find<TaskController>().isEditing) {
            // ویرایش کردن
            var task = Get.find<TaskController>()
                .tasks[Get.find<TaskController>().index];
            //
            task.taskTitle = Get.find<TextFieldController>().taskTitle!.text;
            task.taskSubtitle =
                Get.find<TextFieldController>().taskSubtitle!.text;

            //

            Get.find<TaskController>().tasks[Get.find<TaskController>().index] =
                task;

            //
          } else {
            // اضافه کردن
            Get.find<TaskController>().tasks.add(
                  TaskModel(
                    taskTitle: Get.find<TextFieldController>().taskTitle!.text,
                    taskSubtitle:
                        Get.find<TextFieldController>().taskSubtitle!.text,
                    status: false,
                  ),
                );
          }
          Get.back();
        },
        child: Text(Get.find<TaskController>().isEditing ? 'Edit' : 'Add'),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      child: TextField(
        controller: Get.find<TextFieldController>().taskSubtitle,
        maxLength: 30,
        cursorColor: kLightBlueColor,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.bookmark_border,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          counter: Container(),
          hintText: 'Add note',
        ),
      ),
    );
  }
}

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: Get.find<TextFieldController>().taskTitle,
        maxLines: 6,
        cursorColor: kLightBlueColor,
        cursorHeight: 40,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 10.0),
      child: Text(
        'What are you planning?',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget {
  const MyCustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 45.0),
            child: Text(
              Get.find<TaskController>().isEditing ? 'Edit Task' : 'New Task',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        Hero(
          tag: 'hero',
          child: Material(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        )
      ],
    );
  }
}
