
class TaskStatistic {
    TaskStatistic({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

TaskStatistic getdata()
{

    TaskStatistic taskStatistic=new TaskStatistic();
    taskStatistic.message="Message";
    taskStatistic.status=true;
    taskStatistic.data=[
      new Datum(completed: 50,inProgress: 30,todo: 20),
      new Datum(completed: 40,inProgress: 40,todo: 20),
      new Datum(completed: 30,inProgress: 50,todo: 20),
      new Datum(completed: 70,inProgress: 30,todo: 20),
    ];

    return taskStatistic;
}


    factory TaskStatistic.fromMap(Map<String, dynamic> json) => TaskStatistic(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Datum {
    Datum({
        this.todo,
        this.inProgress,
        this.completed,
    });

    int todo;
    int inProgress;
    int completed;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        todo: json["todo"] == null ? null : json["todo"],
        inProgress: json["in_progress"] == null ? null : json["in_progress"],
        completed: json["completed"] == null ? null : json["completed"],
    );

    Map<String, dynamic> toMap() => {
        "todo": todo == null ? null : todo,
        "in_progress": inProgress == null ? null : inProgress,
        "completed": completed == null ? null : completed,
    };
}
