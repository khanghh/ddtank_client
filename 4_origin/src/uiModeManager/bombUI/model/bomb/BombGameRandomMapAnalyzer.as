package uiModeManager.bombUI.model.bomb
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   
   public class BombGameRandomMapAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function BombGameRandomMapAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var map:* = null;
         var xmllist:* = null;
         var i:int = 0;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            _data = new DictionaryData();
            xmllist = xml..item;
            for(i = 0; i < xmllist.length(); )
            {
               map = new RandomMapData();
               ObjectUtils.copyPorpertiesByXML(map,xmllist[i]);
               _data.add(map.LevelMin,map);
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
      
      public function get data() : DictionaryData
      {
         return _data;
      }
   }
}
