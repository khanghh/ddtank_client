package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.SuitTemplateInfo;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class SuitTempleteAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Dictionary;
      
      public function SuitTempleteAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var ecInfo:* = null;
         var i:int = 0;
         var info:* = null;
         _list = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..item;
            ecInfo = describeType(new SuitTemplateInfo());
            for(i = 0; i < xmllist.length(); )
            {
               info = new SuitTemplateInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list[info.SuitId] = info;
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
      
      public function get list() : Dictionary
      {
         return _list;
      }
   }
}
