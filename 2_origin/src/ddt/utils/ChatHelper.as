package ddt.utils
{
   import ddt.view.chat.chat_system;
   import flash.utils.ByteArray;
   
   public class ChatHelper
   {
       
      
      public function ChatHelper()
      {
         super();
      }
      
      chat_system static function readGoodsLinks(param1:ByteArray, param2:Boolean = false) : Array
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Array = [];
         var _loc4_:uint = param1.readUnsignedByte();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = {};
            _loc5_.index = param1.readInt();
            _loc5_.TemplateID = param1.readInt();
            _loc5_.ItemID = param1.readInt();
            if(param2)
            {
               _loc5_.key = param1.readUTF();
            }
            _loc3_.push(_loc5_);
            _loc6_++;
         }
         return _loc3_;
      }
   }
}
