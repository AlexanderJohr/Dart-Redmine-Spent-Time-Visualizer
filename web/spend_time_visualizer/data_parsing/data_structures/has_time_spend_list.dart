part of spend_time_visualizer;

abstract class HasTimeSpendList{

  final List<RedmineTimeSpend> timeSpendList;





  HasTimeSpendList(List<RedmineTimeSpend> timeSpendList)
      : timeSpendList = initTimeSpendList(timeSpendList);

  static initTimeSpendList(List<RedmineTimeSpend> timeSpendList) {
    timeSpendList.sort(_compareDateDesc);
    return timeSpendList;
  }

  num getHoursBetweenTwoDateIndices(int firstIndex, int lastIndex){

    num sumOfHoursBetweenFirstAndlastIndex = 0;
    for(int i = firstIndex; i <= lastIndex; i++){
      final RedmineTimeSpend currentTimeSpend = timeSpendList[i];

      final num  spendHours = currentTimeSpend.hours;

      sumOfHoursBetweenFirstAndlastIndex += spendHours;
    }
    return sumOfHoursBetweenFirstAndlastIndex;
  }

  num getHoursBetweenTwoDates(DateTime fistDate, DateTime lastDate){

    final int firstDateIndex = getIndexOfDateOrBetweenTwoDates(fistDate);
    final int lastDateIndex = getIndexOfDateOrBetweenTwoDates(lastDate);

    final num hoursBetweenTheTwoDates =
        getHoursBetweenTwoDateIndices(firstDateIndex, lastDateIndex);

    return hoursBetweenTheTwoDates;
  }

  static DateTime getDateWithoutTime(DateTime dateWithTime){
    DateTime dateWithoutTime =
        new DateTime(dateWithTime.year, dateWithTime.month, dateWithTime.day);
    return dateWithoutTime;
  }

  int getIndexOfDateOrBetweenTwoDates (final DateTime searchedDateTime) {

    DateTime searchedDate = getDateWithoutTime(searchedDateTime);



    final List<RedmineTimeSpend> dateList = timeSpendList;

    final int firstIndex = 0;
    final num lastIndex = dateList.length - 1;

    // find out if it is before all dates
    {
      DateTime firstDateInList = dateList.first.date;

      final bool searchedDateIsBeforeAll =
          searchedDate.isBefore(firstDateInList);

      if(searchedDateIsBeforeAll){
        return firstIndex;
      }
    }

    // find out if it is after all dates
    {
      DateTime lastDateInList = dateList.last.date;

      final bool searchedDateIsAfterAll =
        searchedDate.isAfter(lastDateInList);

      if(searchedDateIsAfterAll){
        return lastIndex;
      }
    }

    // find it between the dates
    int indexBetween = 0;
    for(int iDate = firstIndex; iDate <= lastIndex; iDate++){

      final DateTime currentDate = dateList[iDate].date;

      final bool searchedDateIsCurrent =
          searchedDate.isAtSameMomentAs(currentDate);

      if(searchedDateIsCurrent){
        indexBetween = iDate;
        break;
      }

      final bool searchedDateIsAfterCurrent =
          searchedDate.isAfter(currentDate);

      if(searchedDateIsAfterCurrent){

        final DateTime nextDate = dateList[iDate + 1].date;
        final bool  searchedDateIsBeforeNext =
            searchedDate.isBefore(nextDate);

        if(searchedDateIsBeforeNext){
          indexBetween = iDate;
          break;
        }
      }
    }

    return indexBetween;
  }

  void sortTimeSpendList(){
    timeSpendList.sort(_compareDateDesc);
  }


  static  int _compareDateDesc(RedmineTimeSpend spendTime1, RedmineTimeSpend spendTime2) {
    final DateTime  spendTimeDate1 = spendTime1.date;
    final DateTime  spendTimeDate2 = spendTime2.date;

    final int compareToAsc = spendTimeDate1.compareTo(spendTimeDate2);
    final int compareToDesc = -compareToAsc;

    return compareToAsc;
  }

}