package consortion.view.selfConsortia.consortiaTask
{
   public class ConsortiaTaskInfo
   {
       
      
      public var itemList:Vector.<Object>;
      
      public var exp:int;
      
      public var offer:int;
      
      public var riches:int;
      
      public var buffID:int;
      
      public var beginTime:Date;
      
      public var time:int;
      
      public var contribution:int;
      
      public var level:int;
      
      private var sortKey:Array;
      
      public function ConsortiaTaskInfo()
      {
         sortKey = [3,4,6,1,5,2];
         super();
         itemList = new Vector.<Object>();
      }
      
      public function addItemData(param1:int, param2:String, param3:int = 0, param4:Number = 0, param5:int = 0, param6:int = 0) : void
      {
         var _loc7_:Object = {};
         _loc7_["id"] = param1;
         _loc7_["taskType"] = param3;
         _loc7_["content"] = param2;
         _loc7_["currenValue"] = param4;
         _loc7_["targetValue"] = param5;
         _loc7_["finishValue"] = param6;
         itemList.push(_loc7_);
      }
      
      public function sortItem() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         while(_loc2_ < sortKey.length)
         {
            var _loc5_:int = 0;
            var _loc4_:* = itemList;
            for each(var _loc1_ in itemList)
            {
               if(sortKey[_loc2_] == _loc1_["taskType"])
               {
                  _loc3_.push(_loc1_);
               }
            }
            _loc2_++;
         }
         itemList = _loc3_;
      }
      
      public function updateItemData(param1:int, param2:Number = 0, param3:int = 0) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = itemList;
         for each(var _loc4_ in itemList)
         {
            if(_loc4_["id"] == param1)
            {
               _loc4_["currenValue"] = param2;
               _loc4_["finishValue"] = param3;
            }
         }
      }
   }
}
