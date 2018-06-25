package newTitle.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import newTitle.model.NewTitleModel;
   
   public class NewTitleDataAnalyz extends DataAnalyzer
   {
       
      
      public var _newTitleList:Dictionary;
      
      public function NewTitleDataAnalyz(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var info:* = null;
         _newTitleList = new Dictionary();
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new NewTitleModel();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _newTitleList[info.id] = info;
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
         return _newTitleList;
      }
   }
}
