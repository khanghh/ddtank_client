package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillElementVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillElementDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillElementList:DictionaryData;
      
      public function HorseSkillElementDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         var xml:XML = new XML(data);
         _horseSkillElementList = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new HorseSkillElementVo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               _horseSkillElementList.add(tmpVo.ID,tmpVo);
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
      
      public function get horseSkillElementList() : DictionaryData
      {
         return _horseSkillElementList;
      }
   }
}
