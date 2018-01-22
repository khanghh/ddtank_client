package cardCollectAward.data
{
   import road7th.data.DictionaryData;
   
   public class CardCollectAwardInfo
   {
       
      
      private var _title:String;
      
      private var _desc:String;
      
      private var _minLv:int;
      
      private var _quertions:String;
      
      private var _beginTime:Date;
      
      private var _endTime:Date;
      
      private var _qq:String;
      
      private var _phone:String;
      
      private var _awardData:DictionaryData;
      
      public function CardCollectAwardInfo()
      {
         super();
         _awardData = new DictionaryData();
      }
      
      public function get awardData() : DictionaryData
      {
         return _awardData;
      }
      
      public function get phone() : String
      {
         return _phone;
      }
      
      public function set phone(param1:String) : void
      {
         _phone = param1;
      }
      
      public function get qq() : String
      {
         return _qq;
      }
      
      public function set qq(param1:String) : void
      {
         _qq = param1;
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
      
      public function get quertions() : String
      {
         return _quertions;
      }
      
      public function set quertions(param1:String) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         _quertions = param1;
         if(_quertions != null)
         {
            _loc6_ = _quertions.split("|");
            _loc2_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc2_ = (_loc6_[_loc7_] as String).split(",");
               if(_awardData != null && _loc2_[0] != null)
               {
                  _loc4_ = new AwardItem();
                  _loc4_.title = _loc2_[0];
                  if(_loc2_[1] != null)
                  {
                     _loc3_ = (_loc2_[1] as String).split(";");
                     while(_loc3_ != null && _loc3_.length > 0)
                     {
                        _loc5_ = new ItemInfo();
                        _loc5_.name = String(_loc3_.shift());
                        _loc4_.addItem(_loc5_);
                     }
                  }
                  _awardData[_loc7_] = _loc4_;
               }
               _loc7_++;
            }
         }
      }
      
      public function getQuertionByIndex(param1:int) : AwardItem
      {
         if(_awardData != null && _awardData.hasKey(param1))
         {
            return _awardData[param1];
         }
         return null;
      }
      
      public function get minLv() : int
      {
         return _minLv;
      }
      
      public function set minLv(param1:int) : void
      {
         _minLv = param1;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function set desc(param1:String) : void
      {
         _desc = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
   }
}
