package gemstone.info
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class GemstoneAnalyze extends DataAnalyzer
   {
       
      
      public var gInfoList:Vector.<GemstoneStaticInfo>;
      
      public function GemstoneAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         gInfoList = new Vector.<GemstoneStaticInfo>();
         var _loc2_:XML = new XML(param1);
         var _loc3_:int = _loc2_.item.length();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new GemstoneStaticInfo();
            _loc4_.fightSpiritIcon = _loc2_.item.@FightSpiritID;
            _loc4_.fightSpiritIcon = _loc2_.item.@FightSpiritIcon;
            _loc4_.agility = _loc2_.item.@agility;
            _loc4_.level = _loc2_.item.@level;
            _loc4_.luck = _loc2_.item.@luck;
            _loc4_.Exp = _loc2_.item.@Exp;
            _loc4_.attack = _loc2_.item.@attack;
            _loc4_.defence = _loc2_.item.@defence;
            gInfoList.push(_loc4_);
            _loc5_++;
         }
      }
   }
}
