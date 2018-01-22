package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   import trainer.data.LevelRewardInfo;
   
   public class LevelRewardAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function LevelRewardAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc6_:XML = XML(param1);
         var _loc5_:XMLList = _loc6_.reward;
         var _loc13_:int = 0;
         var _loc12_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc3_ = _loc4_.@level;
            _loc9_ = new Dictionary();
            _loc8_ = _loc4_.rewardItem;
            var _loc11_:int = 0;
            var _loc10_:* = _loc8_;
            for each(var _loc7_ in _loc8_)
            {
               _loc2_ = new LevelRewardInfo();
               _loc2_.sort = int(_loc7_.@sort);
               _loc2_.title = String(_loc7_.@title);
               _loc2_.content = String(_loc7_.@content);
               _loc2_.girlItems = String(_loc7_.@items).split("|")[0].split(",");
               _loc2_.boyItems = String(_loc7_.@items).split("|")[1].split(",");
               _loc9_[_loc2_.sort] = _loc2_;
            }
            list[_loc3_] = _loc9_;
         }
         onAnalyzeComplete();
      }
   }
}
