package godCardRaise.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardListAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Dictionary;
      
      public function GodCardListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var list:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _list = new Dictionary();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new GodCardListInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list[info.ID] = info;
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
      
      public function get list() : Dictionary
      {
         return _list;
      }
   }
}
