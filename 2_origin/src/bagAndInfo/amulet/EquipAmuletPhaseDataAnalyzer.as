package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class EquipAmuletPhaseDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function EquipAmuletPhaseDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         _data = new DictionaryData();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new EquipAmuletPhaseVo();
               ObjectUtils.copyPorpertiesByXML(tmpVo,xmllist[i]);
               tmpVo.grade = xmllist[i].@AmuletLevel;
               _data.add(tmpVo.Phase,tmpVo);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
         _data = null;
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
