package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.fightLib.FightLibAwardInfo;
   
   public class FightLibAwardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function FightLibAwardAnalyzer(param1:Function)
      {
         list = [];
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:Array = [];
         var _loc2_:XMLList = XML(param1).Item;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc4_ = {};
            _loc4_.id = int(_loc3_.@ID);
            _loc4_.diff = int(_loc3_.@Easy);
            _loc4_.itemID = int(_loc3_.@AwardItem);
            _loc4_.count = int(_loc3_.@Count);
            _loc5_.push(_loc4_);
         }
         sortItems(_loc5_);
         onAnalyzeComplete();
      }
      
      private function sortItems(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            pushInListByIDAndDiff({
               "id":_loc2_.itemID,
               "count":_loc2_.count
            },_loc2_.id,_loc2_.diff);
         }
      }
      
      private function pushInListByIDAndDiff(param1:Object, param2:int, param3:int) : void
      {
         var _loc4_:FightLibAwardInfo = findAwardInfoByID(param2);
         switch(int(param3))
         {
            case 0:
               _loc4_.easyAward.push(param1);
               break;
            case 1:
               _loc4_.normalAward.push(param1);
               break;
            case 2:
               _loc4_.difficultAward.push(param1);
         }
      }
      
      private function findAwardInfoByID(param1:int) : FightLibAwardInfo
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(list[_loc4_].id == param1)
            {
               _loc2_ = list[_loc4_];
               return _loc2_;
            }
            _loc4_++;
         }
         if(_loc2_ == null)
         {
            _loc2_ = new FightLibAwardInfo();
            _loc2_.id = param1;
            list.push(_loc2_);
         }
         return _loc2_;
      }
   }
}
