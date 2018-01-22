package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.list.IDropListTarget;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class NameInputDropListTarget extends Sprite implements IDropListTarget, Disposeable
   {
      
      public static const LOOK:int = 1;
      
      public static const CLOSE:int = 2;
      
      public static const CLOSE_CLICK:String = "closeClick";
      
      public static const CLEAR_CLICK:String = "clearClick";
      
      public static const LOOK_CLICK:String = "lookClick";
       
      
      protected var _background:Image;
      
      protected var _nameInput:TextInput;
      
      protected var _closeBtn:BaseButton;
      
      protected var _lookBtn:Bitmap;
      
      private var _isListening:Boolean;
      
      public function NameInputDropListTarget(){super();}
      
      protected function initView() : void{}
      
      public function set text(param1:String) : void{}
      
      public function get text() : String{return null;}
      
      public function switchView(param1:int) : void{}
      
      private function initEvent() : void{}
      
      public function set enable(param1:Boolean) : void{}
      
      private function removeEvent() : void{}
      
      public function setCursor(param1:int) : void{}
      
      public function get caretIndex() : int{return 0;}
      
      public function setValue(param1:*) : void{}
      
      public function getValueLength() : int{return 0;}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
      
      protected function __clearhandler(param1:MouseEvent) : void{}
      
      protected function __closeHandler(param1:MouseEvent) : void{}
      
      protected function __changeDropList(param1:Event) : void{}
      
      protected function _focusHandler(param1:FocusEvent) : void{}
   }
}
