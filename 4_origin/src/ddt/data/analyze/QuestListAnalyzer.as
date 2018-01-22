package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.quest.QuestInfo;
   import flash.utils.Dictionary;
   
   public class QuestListAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      private var _list:Dictionary;
      
      public function QuestListAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      public function get list() : Dictionary
      {
         return _list;
      }
      
      public function get improveXml() : XML
      {
         var _loc1_:XMLList = _xml..Rate;
         return _loc1_[0];
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         _xml = new XML(param1);
         var _loc2_:XMLList = _xml..Item;
         _list = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length())
         {
            _loc4_ = _loc2_[_loc5_];
            _loc3_ = QuestInfo.createFromXML(_loc4_);
            _list[_loc3_.Id] = _loc3_;
            _loc5_++;
         }
         onAnalyzeComplete();
      }
   }
}
