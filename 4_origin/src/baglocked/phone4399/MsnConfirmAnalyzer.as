package baglocked.phone4399
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   
   public class MsnConfirmAnalyzer extends DataAnalyzer
   {
       
      
      private var _type:int;
      
      private var _value:Boolean;
      
      private var _alertMessage:String;
      
      private var _count:int;
      
      public function MsnConfirmAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@type != undefined)
         {
            _type = _loc2_.@type;
            _value = _loc2_.@value != "false";
            _alertMessage = _loc2_.@message;
            _count = _loc2_.@count;
            onAnalyzeComplete();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.loader.MsnConfirm4399"));
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get value() : Boolean
      {
         return _value;
      }
      
      public function get alertMessage() : String
      {
         return _alertMessage;
      }
      
      public function get count() : int
      {
         return _count;
      }
   }
}
