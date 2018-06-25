package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.RegisterDropInfo;
   
   public class GetRegisterDropListAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<RegisterDropInfo>;
      
      public function GetRegisterDropListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            list = new Vector.<RegisterDropInfo>();
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new RegisterDropInfo();
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
   }
}
