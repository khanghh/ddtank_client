package ddt.data.analyze
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class ActiveEventsAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      private var _xml:XML;
      
      public function ActiveEventsAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var info:* = null;
         _xml = new XML(data);
         _list = [];
         var xmllist:XMLList = _xml..Item;
         if(_xml.@value == "true")
         {
            for(i = 0; i < xmllist.length(); )
            {
               info = new ActiveEventsInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list.push(info);
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
      
      public function get list() : Array
      {
         return _list.slice(0);
      }
   }
}
