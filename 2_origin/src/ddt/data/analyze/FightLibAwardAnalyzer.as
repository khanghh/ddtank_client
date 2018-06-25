package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.fightLib.FightLibAwardInfo;
   
   public class FightLibAwardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function FightLibAwardAnalyzer(onCompleteCall:Function)
      {
         list = [];
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var awardItem:* = null;
         var tempList:Array = [];
         var infos:XMLList = XML(data).Item;
         var _loc7_:int = 0;
         var _loc6_:* = infos;
         for each(var awardInfo in infos)
         {
            awardItem = {};
            awardItem.id = int(awardInfo.@ID);
            awardItem.diff = int(awardInfo.@Easy);
            awardItem.itemID = int(awardInfo.@AwardItem);
            awardItem.count = int(awardInfo.@Count);
            tempList.push(awardItem);
         }
         sortItems(tempList);
         onAnalyzeComplete();
      }
      
      private function sortItems(items:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = items;
         for each(var item in items)
         {
            pushInListByIDAndDiff({
               "id":item.itemID,
               "count":item.count
            },item.id,item.diff);
         }
      }
      
      private function pushInListByIDAndDiff(item:Object, id:int, diff:int) : void
      {
         var awardInfo:FightLibAwardInfo = findAwardInfoByID(id);
         switch(int(diff))
         {
            case 0:
               awardInfo.easyAward.push(item);
               break;
            case 1:
               awardInfo.normalAward.push(item);
               break;
            case 2:
               awardInfo.difficultAward.push(item);
         }
      }
      
      private function findAwardInfoByID(id:int) : FightLibAwardInfo
      {
         var result:* = null;
         var i:int = 0;
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            if(list[i].id == id)
            {
               result = list[i];
               return result;
            }
            i++;
         }
         if(result == null)
         {
            result = new FightLibAwardInfo();
            result.id = id;
            list.push(result);
         }
         return result;
      }
   }
}
