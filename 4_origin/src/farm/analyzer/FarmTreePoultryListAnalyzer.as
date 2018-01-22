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
      
      public function FarmTreePoultryListAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc6_:XML = XML(param1);
         var _loc4_:XMLList = _loc6_..item;
         FarmModelController.MAXLEVEL = _loc4_.length() - 1;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc2_ = new FarmPoultryInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_);
            _loc3_ = _loc5_.@Level;
            list[_loc3_] = _loc2_;
         }
         onAnalyzeComplete();
      }
   }
}
