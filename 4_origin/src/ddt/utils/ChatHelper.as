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
      
      chat_system static function readGoodsLinks(byte:ByteArray, isReadKey:Boolean = false) : Array
      {
         var i:int = 0;
         var obj:* = null;
         var re_arr:Array = [];
         var count:uint = byte.readUnsignedByte();
         for(i = 0; i < count; )
         {
            obj = {};
            obj.index = byte.readInt();
            obj.TemplateID = byte.readInt();
            obj.ItemID = byte.readInt();
            if(isReadKey)
            {
               obj.key = byte.readUTF();
            }
            re_arr.push(obj);
            i++;
         }
         return re_arr;
      }
   }
}
