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
      
      public function NameInputDropListTarget()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("core.nameInputDropListTarget.InputTextBg");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("core.nameInputDropListTarget.NameInput");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.nameInputDropListTarget.Close");
         _lookBtn = ComponentFactory.Instance.creatBitmap("asset.core.searchIcon");
         addChild(_background);
         addChild(_nameInput);
         addChild(_closeBtn);
         addChild(_lookBtn);
         switchView(1);
      }
      
      public function set text(param1:String) : void
      {
         _nameInput.text = param1;
      }
      
      public function get text() : String
      {
         return _nameInput.text;
      }
      
      public function switchView(param1:int) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               _lookBtn.visible = true;
               _closeBtn.visible = false;
               break;
            case 1:
               _lookBtn.visible = false;
               _closeBtn.visible = true;
         }
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
         _nameInput.addEventListener("change",__changeDropList);
         _nameInput.addEventListener("focusIn",_focusHandler);
      }
      
      public function set enable(param1:Boolean) : void
      {
         _nameInput.enable = param1;
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__closeHandler);
         _nameInput.removeEventListener("change",__changeDropList);
         _nameInput.removeEventListener("focusIn",_focusHandler);
      }
      
      public function setCursor(param1:int) : void
      {
         _nameInput.textField.setSelection(param1,param1);
      }
      
      public function get caretIndex() : int
      {
         return _nameInput.textField.caretIndex;
      }
      
      public function setValue(param1:*) : void
      {
         if(param1)
         {
            _nameInput.text = param1.NickName;
         }
      }
      
      public function getValueLength() : int
      {
         if(_nameInput)
         {
            return _nameInput.text.length;
         }
         return 0;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_background);
         _background = null;
         if(_nameInput)
         {
            ObjectUtils.disposeObject(_nameInput);
         }
         _nameInput = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_lookBtn)
         {
            ObjectUtils.disposeObject(_lookBtn);
         }
         _lookBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function __clearhandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("clearClick"));
      }
      
      protected function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _nameInput.text = "";
         switchView(1);
         dispatchEvent(new Event("closeClick"));
      }
      
      protected function __changeDropList(param1:Event) : void
      {
         StringHelper.checkTextFieldLength(_nameInput.textField,14);
         if(_nameInput.text == "")
         {
            switchView(1);
         }
         else
         {
            switchView(2);
         }
         dispatchEvent(new Event("change"));
      }
      
      protected function _focusHandler(param1:FocusEvent) : void
      {
         __changeDropList(null);
      }
   }
}
