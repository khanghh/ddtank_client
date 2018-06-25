package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillList:DictionaryData;
      
      public function HorseSkillDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         var xml:XML = new XML(data);
         _horseSkillList = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new HorseSkillVo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               _horseSkillList.add(tmpVo.ID,tmpVo);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get horseSkillList() : DictionaryData
      {
         return _horseSkillList;
      }
   }
}
