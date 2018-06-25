package church.view.weddingRoom
{
   import church.ChurchManager;
   import church.model.ChurchRoomModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WeddingRoomMenuView extends Sprite implements Disposeable
   {
       
      
      private var _model:ChurchRoomModel;
      
      private var _menuShowName:ScaleFrameImage;
      
      private var _menuShowPao:ScaleFrameImage;
      
      private var _menuShowFire:ScaleFrameImage;
      
      private var hideConfigs:Array;
      
      private var _moonBtn:MovieClip;
      
      private var _roomNameBox:Sprite;
      
      private var _roomNameBg:Scale9CornerImage;
      
      private var _txtRoomNameGroomName:FilterFrameText;
      
      private var _txtRoomNameAnd:FilterFrameText;
      
      private var _txtRoomNameBrideName:FilterFrameText;
      
      private var _txtRoomNameWedding:FilterFrameText;
      
      public function WeddingRoomMenuView(model:ChurchRoomModel)
      {
         hideConfigs = [];
         super();
         _model = model;
         initialize();
      }
      
      private function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         _menuShowName = ComponentFactory.Instance.creat("asset.church.weddingRoom.menuShowNameAsset");
         _menuShowName.buttonMode = true;
         _menuShowName.setFrame(1);
         addChild(_menuShowName);
         _menuShowPao = ComponentFactory.Instance.creat("asset.church.weddingRoom.menuShowPaoAsset");
         _menuShowPao.buttonMode = true;
         _menuShowPao.setFrame(1);
         addChild(_menuShowPao);
         _menuShowFire = ComponentFactory.Instance.creat("asset.church.weddingRoom.menuShowFireAsset");
         _menuShowFire.buttonMode = true;
         _menuShowFire.setFrame(1);
         addChild(_menuShowFire);
         setMoonBtn();
         setRoomName();
      }
      
      private function removeView() : void
      {
         if(_menuShowName)
         {
            if(_menuShowName.parent)
            {
               _menuShowName.parent.removeChild(_menuShowName);
            }
            _menuShowName.dispose();
         }
         _menuShowName = null;
         if(_menuShowPao)
         {
            if(_menuShowPao.parent)
            {
               _menuShowPao.parent.removeChild(_menuShowPao);
            }
            _menuShowPao.dispose();
         }
         _menuShowPao = null;
         if(_menuShowFire)
         {
            if(_menuShowFire.parent)
            {
               _menuShowFire.parent.removeChild(_menuShowFire);
            }
            _menuShowFire.dispose();
         }
         _menuShowFire = null;
         if(_roomNameBg)
         {
            if(_roomNameBg.parent)
            {
               _roomNameBg.parent.removeChild(_roomNameBg);
            }
            _roomNameBg.dispose();
         }
         _roomNameBg = null;
         if(_txtRoomNameGroomName)
         {
            if(_txtRoomNameGroomName.parent)
            {
               _txtRoomNameGroomName.parent.removeChild(_txtRoomNameGroomName);
            }
            _txtRoomNameGroomName.dispose();
         }
         _txtRoomNameGroomName = null;
         if(_txtRoomNameAnd)
         {
            if(_txtRoomNameAnd.parent)
            {
               _txtRoomNameAnd.parent.removeChild(_txtRoomNameAnd);
            }
            _txtRoomNameAnd.dispose();
         }
         _txtRoomNameAnd = null;
         if(_txtRoomNameBrideName)
         {
            if(_txtRoomNameBrideName.parent)
            {
               _txtRoomNameBrideName.parent.removeChild(_txtRoomNameBrideName);
            }
            _txtRoomNameBrideName.dispose();
         }
         _txtRoomNameBrideName = null;
         if(_txtRoomNameWedding)
         {
            if(_txtRoomNameWedding.parent)
            {
               _txtRoomNameWedding.parent.removeChild(_txtRoomNameWedding);
            }
            _txtRoomNameWedding.dispose();
         }
         _txtRoomNameWedding = null;
         if(_moonBtn && _moonBtn.parent)
         {
            _moonBtn.parent.removeChild(_moonBtn);
         }
         _moonBtn = null;
         if(_roomNameBox && _roomNameBox.parent)
         {
            _roomNameBox.parent.removeChild(_roomNameBox);
         }
         _roomNameBox = null;
         hideConfigs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function setEvent() : void
      {
         _menuShowName.addEventListener("click",onMenuClick);
         _menuShowPao.addEventListener("click",onMenuClick);
         _menuShowFire.addEventListener("click",onMenuClick);
      }
      
      public function backupConfig() : void
      {
         hideConfigs[0] = !!_model.playerNameVisible?true:false;
         hideConfigs[1] = !!_model.playerChatBallVisible?true:false;
         hideConfigs[2] = !!_model.playerFireVisible?true:false;
         var _loc1_:* = false;
         _model.playerFireVisible = _loc1_;
         _loc1_ = _loc1_;
         _model.playerChatBallVisible = _loc1_;
         _model.playerNameVisible = _loc1_;
         _loc1_ = false;
         _menuShowFire.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _menuShowPao.mouseEnabled = _loc1_;
         _menuShowName.mouseEnabled = _loc1_;
         _menuShowName.setFrame(2);
         _menuShowPao.setFrame(2);
         _menuShowFire.setFrame(2);
      }
      
      public function revertConfig() : void
      {
         _model.playerNameVisible = hideConfigs[0];
         _model.playerChatBallVisible = hideConfigs[1];
         _model.playerFireVisible = hideConfigs[2];
         var _loc1_:* = true;
         _menuShowFire.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _menuShowPao.mouseEnabled = _loc1_;
         _menuShowName.mouseEnabled = _loc1_;
         _menuShowName.setFrame(!!_model.playerNameVisible?1:2);
         _menuShowPao.setFrame(!!_model.playerChatBallVisible?1:2);
         _menuShowFire.setFrame(!!_model.playerFireVisible?1:2);
      }
      
      private function removeEvent() : void
      {
         _menuShowName.removeEventListener("click",onMenuClick);
         _menuShowPao.removeEventListener("click",onMenuClick);
         _menuShowFire.removeEventListener("click",onMenuClick);
         _moonBtn.removeEventListener("click",enterMoonScene);
      }
      
      private function onMenuClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = evt.currentTarget;
         if(_menuShowName !== _loc2_)
         {
            if(_menuShowPao !== _loc2_)
            {
               if(_menuShowFire === _loc2_)
               {
                  if(_menuShowFire.getFrame == 1)
                  {
                     _menuShowFire.setFrame(2);
                     _model.playerFireVisible = false;
                  }
                  else
                  {
                     _menuShowFire.setFrame(1);
                     _model.playerFireVisible = true;
                  }
               }
            }
            else if(_menuShowPao.getFrame == 1)
            {
               _menuShowPao.setFrame(2);
               _model.playerChatBallVisible = false;
            }
            else
            {
               _menuShowPao.setFrame(1);
               _model.playerChatBallVisible = true;
            }
         }
         else if(_menuShowName.getFrame == 1)
         {
            _menuShowName.setFrame(2);
            _model.playerNameVisible = false;
         }
         else
         {
            _menuShowName.setFrame(1);
            _model.playerNameVisible = true;
         }
      }
      
      public function resetView() : void
      {
         if(ChurchManager.instance.currentScene == 0)
         {
            if(_roomNameBox.parent)
            {
               removeChild(_roomNameBox);
            }
            if(_moonBtn.parent)
            {
               removeChild(_moonBtn);
            }
         }
         else
         {
            addChild(_roomNameBox);
            if(ChurchManager.instance.currentRoom.isStarted && ChurchManager.instance.currentRoom.status == "wedding_none")
            {
               addChild(_moonBtn);
            }
            else if(_moonBtn.parent)
            {
               removeChild(_moonBtn);
            }
         }
      }
      
      private function setMoonBtn() : void
      {
         if(!_moonBtn)
         {
            _moonBtn = ComponentFactory.Instance.creatCustomObject("church.room.moonBtnAsset");
            _moonBtn.buttonMode = true;
            _moonBtn.addEventListener("click",enterMoonScene);
         }
      }
      
      private function setRoomName() : void
      {
         _roomNameBox = new Sprite();
         _roomNameBox.mouseEnabled = false;
         addChild(_roomNameBox);
         _roomNameBg = ComponentFactory.Instance.creat("church.weddingRoom.roomNameBg");
         _roomNameBox.addChild(_roomNameBg);
         _txtRoomNameGroomName = ComponentFactory.Instance.creat("church.weddingRoom.roomNameGroomBrideName");
         _txtRoomNameGroomName.text = ChurchManager.instance.currentRoom.groomName;
         _txtRoomNameGroomName.x = 5;
         _txtRoomNameGroomName.y = 5;
         _roomNameBox.addChild(_txtRoomNameGroomName);
         _txtRoomNameAnd = ComponentFactory.Instance.creat("church.weddingRoom.roomNameWedding");
         _txtRoomNameAnd.text = LanguageMgr.GetTranslation("yu");
         _txtRoomNameAnd.x = _txtRoomNameGroomName.x + _txtRoomNameGroomName.textWidth;
         _txtRoomNameAnd.y = 5;
         _roomNameBox.addChild(_txtRoomNameAnd);
         _txtRoomNameBrideName = ComponentFactory.Instance.creat("church.weddingRoom.roomNameGroomBrideName");
         _txtRoomNameBrideName.text = ChurchManager.instance.currentRoom.brideName;
         _txtRoomNameBrideName.x = _txtRoomNameAnd.x + _txtRoomNameAnd.textWidth;
         _txtRoomNameBrideName.y = 5;
         _roomNameBox.addChild(_txtRoomNameBrideName);
         _txtRoomNameWedding = ComponentFactory.Instance.creat("church.weddingRoom.roomNameWedding");
         _txtRoomNameWedding.x = _txtRoomNameBrideName.x + _txtRoomNameBrideName.textWidth;
         _txtRoomNameWedding.y = 5;
         _txtRoomNameWedding.text = LanguageMgr.GetTranslation("dehunli");
         _roomNameBox.addChild(_txtRoomNameWedding);
         _roomNameBg.width = _roomNameBox.width + 5;
         _roomNameBg.height = _roomNameBox.height;
         _roomNameBox.x = 1000 - _roomNameBox.width - 5;
         _roomNameBox.y = 10;
      }
      
      private function enterMoonScene(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ChurchManager.instance.lastScene = ChurchManager.instance.currentScene;
         ChurchManager.instance.currentScene = 0;
         ComponentSetting.SEND_USELOG_ID(92);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
