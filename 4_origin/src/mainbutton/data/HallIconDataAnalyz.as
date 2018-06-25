package mainbutton.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import mainbutton.MainButton;
   
   public class HallIconDataAnalyz extends DataAnalyzer
   {
       
      
      public var _HallIconList:Dictionary;
      
      public function HallIconDataAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _HallIconList = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new MainButton();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _HallIconList[info.ID] = info;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get list() : Dictionary
      {
         return _HallIconList;
      }
   }
}
