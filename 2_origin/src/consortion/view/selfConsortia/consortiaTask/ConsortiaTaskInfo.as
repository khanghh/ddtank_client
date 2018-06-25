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
      
      public function addItemData(id:int, content:String, taskType:int = 0, currenValue:Number = 0, targetValue:int = 0, finishValue:int = 0) : void
      {
         var obj:Object = {};
         obj["id"] = id;
         obj["taskType"] = taskType;
         obj["content"] = content;
         obj["currenValue"] = currenValue;
         obj["targetValue"] = targetValue;
         obj["finishValue"] = finishValue;
         itemList.push(obj);
      }
      
      public function sortItem() : void
      {
         var i:int = 0;
         var tempList:Vector.<Object> = new Vector.<Object>();
         for(; i < sortKey.length; i++)
         {
            var _loc5_:int = 0;
            var _loc4_:* = itemList;
            for each(var obj in itemList)
            {
               if(sortKey[i] == obj["taskType"])
               {
                  tempList.push(obj);
               }
            }
         }
         itemList = tempList;
      }
      
      public function updateItemData(id:int, currenValue:Number = 0, finishValue:int = 0) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = itemList;
         for each(var obj in itemList)
         {
            if(obj["id"] == id)
            {
               obj["currenValue"] = currenValue;
               obj["finishValue"] = finishValue;
            }
         }
      }
   }
}
