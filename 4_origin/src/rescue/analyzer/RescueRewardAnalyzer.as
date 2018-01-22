package rescue.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import rescue.data.RescueRewardInfo;
   
   public class RescueRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function RescueRewardAnalyzer(param1:Function)
      {
         list = [];
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc5_:XML = XML(param1);
         var _loc3_:XMLList = _loc5_.Item;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new RescueRewardInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_);
            list.push(_loc2_);
         }
         onAnalyzeComplete();
      }
   }
}
