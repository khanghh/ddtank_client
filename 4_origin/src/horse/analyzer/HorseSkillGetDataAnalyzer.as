package horse.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import horse.data.HorseSkillGetVo;
   import road7th.data.DictionaryData;
   
   public class HorseSkillGetDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _horseSkillGetList:DictionaryData;
      
      private var _horseSkillGetIdList:DictionaryData;
      
      public function HorseSkillGetDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var type:int = 0;
         var tmpVo:* = null;
         var xml:XML = new XML(data);
         _horseSkillGetList = new DictionaryData();
         _horseSkillGetIdList = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               type = xmllist[i].@Type;
               if(!_horseSkillGetList[type])
               {
                  _horseSkillGetList.add(type,new Vector.<HorseSkillGetVo>());
               }
               tmpVo = new HorseSkillGetVo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               _horseSkillGetList[type].push(tmpVo);
               _horseSkillGetIdList.add(tmpVo.SkillID,tmpVo);
               i++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _horseSkillGetList;
            for each(var tmp in _horseSkillGetList)
            {
               tmp.sort(compareFunc);
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
      
      private function compareFunc(tmpA:HorseSkillGetVo, tmpB:HorseSkillGetVo) : int
      {
         if(tmpA.Level > tmpB.Level)
         {
            return 1;
         }
         if(tmpA.Level < tmpB.Level)
         {
            return -1;
         }
         return 0;
      }
      
      public function get horseSkillGetList() : DictionaryData
      {
         return _horseSkillGetList;
      }
      
      public function get horseSkillGetIdList() : DictionaryData
      {
         return _horseSkillGetIdList;
      }
   }
}
