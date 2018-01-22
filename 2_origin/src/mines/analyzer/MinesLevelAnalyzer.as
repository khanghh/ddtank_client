package mines.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class MinesLevelAnalyzer extends DataAnalyzer
   {
       
      
      public var toolList:Vector.<ToolLevelInfo>;
      
      public var equipList:Vector.<EquipmentInfo>;
      
      public function MinesLevelAnalyzer(param1:Function)
      {
         toolList = new Vector.<ToolLevelInfo>();
         equipList = new Vector.<EquipmentInfo>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:XML = new XML(param1);
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            var _loc8_:int = 0;
            var _loc7_:* = _loc5_;
            for each(var _loc2_ in _loc5_)
            {
               _loc6_ = new ToolLevelInfo();
               _loc3_ = new EquipmentInfo();
               if(_loc2_.@LevelCount == 1 || _loc2_.@PickAxeExp != 0)
               {
                  _loc6_.level = _loc2_.@LevelCount;
                  _loc6_.exp = _loc2_.@PickAxeExp;
                  toolList.push(_loc6_);
               }
               if(_loc2_.@LevelCount == 1 || _loc2_.@HeadExp != 0)
               {
                  _loc3_.level = _loc2_.@LevelCount;
                  _loc3_.headExp = _loc2_.@HeadExp;
                  _loc3_.clothExp = _loc2_.@ClothExp;
                  _loc3_.swordExp = _loc2_.@SwordExp;
                  _loc3_.shieldExp = _loc2_.@ShieldExp;
                  _loc3_.attack = _loc2_.@Attack;
                  _loc3_.defence = _loc2_.@Defence;
                  _loc3_.agility = _loc2_.@Agility;
                  _loc3_.lucky = _loc2_.@Lucky;
                  equipList.push(_loc3_);
               }
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
         }
      }
   }
}
