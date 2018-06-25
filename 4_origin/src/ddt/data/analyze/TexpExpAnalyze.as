package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import texpSystem.data.TexpExp;
   
   public class TexpExpAnalyze extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function TexpExpAnalyze(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmlList:* = null;
         var i:int = 0;
         var texpExp:* = null;
         var lv:int = 0;
         list = new Dictionary();
         var xml:XML = new XML(data);
         message = xml.@message;
         if(xml.@value == "true")
         {
            xmlList = xml..Item;
            for(i = 0; i < xmlList.length(); )
            {
               texpExp = new TexpExp();
               ObjectUtils.copyPorpertiesByXML(texpExp,xmlList[i]);
               lv = xmlList[i].@Grage;
               list[lv] = texpExp;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
         }
      }
   }
}
