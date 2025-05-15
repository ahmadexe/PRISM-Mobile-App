import 'package:flutter/material.dart';
import 'package:prism/models/job/job.dart';

class JobProvider extends ChangeNotifier {
  Job? selectedJob;

  void selectJob(Job job) {
    selectedJob = job;
    notifyListeners();
  }
}
