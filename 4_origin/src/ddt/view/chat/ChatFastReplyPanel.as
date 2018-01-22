package ddt.view.chat
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class ChatFastReplyPanel extends ChatBasePanel
   {
      
      public static const SELECTED_INGAME:String = "selectedingame";
      
      private static const FASTREPLYS:Array = [LanguageMgr.GetTranslation("chat.fastRepley.Message0"),LanguageMgr.GetTranslation("chat.fastRepley.Message1"),LanguageMgr.GetTranslation("chat.fastRepley.Message2"),LanguageMgr.GetTranslation("chat.fastRepley.Message3"),LanguageMgr.GetTranslation("chat.fastRepley.Message4")];
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _box:VBox;
      
      private var _inGame:Boolean;
      
      private var _items:Vector.<ChatFastReplyItem>;
      
      private var _selected:String;
      
      private var _boundary:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _enterBtn:SimpleBitmapButton;
      
      private var _inputBox:FilterFrameText;
      
      private var _defaultStr:String;
      
      private var _customCnt:uint;
      
      private var _isDeleting:Boolean;
      
      private var _customBg:Shape;
      
      private var _tempText:String;
      
      private var _isEditing:Boolean;
      
      public function ChatFastReplyPanel(param1:Boolean = false)
      {
         _inGame = param1;
         super();
      }
      
      public function get isEditing() : Boolean
      {
         return _isEditing;
      }
      
      public function set isEditing(param1:Boolean) : void
      {
         _isEditing = param1;
      }
      
      public function get selectedWrod() : String
      {
         return _selected;
      }
      
      override public function set setVisible(param1:Boolean) : void
      {
         .super.setVisible = param1;
         if(param1)
         {
            if(ChatManager.Instance.isInGame)
            {
               isEditing = true;
            }
            fixVerticalPos();
            _tempText = _inputBox.text;
            _inputBox.text = _defaultStr;
            _inputBox.scrollH = 0;
         }
      }
      
      public function setText() : void
      {
         visible = true;
         _inputBox.text = _tempText;
         y = y + (_items.length - 5) * 21;
         isEditing = false;
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:ChatFastReplyItem = param1.currentTarget as ChatFastReplyItem;
         _selected = _loc2_.word;
         if(_inGame)
         {
            dispatchEvent(new Event("selectedingame"));
         }
         else
         {
            dispatchEvent(new Event("select"));
         }
      }
      
      private function __mouseClick(param1:*) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc2_:* = param1.currentTarget;
         if(_inputBox !== _loc2_)
         {
            if(_enterBtn !== _loc2_)
            {
               if(_isDeleting)
               {
                  _isDeleting = false;
                  return;
               }
            }
            else
            {
               createCustomItem();
            }
         }
         else if(_inputBox.text == _defaultStr)
         {
            _inputBox.text = "";
         }
      }
      
      private function __deleteItem(param1:ChatEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:ChatFastReplyItem = param1.data as ChatFastReplyItem;
         var _loc2_:uint = _items.indexOf(_loc3_);
         _loc3_.removeEventListener("click",__itemClick);
         _loc3_.dispose();
         _items.splice(_loc2_,1);
         ChatManager.Instance.model.customFastReply.splice(_loc2_ - 5,1);
         delete SharedManager.Instance.fastReplys[_loc3_.word];
         SharedManager.Instance.save();
         _customCnt = Number(_customCnt) - 1;
         updatePos(-1);
         _isDeleting = true;
      }
      
      private function createCustomItem() : void
      {
         if(_inputBox.text == "" || _inputBox.text == _defaultStr)
         {
            return;
         }
         if(_customCnt >= 5)
         {
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("chat.FastReplyCustomCountLimit"));
            return;
         }
         var _loc1_:String = FilterWordManager.filterWrod(_inputBox.text);
         var _loc2_:ChatFastReplyItem = new ChatFastReplyItem(_loc1_,true);
         _loc2_.addEventListener("click",__itemClick);
         _loc2_.addEventListener("delete",__deleteItem);
         _items.push(_loc2_);
         ChatManager.Instance.model.customFastReply.push(_loc2_.word);
         _box.addChild(_loc2_);
         SharedManager.Instance.fastReplys[_loc2_.word] = _loc2_.word;
         SharedManager.Instance.save();
         _customCnt = Number(_customCnt) + 1;
         updatePos(1);
         _inputBox.text = _defaultStr;
         _inputBox.scrollH = 0;
         StageReferance.stage.focus = null;
      }
      
      private function updatePos(param1:int) : void
      {
         _inputBg.y = _box.height + 10;
         _enterBtn.y = _inputBg.y + 2;
         _inputBox.y = _enterBtn.y + 2;
         _bg.height = _inputBox.y + _inputBox.height + 6;
         _customBg.y = _boundary.y + _boundary.height + 8;
         if(_customCnt == 0)
         {
            _customBg.height = 0;
         }
         else
         {
            _customBg.height = _box.height - _customBg.y + 8;
         }
         y = y - 21 * param1;
      }
      
      private function fixVerticalPos() : void
      {
         var _loc1_:uint = _items.length - 5;
         y = y - _loc1_ * 21;
      }
      
      override protected function init() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         super.init();
         _defaultStr = LanguageMgr.GetTranslation("chat.FastReplyDefaultStr");
         _bg = ComponentFactory.Instance.creatComponentByStylename("chat.FastReplyBg");
         _box = ComponentFactory.Instance.creatComponentByStylename("chat.FastReplyList");
         _boundary = ComponentFactory.Instance.creatBitmap("asset.chat.FastReplyBoundary");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.chat.FastReplyInputBg");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("chat.FastReplyEnterBtn");
         _inputBox = ComponentFactory.Instance.creatComponentByStylename("chat.FastReplyInputTxt");
         _customBg = new Shape();
         _customBg.graphics.beginFill(12166,0.4);
         _customBg.graphics.drawRect(5,0,168,1);
         _customBg.graphics.endFill();
         _items = new Vector.<ChatFastReplyItem>();
         _loc4_ = 0;
         while(_loc4_ < FASTREPLYS.length)
         {
            _loc3_ = new ChatFastReplyItem(FASTREPLYS[_loc4_]);
            _loc3_.addEventListener("click",__itemClick);
            _items.push(_loc3_);
            _box.addChild(_loc3_);
            _loc4_++;
         }
         _box.addChild(_boundary);
         var _loc6_:int = 0;
         var _loc5_:* = SharedManager.Instance.fastReplys;
         for(var _loc2_ in SharedManager.Instance.fastReplys)
         {
            _loc1_ = new ChatFastReplyItem(SharedManager.Instance.fastReplys[_loc2_],true);
            _loc1_.addEventListener("click",__itemClick);
            _loc1_.addEventListener("delete",__deleteItem);
            ChatManager.Instance.model.customFastReply.push(_loc1_.word);
            _items.push(_loc1_);
            _box.addChild(_loc1_);
            _customCnt = Number(_customCnt) + 1;
         }
         _inputBox.maxChars = 20;
         _inputBox.text = _defaultStr;
         _selected = "";
         updatePos(0);
         fixVerticalPos();
         addChild(_bg);
         addChild(_customBg);
         addChild(_box);
         addChild(_inputBg);
         addChild(_enterBtn);
         addChild(_inputBox);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _inputBox.addEventListener("focusOut",__focusOut);
         _inputBox.addEventListener("keyDown",__creatItem);
         _inputBox.addEventListener("click",__mouseClick);
         _inputBox.addEventListener("textInput",__checkMaxChars);
         _enterBtn.addEventListener("click",__mouseClick);
         addEventListener("click",__spriteClick);
      }
      
      private function __spriteClick(param1:MouseEvent) : void
      {
         isEditing = false;
      }
      
      private function __checkMaxChars(param1:TextEvent) : void
      {
         if(_inputBox.length >= 20)
         {
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("chat.FastReplyCustomTextLengthLimit"));
         }
      }
      
      private function __creatItem(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         if(param1.keyCode == 13)
         {
            SoundManager.instance.play("008");
            createCustomItem();
         }
      }
      
      private function __focusOut(param1:FocusEvent) : void
      {
         if(param1.currentTarget.text == "" || param1.currentTarget.text == _defaultStr)
         {
            param1.currentTarget.text = _defaultStr;
         }
      }
   }
}
