package academy.view
{
   import academy.AcademyController;
   import academy.AcademyEvent;
   import academy.AcademyManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import church.ChurchManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class AcademyPlayerPanel extends Sprite implements Disposeable
   {
       
      
      private var _academyTitle:Bitmap;
      
      private var _data:Bitmap;
      
      private var _online:Bitmap;
      
      private var _courtshipBtn:TextButton;
      
      private var _talkBtn:TextButton;
      
      private var _equipBtn:TextButton;
      
      private var _addBtn:TextButton;
      
      private var _requestMasterBtn:SimpleBitmapButton;
      
      private var _requestApprenticeBtn:SimpleBitmapButton;
      
      private var _leftBg:Scale9CornerImage;
      
      private var _textLableBg:ScaleFrameImage;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _guildNameTxt:FilterFrameText;
      
      private var _graduatesCountTxt:FilterFrameText;
      
      private var _honourOfMasterTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _winProbabilityTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _bg:MovieClip;
      
      private var _introductionTxt:TextArea;
      
      private var _levelIcon:LevelIcon;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _marriedIcon:MarriedIcon;
      
      private var _info:AcademyPlayerInfo;
      
      private var _controller:AcademyController;
      
      private var _player:RoomCharacter;
      
      private var _characteContainer:Sprite;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function AcademyPlayerPanel(param1:AcademyController)
      {
         super();
         _controller = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _academyTitle = ComponentFactory.Instance.creatBitmap("asset.ddtacademy.academyTitleAsset");
         addChild(_academyTitle);
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("asset.AcademyPlayerPanel.leftBg");
         addChild(_leftBg);
         _bg = ClassUtils.CreatInstance("asset.ddtacademy.academyleftBg2") as MovieClip;
         PositionUtils.setPos(_bg,"ddtacademy.academyleftBg2Pos");
         addChild(_bg);
         _textLableBg = ComponentFactory.Instance.creat("academy.ddtAcademyPlayerPanel.textLableBg");
         _textLableBg.setFrame(1);
         addChild(_textLableBg);
         _data = ComponentFactory.Instance.creatBitmap("asset.ddtacademy.dataImage");
         addChild(_data);
         _talkBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyPlayerPanel.talkBtn");
         _talkBtn.text = LanguageMgr.GetTranslation("civil.leftview.talkName");
         addChild(_talkBtn);
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyPlayerPanel.equipBtn");
         _equipBtn.text = LanguageMgr.GetTranslation("civil.leftview.equipName");
         addChild(_equipBtn);
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyPlayerPanel.addBtn");
         _addBtn.text = LanguageMgr.GetTranslation("civil.leftview.addName");
         addChild(_addBtn);
         _requestMasterBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyPlayerPanel.requestMasterBtn");
         addChild(_requestMasterBtn);
         _requestApprenticeBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyPlayerPanel.requestApprenticeBtn");
         addChild(_requestApprenticeBtn);
         _playerNameTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.PlayerNameII");
         _guildNameTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.guildName");
         addChild(_guildNameTxt);
         _graduatesCountTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.repute");
         addChild(_graduatesCountTxt);
         _winProbabilityTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.winProbabilityTxt");
         addChild(_winProbabilityTxt);
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.fightPowerTxt");
         addChild(_fightPowerTxt);
         _honourOfMasterTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.honourOfMasterTxt");
         addChild(_honourOfMasterTxt);
         _courtshipBtn = ComponentFactory.Instance.creatComponentByStylename("academy.ddtAcademyPlayerPanel.courtshipBtn");
         _courtshipBtn.text = LanguageMgr.GetTranslation("civil.leftview.courtshipName");
         if(PathManager.solveChurchEnable())
         {
            addChild(_courtshipBtn);
         }
         else
         {
            _equipBtn.y = _courtshipBtn.y;
            _addBtn.x = _equipBtn.x;
         }
         _online = ComponentFactory.Instance.creatBitmap("asset.academy.online");
         _introductionTxt = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyPlayerPanel.IntroductionText");
         _characteContainer = new Sprite();
         addChild(_characteContainer);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("academy.AcademyPlayerPanel.levelIcon");
         _levelIcon.setSize(0);
         addChild(_levelIcon);
      }
      
      private function initEvent() : void
      {
         _controller.addEventListener("academyPlayerChange",__playerChange);
         _courtshipBtn.addEventListener("click",__onBtnClick);
         _talkBtn.addEventListener("click",__onBtnClick);
         _equipBtn.addEventListener("click",__onBtnClick);
         _addBtn.addEventListener("click",__onBtnClick);
         _requestMasterBtn.addEventListener("click",__onBtnClick);
         _requestApprenticeBtn.addEventListener("click",__onBtnClick);
      }
      
      private function removeEvent() : void
      {
         _controller.removeEventListener("academyPlayerChange",__playerChange);
         _courtshipBtn.removeEventListener("click",__onBtnClick);
         _talkBtn.removeEventListener("click",__onBtnClick);
         _equipBtn.removeEventListener("click",__onBtnClick);
         _addBtn.removeEventListener("click",__onBtnClick);
         _requestMasterBtn.removeEventListener("click",__onBtnClick);
         _requestApprenticeBtn.removeEventListener("click",__onBtnClick);
      }
      
      private function __onBtnClick(param1:MouseEvent) : void
      {
         if(_info == null)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_courtshipBtn !== _loc2_)
         {
            if(_talkBtn !== _loc2_)
            {
               if(_equipBtn !== _loc2_)
               {
                  if(_addBtn !== _loc2_)
                  {
                     if(_requestMasterBtn !== _loc2_)
                     {
                        if(_requestApprenticeBtn === _loc2_)
                        {
                           if(PlayerManager.Instance.Self.apprenticeshipState != 1 && AcademyManager.Instance.compareState(_info.info,PlayerManager.Instance.Self))
                           {
                              AcademyFrameManager.Instance.showAcademyRequestApprenticeFrame(_info.info);
                           }
                        }
                     }
                     else if(AcademyManager.Instance.compareState(_info.info,PlayerManager.Instance.Self))
                     {
                        AcademyFrameManager.Instance.showAcademyRequestMasterFrame(_info.info);
                     }
                  }
                  else
                  {
                     IMManager.Instance.addFriend(_info.info.NickName);
                  }
               }
               else
               {
                  PlayerInfoViewControl.viewByID(_info.info.ID,PlayerManager.Instance.Self.ZoneID);
               }
            }
            else
            {
               ChatManager.Instance.privateChatTo(_info.info.NickName);
            }
         }
         else
         {
            ChurchManager.instance.sendValidateMarry(_info.info);
         }
      }
      
      private function __playerChange(param1:AcademyEvent) : void
      {
         _info = _controller.model.info;
         update();
      }
      
      private function createCharacter() : void
      {
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         _player = CharactoryFactory.createCharacter(_info.info,"room") as RoomCharacter;
         _player.addEventListener("complete",__characterComplete);
         _player.show(true,-1);
      }
      
      private function update() : void
      {
         if(_controller.model.state)
         {
            _requestApprenticeBtn.visible = true;
            _requestMasterBtn.visible = false;
         }
         else
         {
            _requestApprenticeBtn.visible = false;
            _requestMasterBtn.visible = true;
         }
         if(_info)
         {
            var _loc3_:* = true;
            _characteContainer.visible = _loc3_;
            _loc3_ = _loc3_;
            _requestApprenticeBtn.enable = _loc3_;
            _loc3_ = _loc3_;
            _requestMasterBtn.enable = _loc3_;
            _loc3_ = _loc3_;
            _addBtn.enable = _loc3_;
            _loc3_ = _loc3_;
            _equipBtn.enable = _loc3_;
            _loc3_ = _loc3_;
            _talkBtn.enable = _loc3_;
            _courtshipBtn.enable = _loc3_;
            if(_levelIcon)
            {
               _levelIcon.visible = true;
            }
            if(_vipIcon)
            {
               _vipIcon.visible = true;
            }
            if(_marriedIcon)
            {
               _marriedIcon.visible = true;
            }
            _courtshipBtn.enable = getCourtshipBtnEnable();
            var _loc2_:PlayerInfo = _info.info;
            _playerNameTxt.text = _loc2_.NickName;
            _guildNameTxt.text = !!_loc2_.ConsortiaName?_loc2_.ConsortiaName:"";
            _graduatesCountTxt.text = String(_loc2_.graduatesCount);
            var _loc1_:Number = _loc2_.TotalCount > 0?_loc2_.WinCount / _loc2_.TotalCount * 100:0;
            _winProbabilityTxt.text = String(_loc1_.toFixed(2)) + "%";
            _fightPowerTxt.text = String(_loc2_.FightPower);
            _honourOfMasterTxt.text = _loc2_.honourOfMaster;
            _introductionTxt.text = _info.Introduction;
            _online.visible = _loc2_.playerState.StateID == 1?true:false;
            _equipBtn.enable = _info.IsPublishEquip;
            if(_loc2_.playerState.StateID == 1)
            {
               _talkBtn.enable = true;
            }
            else
            {
               _talkBtn.enable = false;
            }
            if(_loc2_.IsVIP)
            {
               ObjectUtils.disposeObject(_vipName);
               _vipName = VipController.instance.getVipNameTxt(157,_loc2_.typeVIP);
               _vipName.textSize = 16;
               _vipName.x = _playerNameTxt.x;
               _vipName.y = _playerNameTxt.y;
               _vipName.text = _playerNameTxt.text;
               addChild(_vipName);
               DisplayUtils.removeDisplay(_playerNameTxt);
            }
            else
            {
               addChild(_playerNameTxt);
               DisplayUtils.removeDisplay(_vipName);
            }
            createCharacter();
            updateIcon();
            updateTextPos();
            creatAttestBtn();
            return;
         }
         _loc3_ = false;
         _characteContainer.visible = _loc3_;
         _loc3_ = _loc3_;
         _online.visible = _loc3_;
         _loc3_ = _loc3_;
         _requestApprenticeBtn.enable = _loc3_;
         _loc3_ = _loc3_;
         _requestMasterBtn.enable = _loc3_;
         _loc3_ = _loc3_;
         _addBtn.enable = _loc3_;
         _loc3_ = _loc3_;
         _equipBtn.enable = _loc3_;
         _loc3_ = _loc3_;
         _talkBtn.enable = _loc3_;
         _courtshipBtn.enable = _loc3_;
         _playerNameTxt.text = "";
         _guildNameTxt.text = "";
         _graduatesCountTxt.text = "";
         _winProbabilityTxt.text = "";
         _fightPowerTxt.text = "";
         _honourOfMasterTxt.text = "";
         _introductionTxt.text = "";
         if(_vipName)
         {
            _vipName.visible = false;
         }
         if(_levelIcon)
         {
            _levelIcon.visible = false;
         }
         if(_vipIcon)
         {
            _vipIcon.visible = false;
         }
         if(_marriedIcon)
         {
            _marriedIcon.visible = false;
         }
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.info.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
            }
            if(_info.info.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y - 4;
            }
            else
            {
               _attestBtn.x = _playerNameTxt.x + _playerNameTxt.width;
               _attestBtn.y = _playerNameTxt.y - 4;
            }
            _attestBtn.visible = true;
         }
         else if(_attestBtn != null)
         {
            _attestBtn.visible = false;
         }
      }
      
      private function updateTextPos() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 21)
         {
            _textLableBg.setFrame(2);
            _fightPowerTxt.visible = true;
            _winProbabilityTxt.visible = true;
            _guildNameTxt.visible = true;
            _graduatesCountTxt.visible = false;
            _honourOfMasterTxt.visible = false;
            PositionUtils.setPos(_fightPowerTxt,"academy.view.AcademyView.text1pos");
            PositionUtils.setPos(_winProbabilityTxt,"academy.view.AcademyView.text2pos");
            PositionUtils.setPos(_guildNameTxt,"academy.view.AcademyView.text3pos");
         }
         else
         {
            _textLableBg.setFrame(1);
            _fightPowerTxt.visible = true;
            _winProbabilityTxt.visible = true;
            _guildNameTxt.visible = true;
            _graduatesCountTxt.visible = true;
            _honourOfMasterTxt.visible = true;
            PositionUtils.setPos(_textLableBg,"academy.view.AcademyView.textLablepos");
            PositionUtils.setPos(_fightPowerTxt,"academy.view.AcademyView.text4pos");
            PositionUtils.setPos(_winProbabilityTxt,"academy.view.AcademyView.text5pos");
            PositionUtils.setPos(_guildNameTxt,"academy.view.AcademyView.text6pos");
         }
      }
      
      private function getCourtshipBtnEnable() : Boolean
      {
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         if(_info && _info.info && (_loc1_.SpouseID <= 0 && _info.info.SpouseID <= 0 && _info.info.Sex != _loc1_.Sex) && _info.info.playerState.StateID == 1)
         {
            return true;
         }
         return false;
      }
      
      private function updateIcon() : void
      {
         var _loc1_:PlayerInfo = _info.info;
         _levelIcon.setInfo(_loc1_.Grade,_loc1_.ddtKingGrade,_loc1_.Repute,_loc1_.WinCount,_loc1_.TotalCount,_loc1_.FightPower,_loc1_.Offer,true,false);
         _levelIcon.visible = true;
         if(_vipIcon == null && _loc1_.IsVIP)
         {
            _vipIcon = ComponentFactory.Instance.creatCustomObject("academy.playerPanel.VipIcon");
            addChild(_vipIcon);
            _vipIcon.setInfo(_loc1_);
         }
         else if(_vipIcon && !_loc1_.IsVIP)
         {
            _vipIcon.dispose();
            _vipIcon = null;
         }
         if(_loc1_.SpouseID > 0)
         {
            if(_marriedIcon == null)
            {
               _marriedIcon = ComponentFactory.Instance.creatCustomObject("academy.playerPanel.MarriedIcon");
            }
            _marriedIcon.tipData = {
               "nickName":_loc1_.SpouseName,
               "gender":_loc1_.Sex
            };
            addChild(_marriedIcon);
         }
         else if(_marriedIcon)
         {
            _marriedIcon.dispose();
            _marriedIcon = null;
         }
         if(_vipIcon)
         {
            if(_marriedIcon)
            {
               _marriedIcon.y = _vipIcon.y + _vipIcon.height + 3;
            }
         }
         else if(_marriedIcon)
         {
            _marriedIcon.y = _levelIcon.y + 38;
         }
      }
      
      private function __characterComplete(param1:Event) : void
      {
         _player.removeEventListener("complete",__characterComplete);
         PositionUtils.setPos(_player,"academy.view.AcademyPlayerPanel.playerPos");
         _characteContainer.addChild(_player as DisplayObject);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_leftBg)
         {
            ObjectUtils.disposeObject(_leftBg);
            _leftBg = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_data)
         {
            ObjectUtils.disposeObject(_data);
            _data = null;
         }
         if(_online)
         {
            ObjectUtils.disposeObject(_online);
            _online = null;
         }
         if(_academyTitle && _academyTitle.bitmapData)
         {
            _academyTitle.bitmapData.dispose();
            _academyTitle = null;
         }
         if(_textLableBg)
         {
            ObjectUtils.disposeObject(_textLableBg);
            _textLableBg = null;
         }
         if(_courtshipBtn)
         {
            ObjectUtils.disposeObject(_courtshipBtn);
            _courtshipBtn = null;
         }
         if(_talkBtn)
         {
            ObjectUtils.disposeObject(_talkBtn);
            _talkBtn = null;
         }
         if(_equipBtn)
         {
            ObjectUtils.disposeObject(_equipBtn);
            _equipBtn = null;
         }
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
            _addBtn = null;
         }
         if(_requestMasterBtn)
         {
            ObjectUtils.disposeObject(_requestMasterBtn);
            _requestMasterBtn = null;
         }
         if(_requestApprenticeBtn)
         {
            ObjectUtils.disposeObject(_requestApprenticeBtn);
            _requestApprenticeBtn = null;
         }
         if(_playerNameTxt)
         {
            ObjectUtils.disposeObject(_playerNameTxt);
            _playerNameTxt = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = null;
         }
         if(_guildNameTxt)
         {
            ObjectUtils.disposeObject(_guildNameTxt);
            _guildNameTxt = null;
         }
         if(_graduatesCountTxt)
         {
            ObjectUtils.disposeObject(_graduatesCountTxt);
            _graduatesCountTxt = null;
         }
         if(_honourOfMasterTxt)
         {
            ObjectUtils.disposeObject(_honourOfMasterTxt);
            _honourOfMasterTxt = null;
         }
         if(_fightPowerTxt)
         {
            ObjectUtils.disposeObject(_fightPowerTxt);
            _fightPowerTxt = null;
         }
         if(_winProbabilityTxt)
         {
            ObjectUtils.disposeObject(_winProbabilityTxt);
            _winProbabilityTxt = null;
         }
         if(_introductionTxt)
         {
            ObjectUtils.disposeObject(_introductionTxt);
            _introductionTxt = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_vipIcon)
         {
            _vipIcon.dispose();
            _vipIcon = null;
         }
         if(_marriedIcon)
         {
            _marriedIcon.dispose();
            _marriedIcon = null;
         }
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(_characteContainer && _characteContainer.parent)
         {
            _characteContainer.parent.removeChild(_characteContainer);
            _characteContainer = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
