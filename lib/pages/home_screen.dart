import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/controllers/textfield_controller.dart';
import 'package:todo_app/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyApp.changeColor(kLightBlueColor, Brightness.light);
    return Scaffold(
      floatingActionButton: const MyFloatingActionButton(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: const [
            TopSectionWidget(),
            BottomSectionWidget(),
          ],
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'hero',
      onPressed: () {
        Get.find<TaskController>().isEditing = false;
        Get.find<TextFieldController>().taskTitle!.text = '';
        Get.find<TextFieldController>().taskSubtitle!.text = '';
        //
        Get.toNamed('/addscreen')!.then((value) {
          MyApp.changeColor(kLightBlueColor, Brightness.light);
        });
      },
      backgroundColor: kLightBlueColor,
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }
}

class BottomSectionWidget extends StatelessWidget {
  const BottomSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Container(
          margin: const EdgeInsets.only(left: 50, top: 20, right: 10),
          child: Obx(() {
            return ListView.separated(
              itemBuilder: (context, index) {
                var task = Get.find<TaskController>().tasks[index];
                return ListTile(
                  onLongPress: () {
                    Get.find<TaskController>().tasks.removeAt(index);
                  },
                  title: Text(task.taskTitle ?? ''),
                  subtitle: Text(task.taskSubtitle ?? ''),
                  onTap: () {
                    Get.find<TaskController>().isEditing = true;
                    Get.find<TaskController>().index = index;
                    //
                    Get.find<TextFieldController>().taskTitle!.text =
                        task.taskTitle!;
                    //
                    Get.find<TextFieldController>().taskSubtitle!.text =
                        task.taskSubtitle!;

                    Get.toNamed('/addscreen');
                  },
                  trailing: Checkbox(
                    activeColor: kLightBlueColor,
                    onChanged: (value) {
                      task.status = !task.status!;
                      Get.find<TaskController>().tasks[index] = task;
                    },
                    value: task.status,
                    side: const BorderSide(
                      color: Colors.black45,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black45,
                  height: 1,
                );
              },
              itemCount: Get.find<TaskController>().tasks.length,
            );
          })),
    );
  }
}

class TopSectionWidget extends StatelessWidget {
  const TopSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: kLightBlueColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40.0, top: 20.0),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.bookmarks,
                  color: kLightBlueColor,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50.0, top: 20.0),
            child: const Text(
              'All',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 50.0, top: 5.0),
              child: Obx(() {
                return Text(
                  '${Get.find<TaskController>().tasks.length} Tasks',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                );
              })),
        ],
      ),
    );
  }
}
