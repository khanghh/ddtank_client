package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class StrengthenDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _strengthData:Vector.<Dictionary>;
      
      private var _xml:XML;
      
      public function StrengthenDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var TemplateID:int = 0;
         var StrengthenLevel:int = 0;
         var Data:int = 0;
         _xml = new XML(data);
         initData();
         var xmllist:XMLList = _xml.Item;
         if(_xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               TemplateID = xmllist[i].@TemplateID;
               StrengthenLevel = xmllist[i].@StrengthenLevel;
               Data = xmllist[i].@Data;
               _strengthData[StrengthenLevel][TemplateID] = Data;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var d:* = null;
         _strengthData = new Vector.<Dictionary>();
         for(i = 0; i <= 12; )
         {
            d = new Dictionary();
            _strengthData.push(d);
            i++;
         }
      }
   }
}
