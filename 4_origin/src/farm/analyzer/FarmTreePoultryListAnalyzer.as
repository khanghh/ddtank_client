package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmModelController;
   import farm.modelx.FarmPoultryInfo;
   import flash.utils.Dictionary;
   
   public class FarmTreePoultryListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function FarmTreePoultryListAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var tmpFoodID:int = 0;
         var foodList:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml..item;
         FarmModelController.MAXLEVEL = items.length() - 1;
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for each(var item in items)
         {
            foodList = new FarmPoultryInfo();
            ObjectUtils.copyPorpertiesByXML(foodList,item);
            tmpFoodID = item.@Level;
            list[tmpFoodID] = foodList;
         }
         onAnalyzeComplete();
      }
   }
}
