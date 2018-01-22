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
      
      public function FoodComposeListAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc6_:XML = XML(param1);
         var _loc4_:XMLList = _loc6_..Item;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc2_ = new FoodComposeListTemplateInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_);
            if(_loc3_ != _loc2_.FoodID)
            {
               _loc3_ = _loc2_.FoodID;
               _listDetail = new Vector.<FoodComposeListTemplateInfo>();
               _listDetail.push(_loc2_);
            }
            else if(_loc3_ == _loc2_.FoodID)
            {
               _listDetail.push(_loc2_);
            }
            list[_loc3_] = _listDetail;
         }
         onAnalyzeComplete();
      }
   }
}
