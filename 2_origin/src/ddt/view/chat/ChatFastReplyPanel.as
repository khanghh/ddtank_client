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
      
      public function ChatFastReplyPanel(inGame:Boolean = false)
      {
         _inGame = inGame;
         super();
      }
      
      public function get isEditing() : Boolean
      {
         return _isEditing;
      }
      
      public function set isEditing(value:Boolean) : void
      {
         _isEditing = value;
      }
      
      public function get selectedWrod() : String
      {
         return _selected;
      }
      
      override public function set setVisible(value:Boolean) : void
      {
         .super.setVisible = value;
         if(value)
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
      
      private function __itemClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var t:ChatFastReplyItem = evt.currentTarget as ChatFastReplyItem;
         _selected = t.word;
         if(_inGame)
         {
            dispatchEvent(new Event("selectedingame"));
         }
         else
         {
            dispatchEvent(new Event("select"));
         }
      }
      
      private function __mouseClick(evt:*) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         var _loc2_:* = evt.currentTarget;
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
      
      private function __deleteItem(e:ChatEvent) : void
      {
         SoundManager.instance.play("008");
         var item:ChatFastReplyItem = e.data as ChatFastReplyItem;
         var idx:uint = _items.indexOf(item);
         item.removeEventListener("click",__itemClick);
         item.dispose();
         _items.splice(idx,1);
         ChatManager.Instance.model.customFastReply.splice(idx - 5,1);
         delete SharedManager.Instance.fastReplys[item.word];
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
         var str:String = FilterWordManager.filterWrod(_inputBox.text);
         var item:ChatFastReplyItem = new ChatFastReplyItem(str,true);
         item.addEventListener("click",__itemClick);
         item.addEventListener("delete",__deleteItem);
         _items.push(item);
         ChatManager.Instance.model.customFastReply.push(item.word);
         _box.addChild(item);
         SharedManager.Instance.fastReplys[item.word] = item.word;
         SharedManager.Instance.save();
         _customCnt = Number(_customCnt) + 1;
         updatePos(1);
         _inputBox.text = _defaultStr;
         _inputBox.scrollH = 0;
         StageReferance.stage.focus = null;
      }
      
      private function updatePos(value:int) : void
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
         y = y - 21 * value;
      }
      
      private function fixVerticalPos() : void
      {
         var len:uint = _items.length - 5;
         y = y - len * 21;
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         var item:* = null;
         var item1:* = null;
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
         for(i = 0; i < FASTREPLYS.length; )
         {
            item = new ChatFastReplyItem(FASTREPLYS[i]);
            item.addEventListener("click",__itemClick);
            _items.push(item);
            _box.addChild(item);
            i++;
         }
         _box.addChild(_boundary);
         var _loc6_:int = 0;
         var _loc5_:* = SharedManager.Instance.fastReplys;
         for(var str in SharedManager.Instance.fastReplys)
         {
            item1 = new ChatFastReplyItem(SharedManager.Instance.fastReplys[str],true);
            item1.addEventListener("click",__itemClick);
            item1.addEventListener("delete",__deleteItem);
            ChatManager.Instance.model.customFastReply.push(item1.word);
            _items.push(item1);
            _box.addChild(item1);
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
      
      private function __spriteClick(e:MouseEvent) : void
      {
         isEditing = false;
      }
      
      private function __checkMaxChars(event:TextEvent) : void
      {
         if(_inputBox.length >= 20)
         {
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("chat.FastReplyCustomTextLengthLimit"));
         }
      }
      
      private function __creatItem(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         if(event.keyCode == 13)
         {
            SoundManager.instance.play("008");
            createCustomItem();
         }
      }
      
      private function __focusOut(event:FocusEvent) : void
      {
         if(event.currentTarget.text == "" || event.currentTarget.text == _defaultStr)
         {
            event.currentTarget.text = _defaultStr;
         }
      }
   }
}
