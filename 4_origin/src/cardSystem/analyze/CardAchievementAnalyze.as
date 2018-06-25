package cardSystem.analyze
{
   import cardSystem.data.CardAchievementInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class CardAchievementAnalyze extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function CardAchievementAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
         _data = new DictionaryData();
      }
      
      override public function analyze(data:*) : void
      {
         var xmlList:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmlList = xml..Item;
            for(i = 0; i < xmlList.length(); )
            {
               info = new CardAchievementInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmlList[i]);
               info.attack = xmlList[i].@AddAttack;
               info.MaxHp = xmlList[i].@AddBlood;
               info.damage = xmlList[i].@AddDamage;
               info.defence = xmlList[i].@AddDefend;
               info.recovery = xmlList[i].@AddGuard;
               info.luck = xmlList[i].@AddLucky;
               info.magicAttack = xmlList[i].@AddMagicAttack;
               info.magicDefend = xmlList[i].@AddMagicDefend;
               _data.add(info.AchievementID,info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
