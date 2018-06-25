package guardCore.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<GuardCoreInfo>;
      
      public function GuardCoreAnalyzer(onCompleteCall:Function)
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
         _list = new Vector.<GuardCoreInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new GuardCoreInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list.push(info);
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
      
      public function get list() : Vector.<GuardCoreInfo>
      {
         return _list;
      }
   }
}
