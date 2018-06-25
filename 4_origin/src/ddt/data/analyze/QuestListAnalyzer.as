package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.quest.QuestInfo;
   import flash.utils.Dictionary;
   
   public class QuestListAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      private var _list:Dictionary;
      
      public function QuestListAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      public function get list() : Dictionary
      {
         return _list;
      }
      
      public function get improveXml() : XML
      {
         var xmllist:XMLList = _xml..Rate;
         return xmllist[0];
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var x:* = null;
         var info:* = null;
         _xml = new XML(data);
         var xmllist:XMLList = _xml..Item;
         _list = new Dictionary();
         for(i = 0; i < xmllist.length(); )
         {
            x = xmllist[i];
            info = QuestInfo.createFromXML(x);
            _list[info.Id] = info;
            i++;
         }
         onAnalyzeComplete();
      }
   }
}
