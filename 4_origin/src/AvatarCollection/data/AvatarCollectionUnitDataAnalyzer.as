package AvatarCollection.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class AvatarCollectionUnitDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _maleUnitDic:DictionaryData;
      
      private var _femaleUnitDic:DictionaryData;
      
      private var _weaponUnitDic:DictionaryData;
      
      public function AvatarCollectionUnitDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         var xml:XML = new XML(data);
         _maleUnitDic = new DictionaryData();
         _femaleUnitDic = new DictionaryData();
         _weaponUnitDic = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new AvatarCollectionUnitVo();
               tmpVo.id = xmllist[i].@ID;
               tmpVo.sex = xmllist[i].@Sex;
               tmpVo.name = xmllist[i].@Name;
               tmpVo.Attack = xmllist[i].@Attack;
               tmpVo.Defence = xmllist[i].@Defend;
               tmpVo.Agility = xmllist[i].@Agility;
               tmpVo.Luck = xmllist[i].@Luck;
               tmpVo.Damage = xmllist[i].@Damage;
               tmpVo.Guard = xmllist[i].@Guard;
               tmpVo.Blood = xmllist[i].@Blood;
               tmpVo.needHonor = xmllist[i].@Cost;
               tmpVo.Type = xmllist[i].@Type;
               if(tmpVo.Type == 1)
               {
                  if(tmpVo.sex == 1)
                  {
                     _maleUnitDic.add(tmpVo.id,tmpVo);
                  }
                  else
                  {
                     _femaleUnitDic.add(tmpVo.id,tmpVo);
                  }
               }
               else if(tmpVo.Type == 2)
               {
                  _weaponUnitDic.add(tmpVo.id,tmpVo);
               }
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      public function get maleUnitDic() : DictionaryData
      {
         return _maleUnitDic;
      }
      
      public function get femaleUnitDic() : DictionaryData
      {
         return _femaleUnitDic;
      }
      
      public function get weaponUnitDic() : DictionaryData
      {
         return _weaponUnitDic;
      }
   }
}
