package mainbutton.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import mainbutton.MainButton;
   
   public class HallIconDataAnalyz extends DataAnalyzer
   {
       
      
      public var _HallIconList:Dictionary;
      
      public function HallIconDataAnalyz(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _HallIconList = new Dictionary();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new MainButton();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _HallIconList[_loc4_.ID] = _loc4_;
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
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
