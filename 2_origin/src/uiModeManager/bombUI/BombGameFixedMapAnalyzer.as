package uiModeManager.bombUI
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import road7th.data.DictionaryData;
   import uiModeManager.bombUI.model.bomb.FixedMapData;
   
   public class BombGameFixedMapAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function BombGameFixedMapAnalyzer(onCompleteCall:Function)
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
               map = new FixedMapData();
               ObjectUtils.copyPorpertiesByXML(map,xmllist[i]);
               _data.add(map.Level,map);
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
