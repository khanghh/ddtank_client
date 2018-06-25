package mines.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class MinesLevelAnalyzer extends DataAnalyzer
   {
       
      
      public var toolList:Vector.<ToolLevelInfo>;
      
      public var equipList:Vector.<EquipmentInfo>;
      
      public function MinesLevelAnalyzer(onCompleteCall:Function)
      {
         toolList = new Vector.<ToolLevelInfo>();
         equipList = new Vector.<EquipmentInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var info:* = null;
         var info1:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            var _loc8_:int = 0;
            var _loc7_:* = xmllist;
            for each(var item in xmllist)
            {
               info = new ToolLevelInfo();
               info1 = new EquipmentInfo();
               if(item.@LevelCount == 1 || item.@PickAxeExp != 0)
               {
                  info.level = item.@LevelCount;
                  info.exp = item.@PickAxeExp;
                  toolList.push(info);
               }
               if(item.@LevelCount == 1 || item.@HeadExp != 0)
               {
                  info1.level = item.@LevelCount;
                  info1.headExp = item.@HeadExp;
                  info1.clothExp = item.@ClothExp;
                  info1.swordExp = item.@SwordExp;
                  info1.shieldExp = item.@ShieldExp;
                  info1.attack = item.@Attack;
                  info1.defence = item.@Defence;
                  info1.agility = item.@Agility;
                  info1.lucky = item.@Lucky;
                  equipList.push(info1);
               }
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
