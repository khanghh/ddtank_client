package explorerManual.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.data.model.ManualDebrisInfo;
   import road7th.data.DictionaryData;
   
   public class ManualDebrisAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:DictionaryData;
      
      public function ManualDebrisAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : DictionaryData{return null;}
   }
}
