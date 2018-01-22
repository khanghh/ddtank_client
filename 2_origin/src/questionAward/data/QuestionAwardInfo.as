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
      
      public function set endTime(param1:Date) : void
      {
         _endTime = param1;
      }
      
      public function get beginTime() : Date
      {
         return _beginTime;
      }
      
      public function set beginTime(param1:Date) : void
      {
         _beginTime = param1;
      }
      
      public function get minLv() : int
      {
         return _minLv;
      }
      
      public function set minLv(param1:int) : void
      {
         _minLv = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function addDataBaseInfo(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         _dataBaseList = new Vector.<QuestionDataBaseInfo>();
         var _loc3_:Array = param1.split("|");
         if(_loc3_ == null || _loc3_.length <= 0)
         {
            return;
         }
         var _loc5_:int = 1;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc4_ = String(_loc3_[_loc7_]).split("$");
            if(!(_loc4_ == null || _loc4_.length <= 0))
            {
               _loc2_ = new QuestionDataBaseInfo();
               _loc2_.qid = _loc5_;
               _loc2_.title = _loc4_[0];
               _loc2_.type = _loc4_[1];
               if(_loc2_.type == 1)
               {
                  _loc2_.isMultiSelect = int(_loc4_[2]);
                  _loc6_ = 3;
                  _loc6_;
                  while(_loc6_ < _loc4_.length)
                  {
                     _loc2_.addContent(_loc4_[_loc6_]);
                     _loc6_++;
                  }
               }
               _dataBaseList.push(_loc2_);
               _loc5_++;
            }
            _loc7_++;
         }
      }
      
      public function createQuestionIterator() : QuestionIterator
      {
         return new QuestionAwardIterator(_dataBaseList);
      }
   }
}
