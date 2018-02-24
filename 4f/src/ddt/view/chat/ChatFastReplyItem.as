package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatFastReplyItem extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _contentTxt:TextField;
      
      private var _itemText:String;
      
      private var _isCustom:Boolean;
      
      private var _deleteBtn:SimpleBitmapButton;
      
      public function ChatFastReplyItem(param1:String, param2:Boolean = false){super();}
      
      public function dispose() : void{}
      
      public function get word() : String{return null;}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function init() : void{}
      
      public function get deleteBtn() : SimpleBitmapButton{return null;}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __delete(param1:MouseEvent) : void{}
   }
}
