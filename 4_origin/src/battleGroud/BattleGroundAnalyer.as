package battleGroud
{
   import battleGroud.data.BatlleData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleGroundAnalyer extends DataAnalyzer
   {
       
      
      public var battleDataList:Array;
      
      public function BattleGroundAnalyer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         battleDataList = [];
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new BatlleData();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               battleDataList.push(_loc2_);
               _loc5_++;
            }
            battleDataList.sortOn("Level",16);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
   }
}
