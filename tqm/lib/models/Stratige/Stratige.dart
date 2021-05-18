import 'Brch.dart';
import 'Goal.dart';
import 'Pointer.dart';
import 'Years.dart';
import 'ExecuteDept.dart';
import 'Overload.dart';

class StratigeModel {
  int id;
  String name;
  String img;
  String idOrg;
  int iduserEnter;
  DateTime dateEnter;

  List<BrchSrtModel> brchs = List<BrchSrtModel>();
  List<YearsModel> years = List<YearsModel>();
  List<GoalModel> goals = List<GoalModel>();
  String type;

  StratigeModel(
      {this.id,
      this.name,
      this.img,
      this.dateEnter,
      this.idOrg,
      this.iduserEnter,
      this.brchs,
      this.years,
      this.type});

  factory StratigeModel.fromJson(Map<String, dynamic> json) {
    return StratigeModel(
      id: json['id'],
      name: json['name'] as String,
      img: json['email'] as String,

      //brchs: json['img'],
    );
  }

  dynamic toJson(StratigeModel model) {
    var body = {
      "Id": model.id,
      "Name": model.name.toString(),
      "Img": model.img.toString(),
      "IdOrg": model.idOrg,
      "IduserEnter": 3,
      "DateEnter": DateTime.now(),
      'Years': years == null
          ? null
          : List<dynamic>.from(years.map((x) => x.toJson(x))),
      'brchStr': brchs == null
          ? null
          : List<dynamic>.from(brchs.map((x) => x.toJson(x))),
    };

    return body;
  }

  dynamic toJsonDataBase(StratigeModel model) {
    var body = {
      "Id": model.id,
      "Name": model.name,
      "Img": model.img,
      "IdOrg": model.idOrg,
      "IduserEnter": 1,
      "DateEnter": DateTime.now(),

      /* 'Years': years == null
          ? null
          : List<dynamic>.from(years.map((x) => x.toJson(x))),
      'brchStr': brchs == null
          ? null
          : List<dynamic>.from(brchs.map((x) => x.toJson(x))),
          */
    };

    return body;
  }

  StratigeModel.forDump(this.name, this.years, this.goals);

  static List<StratigeModel> get dumpStratigeList => [
        StratigeModel.forDump('إستراتيجية مكتب إدارة الجودة', [
          YearsModel(name: '2019', number: 2019, isActive: true),
          YearsModel(name: '2020', number: 2020, isActive: true),
          YearsModel(name: '2021', number: 2021, isActive: true),
          YearsModel(name: '2022', number: 2022, isActive: true),
        ], [
          GoalModel(
              name: 'نشر الوعي بمخاطر التدخين والمخدرات لدى طلاب التعليم العام',
              pointers: [
                PointerModel(
                    name: 'عدد البرامج التوعوية المقدمة لطلاب التعليم العام',
                    qty: 100000,
                    mCycle: [
                      MeasurementCycle.MARCH,
                      MeasurementCycle.JUNE,
                      MeasurementCycle.SEPTEMBER,
                      MeasurementCycle.DECEMBER,
                    ],
                    executeDept: [
                      ExecuteDeptModel(nameDept: 'التوعية', overload: [
                        OverloadModel(
                            nameBrch: 'الرياض',
                            qty: 50,
                            branchMCycle: [
                              BranchMCycle('1', '2019', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                                MCycleTarget('2', MeasurementCycle.JUNE, 3125),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 3125),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 4250),
                              ]),
                              BranchMCycle('2', '2020', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                                MCycleTarget('2', MeasurementCycle.JUNE, 3125),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 3125),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 4250),
                              ]),
                              BranchMCycle('3', '2021', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                                MCycleTarget('2', MeasurementCycle.JUNE, 3125),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 3125),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 4250),
                              ]),
                              BranchMCycle('4', '2022', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                                MCycleTarget('2', MeasurementCycle.JUNE, 2000),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 4250),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 4250),
                              ]),
                            ]),
                        OverloadModel(nameBrch: 'جدة', qty: 50, branchMCycle: [
                          BranchMCycle('1', '2019', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                            MCycleTarget('2', MeasurementCycle.JUNE, 2000),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 4250),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 4250),
                          ]),
                          BranchMCycle('2', '2020', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                            MCycleTarget('2', MeasurementCycle.JUNE, 2000),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 4250),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 4250),
                          ]),
                          BranchMCycle('3', '2021', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                            MCycleTarget('2', MeasurementCycle.JUNE, 2000),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 4250),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 4250),
                          ]),
                          BranchMCycle('4', '2022', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 2000),
                            MCycleTarget('2', MeasurementCycle.JUNE, 3125),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 3125),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 4250),
                          ]),
                        ]),
                      ])
                    ]),
                PointerModel(
                    name: 'نسبة انتشار الوعي لدى الطلاب بالتعليم العام',
                    qty: 40,
                    mCycle: [
                      MeasurementCycle.MARCH,
                      MeasurementCycle.JUNE,
                      MeasurementCycle.SEPTEMBER,
                      MeasurementCycle.DECEMBER,
                    ],
                    executeDept: [
                      ExecuteDeptModel(nameDept: 'التوعية', overload: [
                        OverloadModel(
                            nameBrch: 'الرياض',
                            qty: 50,
                            branchMCycle: [
                              BranchMCycle('1', '2019', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 1),
                                MCycleTarget('2', MeasurementCycle.JUNE, 1),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 1),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 2),
                              ]),
                              BranchMCycle('2', '2020', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 1),
                                MCycleTarget('2', MeasurementCycle.JUNE, 1),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 2),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                              ]),
                              BranchMCycle('3', '2021', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 1),
                                MCycleTarget('2', MeasurementCycle.JUNE, 2),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 1),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                              ]),
                              BranchMCycle('4', '2022', [
                                MCycleTarget('1', MeasurementCycle.MARCH, 2),
                                MCycleTarget('2', MeasurementCycle.JUNE, 1),
                                MCycleTarget(
                                    '3', MeasurementCycle.SEPTEMBER, 1),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                              ]),
                            ]),
                        OverloadModel(nameBrch: 'جدة', qty: 50, branchMCycle: [
                          BranchMCycle('1', '2019', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 1),
                            MCycleTarget('2', MeasurementCycle.JUNE, 1),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 2),
                          ]),
                          BranchMCycle('2', '2020', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 1),
                            MCycleTarget('2', MeasurementCycle.JUNE, 1),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 2),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                          ]),
                          BranchMCycle('3', '2021', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 1),
                            MCycleTarget('2', MeasurementCycle.JUNE, 2),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                          ]),
                          BranchMCycle('4', '2022', [
                            MCycleTarget('1', MeasurementCycle.MARCH, 2),
                            MCycleTarget('2', MeasurementCycle.JUNE, 1),
                            MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                          ]),
                        ]),
                      ])
                    ]),
              ]),
          GoalModel(name: 'بناء جيل واعي يمتلك المهارات الحياتية', pointers: [
            PointerModel(
                name: 'عدد المستفيدين من المهارات الحياتية',
                qty: 560,
                mCycle: [
                  MeasurementCycle.MARCH,
                  MeasurementCycle.JUNE,
                  MeasurementCycle.SEPTEMBER,
                  MeasurementCycle.DECEMBER,
                ],
                executeDept: [
                  ExecuteDeptModel(nameDept: 'التوعية', overload: [
                    OverloadModel(nameBrch: 'الرياض', qty: 50, branchMCycle: [
                      BranchMCycle('1', '2019', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                      BranchMCycle('2', '2020', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                      BranchMCycle('3', '2021', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                      BranchMCycle('4', '2022', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                    ]),
                    OverloadModel(nameBrch: 'جدة', qty: 50, branchMCycle: [
                      BranchMCycle('1', '2019', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                      BranchMCycle('2', '2020', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                      BranchMCycle('3', '2021', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                      BranchMCycle('4', '2022', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 10),
                        MCycleTarget('2', MeasurementCycle.JUNE, 20),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 20),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 20),
                      ]),
                    ]),
                  ])
                ]),
            PointerModel(
                name: 'عدد البرامج التدريبية المقدمة للمستفيدين',
                qty: 28,
                mCycle: [
                  MeasurementCycle.MARCH,
                  MeasurementCycle.JUNE,
                  MeasurementCycle.SEPTEMBER,
                  MeasurementCycle.DECEMBER,
                ],
                executeDept: [
                  ExecuteDeptModel(nameDept: 'التوعية', overload: [
                    OverloadModel(nameBrch: 'الرياض', qty: 50, branchMCycle: [
                      BranchMCycle('1', '2019', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 1),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 0),
                      ]),
                      BranchMCycle('2', '2020', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 1),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                      ]),
                      BranchMCycle('3', '2021', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 1),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                      ]),
                      BranchMCycle('4', '2022', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 0),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                      ]),
                    ]),
                    OverloadModel(nameBrch: 'جدة', qty: 50, branchMCycle: [
                      BranchMCycle('1', '2019', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 1),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 0),
                      ]),
                      BranchMCycle('2', '2020', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 1),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                      ]),
                      BranchMCycle('3', '2021', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 1),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                      ]),
                      BranchMCycle('4', '2022', [
                        MCycleTarget('1', MeasurementCycle.MARCH, 0),
                        MCycleTarget('2', MeasurementCycle.JUNE, 1),
                        MCycleTarget('3', MeasurementCycle.SEPTEMBER, 1),
                        MCycleTarget('4', MeasurementCycle.DECEMBER, 1),
                      ]),
                    ]),
                  ])
                ]),
          ]),
        ]),
        StratigeModel.forDump('إستراتيجية إدارة الأمن', [
          YearsModel(name: '2016', number: 2016, isActive: true),
          YearsModel(name: '2017', number: 2017, isActive: true),
          YearsModel(name: '2018', number: 2018, isActive: true),
        ], [
          GoalModel(
              name:
                  'غرس الثقافة الصحية بالأحياء، والتوعية بأضرار التدخين والمخدرات',
              pointers: [
                PointerModel(
                    name: 'عدد الأحياء التي تم تغطيتها ببرامج الجمعية',
                    qty: 50,
                    mCycle: [
                      MeasurementCycle.JUNE,
                      MeasurementCycle.DECEMBER,
                    ],
                    executeDept: [
                      ExecuteDeptModel(nameDept: 'التوعية', overload: [
                        OverloadModel(
                            nameBrch: 'الرياض',
                            qty: 30,
                            branchMCycle: [
                              BranchMCycle('1', '2016', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 2),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                              ]),
                              BranchMCycle('2', '2017', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 2),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                              ]),
                              BranchMCycle('3', '2018', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 2),
                                MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                              ]),
                            ]),
                        OverloadModel(nameBrch: 'جدة', qty: 30, branchMCycle: [
                          BranchMCycle('1', '2016', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 2),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                          ]),
                          BranchMCycle('2', '2017', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 2),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                          ]),
                          BranchMCycle('3', '2018', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 2),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                          ]),
                        ]),
                        OverloadModel(nameBrch: 'مكة', qty: 40, branchMCycle: [
                          BranchMCycle('1', '2016', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 3),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                          ]),
                          BranchMCycle('2', '2017', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 3),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 3),
                          ]),
                          BranchMCycle('3', '2018', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 4),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 4),
                          ]),
                        ]),
                      ])
                    ]),
                PointerModel(
                    name: 'عدد المستفيدين من الأحياء التي تمت تغطيتها',
                    qty: 4800,
                    mCycle: [
                      MeasurementCycle.JUNE,
                      MeasurementCycle.DECEMBER,
                    ],
                    executeDept: [
                      ExecuteDeptModel(nameDept: 'التوعية', overload: [
                        OverloadModel(
                            nameBrch: 'الرياض',
                            qty: 30,
                            branchMCycle: [
                              BranchMCycle('1', '2016', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 248),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 240),
                              ]),
                              BranchMCycle('2', '2017', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 248),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 240),
                              ]),
                              BranchMCycle('3', '2018', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 248),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 240),
                              ]),
                            ]),
                        OverloadModel(nameBrch: 'جدة', qty: 30, branchMCycle: [
                          BranchMCycle('1', '2016', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 248),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 240),
                          ]),
                          BranchMCycle('2', '2017', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 248),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 240),
                          ]),
                          BranchMCycle('3', '2018', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 248),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 240),
                          ]),
                        ]),
                        OverloadModel(nameBrch: 'مكة', qty: 40, branchMCycle: [
                          BranchMCycle('1', '2016', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 320),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 320),
                          ]),
                          BranchMCycle('2', '2017', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 320),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 320),
                          ]),
                          BranchMCycle('3', '2018', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 320),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 320),
                          ]),
                        ]),
                      ])
                    ]),
                PointerModel(
                    name: 'عدد طالبي العلاج من أهل الحي',
                    qty: 480,
                    mCycle: [
                      MeasurementCycle.JUNE,
                      MeasurementCycle.DECEMBER,
                    ],
                    executeDept: [
                      ExecuteDeptModel(nameDept: 'التوعية', overload: [
                        OverloadModel(
                            nameBrch: 'الرياض',
                            qty: 30,
                            branchMCycle: [
                              BranchMCycle('1', '2016', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 24),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 24),
                              ]),
                              BranchMCycle('2', '2017', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 24),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 24),
                              ]),
                              BranchMCycle('3', '2018', [
                                MCycleTarget('2', MeasurementCycle.JUNE, 24),
                                MCycleTarget(
                                    '4', MeasurementCycle.DECEMBER, 24),
                              ]),
                            ]),
                        OverloadModel(nameBrch: 'جدة', qty: 30, branchMCycle: [
                          BranchMCycle('1', '2016', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 24),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 24),
                          ]),
                          BranchMCycle('2', '2017', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 24),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 24),
                          ]),
                          BranchMCycle('3', '2018', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 24),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 24),
                          ]),
                        ]),
                        OverloadModel(nameBrch: 'مكة', qty: 40, branchMCycle: [
                          BranchMCycle('1', '2016', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 32),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 32),
                          ]),
                          BranchMCycle('2', '2017', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 32),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 32),
                          ]),
                          BranchMCycle('3', '2018', [
                            MCycleTarget('2', MeasurementCycle.JUNE, 32),
                            MCycleTarget('4', MeasurementCycle.DECEMBER, 32),
                          ]),
                        ]),
                      ])
                    ]),
              ]),
        ]),
      ];
}
