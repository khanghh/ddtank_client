package cardSystem.analyze
{
   import cardSystem.data.SetsUpgradeRuleInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class UpgradeRuleAnalyzer extends DataAnalyzer
   {
       
      
      public var upgradeRuleVec:Vector.<SetsUpgradeRuleInfo>;
      
      public function UpgradeRuleAnalyzer(param1:Function)
      {
         super(param1);
         upgradeRuleVec = new Vector.<SetsUpgradeRuleInfo>();
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc4_ = _loc2_..Item;
            _loc3_ = _loc4_.length();
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc5_ = new SetsUpgradeRuleInfo();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               upgradeRuleVec.push(_loc5_);
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
