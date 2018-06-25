package questionAward.data
{
   public class QuestionAwardInfo
   {
       
      
      private var _title:String;
      
      private var _dataBaseList:Vector.<QuestionDataBaseInfo>;
      
      private var _minLv:int;
      
      private var _beginTime:Date;
      
      private var _endTime:Date;
      
      public function QuestionAwardInfo()
      {
         super();
      }
      
      public function get endTime() : Date
      {
         return _endTime;
      }
      
      public function set endTime(value:Date) : void
      {
         _endTime = value;
      }
      
      public function get beginTime() : Date
      {
         return _beginTime;
      }
      
      public function set beginTime(value:Date) : void
      {
         _beginTime = value;
      }
      
      public function get minLv() : int
      {
         return _minLv;
      }
      
      public function set minLv(value:int) : void
      {
         _minLv = value;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(value:String) : void
      {
         _title = value;
      }
      
      public function addDataBaseInfo(data:String) : void
      {
         var dataBaseInfo:* = null;
         var i:int = 0;
         var infoArr:* = null;
         var temIndex:int = 0;
         _dataBaseList = new Vector.<QuestionDataBaseInfo>();
         var dataArr:Array = data.split("|");
         if(dataArr == null || dataArr.length <= 0)
         {
            return;
         }
         var temID:int = 1;
         for(i = 0; i < dataArr.length; )
         {
            infoArr = String(dataArr[i]).split("$");
            if(!(infoArr == null || infoArr.length <= 0))
            {
               dataBaseInfo = new QuestionDataBaseInfo();
               dataBaseInfo.qid = temID;
               dataBaseInfo.title = infoArr[0];
               dataBaseInfo.type = infoArr[1];
               if(dataBaseInfo.type == 1)
               {
                  dataBaseInfo.isMultiSelect = int(infoArr[2]);
                  temIndex = 3;
                  temIndex;
                  while(temIndex < infoArr.length)
                  {
                     dataBaseInfo.addContent(infoArr[temIndex]);
                     temIndex++;
                  }
               }
               _dataBaseList.push(dataBaseInfo);
               temID++;
            }
            i++;
         }
      }
      
      public function createQuestionIterator() : QuestionIterator
      {
         return new QuestionAwardIterator(_dataBaseList);
      }
   }
}
