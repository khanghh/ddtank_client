package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import flash.utils.Dictionary;
   
   public class FriendsMountTypeAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function FriendsMountTypeAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            list = new Dictionary();
            _loc5_ = _loc3_.Item.length();
            _loc4_ = _loc3_.Item;
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for each(var _loc2_ in _loc4_)
            {
               list[_loc2_.@UserID.toString()] = Math.max(1,int(_loc2_.@CurrentID));
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
