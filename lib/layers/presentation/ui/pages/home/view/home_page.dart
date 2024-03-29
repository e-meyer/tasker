import 'package:flutter_svg/svg.dart';

import 'package:tasker/layers/presentation/controllers/task_controller.dart';
import 'package:tasker/layers/presentation/ui/pages/home/components/home_filter_dropdown.dart';
import 'package:tasker/layers/presentation/ui/pages/home/components/home_task_list_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../core/injector/injector.dart';
import '../../../../../core/utils/constants.dart';
import '../components/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController taskController = serviceLocator.get<TaskController>();
  int homeSelectedFilter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    taskController.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          Navigator.pushNamed(context, kManageTaskRoute)
              .then((value) => setState(() {}));
        },
        elevation: 0,
        backgroundColor: kPrimaryColor,
        child: SvgPicture.asset('assets/icons/add-icon.svg'),
      ),
      backgroundColor: kMainBackground,
      appBar: const HomeAppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 26,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    HomeFilterDropdown(
                      currentIndex: homeSelectedFilter,
                      refresh: refresh,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                HomeTaskListBuilder(homeSelectedFilter: homeSelectedFilter),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  refresh(int index) {
    setState(() {
      homeSelectedFilter = index;
    });
  }
}
