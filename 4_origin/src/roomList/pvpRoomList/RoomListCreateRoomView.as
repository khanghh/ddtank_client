package roomList.pvpRoomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import roomList.RoomListEnumerate;
   
   public class RoomListCreateRoomView extends BaseAlerFrame implements Disposeable
   {
       
      
      protected var _athleticsBg:Bitmap;
      
      protected var _athleticsBtn:SimpleBitmapButton;
      
      protected var _bg:Bitmap;
      
      protected var _checkBox:SelectedCheckButton;
      
      protected var _createRoomBitmap:Bitmap;
      
      protected var _explainTxt:FilterFrameText;
      
      protected var _exploreBtn:SimpleBitmapButton;
      
      protected var _passBtn:SimpleBitmapButton;
      
      protected var _passTxt:TextInput;
      
      protected var _roomModelBitmap:Bitmap;
      
      protected var _textBG:ScaleFrameImage;
      
      protected var _textbg:Bitmap;
      
      protected var _alertInfo:AlertInfo;
      
      public function RoomListCreateRoomView()
      {
         super();
         initContainer();
         initEvent();
      }
      
      protected function initContainer() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.titleText");
         info = _alertInfo;
         _roomModelBitmap = ComponentFactory.Instance.creatBitmap("asset.roomList.roomModelText");
         addToContent(_roomModelBitmap);
         _createRoomBitmap = ComponentFactory.Instance.creatBitmap("asset.roomList.CreateRoomText");
         addToContent(_createRoomBitmap);
         _textBG = ComponentFactory.Instance.creat("roomList.pvpRoomList.textBg");
         _textBG.setFrame(2);
         addToContent(_textBG);
         _explainTxt = ComponentFactory.Instance.creat("roomList.pvpRoomList.ExplainText");
         var testBg:Sprite = new Sprite();
         testBg.graphics.beginFill(16777215);
         testBg.graphics.drawRect(_explainTxt.x,_explainTxt.y,_explainTxt.width,_explainTxt.height);
         testBg.graphics.endFill();
         addToContent(testBg);
         _explainTxt.text = RoomListEnumerate.PREWORD[int(Math.random() * RoomListEnumerate.PREWORD.length)];
         addToContent(_explainTxt);
         _passTxt = ComponentFactory.Instance.creat("roomList.pvpRoomList.passText");
         _passTxt.text = "";
         _passTxt.textField.restrict = "0-9 A-Z a-z";
         _passTxt.visible = false;
         addToContent(_passTxt);
         _exploreBtn = ComponentFactory.Instance.creat("roomList.pvpRoomList.exploreBtn");
         addToContent(_exploreBtn);
         _athleticsBg = ComponentFactory.Instance.creatBitmap("asset.roomList.athletics");
         addToContent(_athleticsBg);
         _athleticsBtn = ComponentFactory.Instance.creat("roomList.pvpRoomList.LightAthleticsBtn");
         _athleticsBtn.addEventListener("click",__btnClick);
         addToContent(_athleticsBtn);
         _bg = ComponentFactory.Instance.creatBitmap("asset.roomList.bg_01");
         addToContent(_bg);
         _textbg = ComponentFactory.Instance.creatBitmap("asset.roomList.explainText_2");
         addToContent(_textbg);
         _checkBox = ComponentFactory.Instance.creat("roomList.pvpRoomList.simpleSelectBtn");
         addToContent(_checkBox);
         _passBtn = ComponentFactory.Instance.creat("roomList.pvpRoomList.passBtn");
         addToContent(_passBtn);
      }
      
      private function initEvent() : void
      {
         _checkBox.addEventListener("click",__checkBoxClick);
         _passBtn.addEventListener("click",__passBtnClick);
         _passTxt.addEventListener("keyDown",__passKeyDown);
         addEventListener("response",__frameEvent);
      }
      
      private function __btnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __frameEvent(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               hide();
               break;
            case 2:
            case 3:
            case 4:
               submit();
         }
      }
      
      protected function __passBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _checkBox.selected = !_checkBox.selected;
         upadtePassTextBg();
      }
      
      private function __checkBoxClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         upadtePassTextBg();
      }
      
      private function __passKeyDown(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 13)
         {
            submit();
         }
      }
      
      private function upadtePassTextBg() : void
      {
         if(_checkBox.selected)
         {
            _textBG.setFrame(1);
            _passTxt.visible = true;
            _passTxt.setFocus();
         }
         else
         {
            _textBG.setFrame(2);
            _passTxt.visible = false;
         }
      }
      
      protected function submit() : void
      {
         if(FilterWordManager.IsNullorEmpty(_explainTxt.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.name"));
            SoundManager.instance.play("008");
         }
         else if(FilterWordManager.isGotForbiddenWords(_explainTxt.text,"name"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.string"));
            SoundManager.instance.play("008");
         }
         else if(_checkBox.selected && FilterWordManager.IsNullorEmpty(_passTxt.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.set"));
            SoundManager.instance.play("008");
         }
         else
         {
            GameInSocketOut.sendCreateRoom(_explainTxt.text,4,3,!!_checkBox.selected?_passTxt.text:"");
            hide();
         }
      }
      
      protected function hide() : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_checkBox)
         {
            _checkBox.removeEventListener("click",__checkBoxClick);
         }
         if(_passBtn)
         {
            _passBtn.removeEventListener("click",__passBtnClick);
         }
         if(_passTxt)
         {
            _passTxt.removeEventListener("keyDown",__passKeyDown);
         }
         removeEventListener("response",__frameEvent);
         ObjectUtils.disposeObject(_athleticsBg);
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_createRoomBitmap);
         ObjectUtils.disposeObject(_roomModelBitmap);
         ObjectUtils.disposeObject(_textbg);
         ObjectUtils.disposeObject(_athleticsBtn);
         ObjectUtils.disposeObject(_checkBox);
         ObjectUtils.disposeObject(_explainTxt);
         ObjectUtils.disposeObject(_exploreBtn);
         ObjectUtils.disposeObject(_passBtn);
         ObjectUtils.disposeObject(_passTxt);
         ObjectUtils.disposeObject(_textBG);
         _alertInfo = null;
         _checkBox = null;
         _passBtn = null;
         _passTxt = null;
         _athleticsBg = null;
         _bg = null;
         _createRoomBitmap = null;
         _roomModelBitmap = null;
         _textbg = null;
         _athleticsBtn = null;
         _explainTxt = null;
         _exploreBtn = null;
         _textBG = null;
         super.dispose();
      }
   }
}
