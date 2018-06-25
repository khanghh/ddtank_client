package room.view.chooseMap
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
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
   import flash.events.MouseEvent;
   import room.RoomManager;
   
   public class MatchRoomSetView extends Sprite implements Disposeable
   {
       
      
      private var _frame:BaseAlerFrame;
      
      private var _bg:ScaleBitmapImage;
      
      private var _roomMode:Bitmap;
      
      private var _modelIcon:Bitmap;
      
      private var _trialModelIcon:Bitmap;
      
      private var _soprts:FilterFrameText;
      
      private var _roomName:FilterFrameText;
      
      private var _password:FilterFrameText;
      
      private var _nameInput:TextInput;
      
      private var _passInput:TextInput;
      
      private var _isReset:Boolean;
      
      private var _isChanged:Boolean = false;
      
      private var _checkBox:SelectedCheckButton;
      
      public function MatchRoomSetView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var ai:AlertInfo = new AlertInfo();
         ai.title = LanguageMgr.GetTranslation("tank.room.RoomIIMapSetPanel.room");
         var _loc2_:Boolean = false;
         ai.moveEnable = _loc2_;
         ai.showCancel = _loc2_;
         ai.submitLabel = LanguageMgr.GetTranslation("ok");
         _frame = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView");
         _frame.info = ai;
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setViewBg");
         _roomMode = ComponentFactory.Instance.creatBitmap("asset.ddtroom.setView.modeWord");
         _modelIcon = ComponentFactory.Instance.creatBitmap("asset.ddtroom.setView.modeIcon");
         _trialModelIcon = ComponentFactory.Instance.creatBitmap("aaset.ddtroom.setView.trialModelIcon");
         _trialModelIcon.visible = false;
         _soprts = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.sports");
         _soprts.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.sports");
         _roomName = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.name");
         _roomName.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.roomname");
         _password = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.password");
         _password.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.password");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.nameInput");
         _loc2_ = false;
         _nameInput.textField.multiline = _loc2_;
         _nameInput.textField.wordWrap = _loc2_;
         _nameInput.textField.tabEnabled = false;
         _passInput = ComponentFactory.Instance.creatComponentByStylename("asset.ddtMatchRoom.setView.passInput");
         _loc2_ = false;
         _nameInput.textField.multiline = _loc2_;
         _passInput.textField.wordWrap = _loc2_;
         _passInput.textField.restrict = "0-9 A-Z a-z";
         _checkBox = ComponentFactory.Instance.creat("asset.ddtMatchRoom.setView.selectBtn");
         _frame.addToContent(_bg);
         _frame.addToContent(_roomMode);
         _frame.addToContent(_modelIcon);
         _frame.addToContent(_trialModelIcon);
         _frame.addToContent(_soprts);
         _frame.addToContent(_roomName);
         _frame.addToContent(_password);
         _frame.addToContent(_nameInput);
         _frame.addToContent(_passInput);
         _frame.addToContent(_checkBox);
         addChild(_frame);
         _checkBox.addEventListener("click",__checkBoxClick);
         _frame.addEventListener("response",__frameEventHandler);
         updateRoomInfo();
      }
      
      private function updateRoomInfo() : void
      {
         _nameInput.text = RoomManager.Instance.current.Name;
         if(RoomManager.Instance.current.type == 120)
         {
            _soprts.visible = false;
            _modelIcon.visible = false;
            _trialModelIcon.visible = true;
         }
         else
         {
            _soprts.text = LanguageMgr.GetTranslation("ddt.matchRoom.setView.sports");
         }
         if(RoomManager.Instance.current.roomPass)
         {
            _checkBox.selected = true;
            _passInput.text = RoomManager.Instance.current.roomPass;
         }
         else
         {
            _checkBox.selected = false;
         }
         upadtePassTextBg();
      }
      
      private function __checkBoxClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         upadtePassTextBg();
      }
      
      private function upadtePassTextBg() : void
      {
         if(_checkBox.selected)
         {
            _passInput.mouseChildren = true;
            _passInput.mouseEnabled = true;
            _passInput.setFocus();
         }
         else
         {
            _passInput.mouseChildren = false;
            _passInput.mouseEnabled = false;
            _passInput.text = "";
         }
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            case 3:
               if(FilterWordManager.IsNullorEmpty(_nameInput.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.name"));
                  SoundManager.instance.play("008");
               }
               else if(FilterWordManager.isGotForbiddenWords(_nameInput.text,"name"))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.string"));
                  SoundManager.instance.play("008");
               }
               else if(_checkBox.selected && FilterWordManager.IsNullorEmpty(_passInput.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIICreateRoomView.set"));
                  SoundManager.instance.play("008");
               }
               else
               {
                  GameInSocketOut.sendGameRoomSetUp(0,RoomManager.Instance.current.type,false,_passInput.text,_nameInput.text,3,0,0,RoomManager.Instance.current.isCrossZone,0);
                  RoomManager.Instance.current.roomName = _nameInput.text;
                  RoomManager.Instance.current.roomPass = _passInput.text;
                  dispose();
               }
         }
      }
      
      public function showMatchRoomSetView() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         StageReferance.stage.focus = _frame;
      }
      
      public function dispose() : void
      {
         _checkBox.removeEventListener("click",__checkBoxClick);
         _frame.removeEventListener("response",__frameEventHandler);
         if(_soprts)
         {
            ObjectUtils.disposeObject(_soprts);
         }
         _soprts = null;
         if(_roomName)
         {
            ObjectUtils.disposeObject(_roomName);
         }
         _roomName = null;
         if(_password)
         {
            ObjectUtils.disposeObject(_password);
         }
         _password = null;
         if(_nameInput)
         {
            ObjectUtils.disposeObject(_nameInput);
         }
         _nameInput = null;
         if(_passInput)
         {
            ObjectUtils.disposeObject(_passInput);
         }
         _passInput = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_roomMode)
         {
            ObjectUtils.disposeObject(_roomMode);
         }
         _roomMode = null;
         if(_modelIcon)
         {
            ObjectUtils.disposeObject(_modelIcon);
         }
         _modelIcon = null;
         if(_checkBox)
         {
            ObjectUtils.disposeObject(_checkBox);
         }
         _checkBox = null;
         _frame.dispose();
         _frame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
