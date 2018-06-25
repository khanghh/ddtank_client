package farm.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.utils.Dictionary;
   
   public class FoodComposeListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      private var _listDetail:Vector.<FoodComposeListTemplateInfo>;
      
      public function FoodComposeListAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var tmpFoodID:int = 0;
         var foodList:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml..Item;
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for each(var item in items)
         {
            foodList = new FoodComposeListTemplateInfo();
            ObjectUtils.copyPorpertiesByXML(foodList,item);
            if(tmpFoodID != foodList.FoodID)
            {
               tmpFoodID = foodList.FoodID;
               _listDetail = new Vector.<FoodComposeListTemplateInfo>();
               _listDetail.push(foodList);
            }
            else if(tmpFoodID == foodList.FoodID)
            {
               _listDetail.push(foodList);
            }
            list[tmpFoodID] = _listDetail;
         }
         onAnalyzeComplete();
      }
   }
}
