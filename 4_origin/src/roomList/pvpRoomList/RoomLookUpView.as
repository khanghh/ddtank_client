package roomList.pvpRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class RoomLookUpView extends Sprite implements Disposeable
   {
       
      
      private var _hallType:int;
      
      private var _bg:Scale9CornerImage;
      
      private var _inputText:TextInput;
      
      private var _lookup:Bitmap;
      
      private var _enterBtn:TextButton;
      
      private var _flushBtn:TextButton;
      
      private var _dividingLine:Bitmap;
      
      private var _updateClick:Function;
      
      public function RoomLookUpView(func:Function, hallType:int)
      {
         super();
         init();
         initEvent();
         _updateClick = func;
         _hallType = hallType;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.lookupInputBg");
         addChild(_bg);
         _lookup = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.lookup");
         addChild(_lookup);
         _inputText = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.textinput");
         _inputText.textField.restrict = "0-9";
         addChild(_inputText);
         _inputText.text = LanguageMgr.GetTranslation("room.roomList.lookup.text");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.enter");
         _enterBtn.text = LanguageMgr.GetTranslation("room.roomList.enterBtn.text");
         addChild(_enterBtn);
         _flushBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.flush");
         _flushBtn.text = LanguageMgr.GetTranslation("room.roomList.flushBtn.text");
         addChild(_flushBtn);
         _dividingLine = ComponentFactory.Instance.creat("asset.ddtroomlist.right.dividingLine");
         addChild(_dividingLine);
      }
      
      private function initEvent() : void
      {
         _inputText.addEventListener("click",__textClick);
         _inputText.addEventListener("keyDown",__onKeyDown);
         _enterBtn.addEventListener("click",__onEnterBtnClick);
         _flushBtn.addEventListener("click",__updateClick);
      }
      
      protected function __onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            stage.removeEventListener("click",__onStageClick);
            SoundManager.instance.play("008");
            if(_inputText.text.length == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIFindRoomPanel.id"));
            }
            else
            {
               SocketManager.Instance.out.sendGameLogin(_hallType,-1,int(_inputText.text),"");
            }
         }
      }
      
      private function __updateClick(event:MouseEvent) : void
      {
         if(_updateClick != null)
         {
            _updateClick(event);
         }
      }
      
      protected function __onStageClick(event:MouseEvent) : void
      {
         stage.removeEventListener("click",__onStageClick);
         _inputText.text = LanguageMgr.GetTranslation("room.roomList.lookup.text");
      }
      
      protected function __textClick(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         stage.addEventListener("click",__onStageClick);
         _inputText.text = "";
      }
      
      protected function __onEnterBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_inputText.text.length == 6)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIFindRoomPanel.id"));
         }
         else
         {
            SocketManager.Instance.out.sendGameLogin(_hallType,-1,int(_inputText.text),"");
         }
      }
      
      private function removeEvent() : void
      {
         if(_inputText)
         {
            _inputText.removeEventListener("click",__textClick);
            _inputText.removeEventListener("keyDown",__onKeyDown);
         }
         if(stage)
         {
            stage.removeEventListener("click",__onStageClick);
         }
         _enterBtn.removeEventListener("click",__onEnterBtnClick);
         _flushBtn.removeEventListener("click",__updateClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_inputText)
         {
            _inputText.dispose();
            _inputText = null;
         }
         if(_lookup)
         {
            _lookup.bitmapData.dispose();
            _lookup = null;
         }
         if(_enterBtn)
         {
            _enterBtn.dispose();
            _enterBtn = null;
         }
         if(_flushBtn)
         {
            _flushBtn.dispose();
            _flushBtn = null;
         }
         if(_dividingLine)
         {
            ObjectUtils.disposeObject(_dividingLine);
            _dividingLine = null;
         }
      }
   }
}
