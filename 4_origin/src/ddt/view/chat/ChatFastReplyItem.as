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
      
      public function ChatFastReplyItem(param1:String, param2:Boolean = false)
      {
         super();
         _itemText = param1;
         _isCustom = param2;
         init();
         initEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _bg = null;
         _contentTxt = null;
         _deleteBtn.dispose();
         _deleteBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get word() : String
      {
         return _itemText;
      }
      
      private function __mouseOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _deleteBtn.alpha = _loc2_;
         _bg.alpha = _loc2_;
      }
      
      private function __mouseOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 1;
         _deleteBtn.alpha = _loc2_;
         _bg.alpha = _loc2_;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.chat.FastReplyItemBg");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("chat.FastReplyDeleteBtn");
         var _loc2_:int = 0;
         _deleteBtn.alpha = _loc2_;
         _bg.alpha = _loc2_;
         _contentTxt = new TextField();
         _contentTxt.text = String(_itemText);
         _contentTxt.height = _bg.height;
         _contentTxt.width = _bg.width;
         _contentTxt.mouseEnabled = false;
         var _loc1_:TextFormat = new TextFormat("Arial",12,16777215);
         _contentTxt.setTextFormat(_loc1_);
         addChild(_bg);
         addChild(_contentTxt);
         if(_isCustom)
         {
            addChild(_deleteBtn);
            _contentTxt.width = _bg.width - _deleteBtn.width - 5;
         }
      }
      
      public function get deleteBtn() : SimpleBitmapButton
      {
         return _deleteBtn;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
         _deleteBtn.addEventListener("click",__delete);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
         _deleteBtn.removeEventListener("click",__delete);
      }
      
      private function __delete(param1:MouseEvent) : void
      {
         dispatchEvent(new ChatEvent("delete",this));
      }
   }
}
