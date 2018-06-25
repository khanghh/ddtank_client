package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletActivateGradeVo;
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class EquipAmuletActivateGradeDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function EquipAmuletActivateGradeDataAnalyzer(onCompleteCall:Function)
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
               tmpVo = new EquipAmuletActivateGradeVo();
               tmpVo.wahsGrade = xmllist[i].@WahsLevel;
               tmpVo.WahsTimes = xmllist[i].@WahsTimes;
               tmpVo.minValue = xmllist[i].@Minvalue;
               tmpVo.maxValue = xmllist[i].@Maxvalue;
               _data.add(tmpVo.wahsGrade,tmpVo);
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
