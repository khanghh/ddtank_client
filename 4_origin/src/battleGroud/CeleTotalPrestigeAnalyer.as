package battleGroud
{
   import battleGroud.data.BattlPrestigeData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CeleTotalPrestigeAnalyer extends DataAnalyzer
   {
       
      
      public var battleDataList:Vector.<BattlPrestigeData>;
      
      public function CeleTotalPrestigeAnalyer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         battleDataList = new Vector.<BattlPrestigeData>();
         var _loc2_:XML = new XML(param1);
         var _loc4_:int = _loc2_.item.length();
         var _loc3_:XMLList = _loc2_..Item;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length())
         {
            _loc5_ = new BattlPrestigeData();
            _loc5_.Numbers = _loc6_ + 1;
            ObjectUtils.copyPorpertiesByXML(_loc5_,_loc3_[_loc6_]);
            battleDataList.push(_loc5_);
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
