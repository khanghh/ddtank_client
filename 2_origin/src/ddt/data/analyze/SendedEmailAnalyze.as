package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfoOfSended;
   import flash.utils.describeType;
   
   public class SendedEmailAnalyze extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function SendedEmailAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var ecInfo:* = null;
         var i:int = 0;
         var info:* = null;
         _list = [];
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml.Item;
            ecInfo = describeType(new EmailInfoOfSended());
            for(i = 0; i < xmllist.length(); )
            {
               info = new EmailInfoOfSended();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               list.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get list() : Array
      {
         return _list;
      }
   }
}
