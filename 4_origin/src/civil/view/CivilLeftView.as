package civil.view
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import church.ChurchManager;
   import civil.CivilController;
   import civil.CivilEvent;
   import civil.CivilModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.character.RoomCharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class CivilLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _headBg:Bitmap;
      
      private var _SmallBg1:Bitmap;
      
      private var _SmallBg2:Bitmap;
      
      private var _Introduction:Bitmap;
      
      private var _introBg:MovieClip;
      
      private var _buttonBg:MovieClip;
      
      private var _playerName:FilterFrameText;
      
      private var _guildName:FilterFrameText;
      
      private var _repute:FilterFrameText;
      
      private var _married:FilterFrameText;
      
      private var _player:ICharacter;
      
      private var _sexBg:ScaleFrameImage;
      
      private var _vipName:GradientText;
      
      private var _introductionTxt:TextArea;
      
      private var _info:CivilPlayerInfo;
      
      private var _controller:CivilController;
      
      private var _levelIcon:LevelIcon;
      
      private var _model:CivilModel;
      
      private var _courtshipBtn:TextButton;
      
      private var _talkBtn:TextButton;
      
      private var _equipBtn:TextButton;
      
      private var _addBtn:TextButton;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _guildNameTxt:FilterFrameText;
      
      private var _reputeTxt:FilterFrameText;
      
      private var _marriedTxt:FilterFrameText;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function CivilLeftView(param1:CivilController, param2:CivilModel)
      {
         _controller = param1;
         _model = param2;
         super();
         init();
         initContent();
         initEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
            _addBtn = null;
         }
         if(_courtshipBtn)
         {
            _courtshipBtn.dispose();
         }
         _courtshipBtn = null;
         if(_equipBtn)
         {
            _equipBtn.dispose();
         }
         _equipBtn = null;
         if(_player)
         {
            _player.dispose();
         }
         _player = null;
         if(_levelIcon)
         {
            _levelIcon.dispose();
         }
         _levelIcon = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_headBg)
         {
            ObjectUtils.disposeObject(_headBg);
            _headBg = null;
         }
         if(_sexBg)
         {
            ObjectUtils.disposeObject(_sexBg);
            _sexBg = null;
         }
         if(_playerName)
         {
            ObjectUtils.disposeObject(_playerName);
            _playerName = null;
         }
         if(_guildName)
         {
            ObjectUtils.disposeObject(_guildName);
            _guildName = null;
         }
         if(_repute)
         {
            ObjectUtils.disposeObject(_repute);
            _repute = null;
         }
         if(_married)
         {
            ObjectUtils.disposeObject(_married);
            _married = null;
         }
         if(_introductionTxt)
         {
            ObjectUtils.disposeObject(_introductionTxt);
            _introductionTxt = null;
         }
         if(_talkBtn)
         {
            ObjectUtils.disposeObject(_talkBtn);
            _talkBtn = null;
         }
         if(_playerNameTxt)
         {
            ObjectUtils.disposeObject(_playerNameTxt);
            _playerNameTxt = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(_guildNameTxt)
         {
            ObjectUtils.disposeObject(_guildNameTxt);
            _guildNameTxt = null;
         }
         if(_reputeTxt)
         {
            ObjectUtils.disposeObject(_reputeTxt);
            _reputeTxt = null;
         }
         if(_Introduction)
         {
            ObjectUtils.disposeObject(_Introduction);
            _Introduction = null;
         }
         if(_marriedTxt)
         {
            ObjectUtils.disposeObject(_marriedTxt);
            _marriedTxt = null;
         }
         if(_buttonBg)
         {
            ObjectUtils.disposeObject(_buttonBg);
            _buttonBg = null;
         }
         if(_introBg)
         {
            ObjectUtils.disposeObject(_introBg);
            _introBg = null;
         }
         if(_SmallBg1)
         {
            ObjectUtils.disposeObject(_SmallBg1);
            _SmallBg1 = null;
         }
         if(_SmallBg2)
         {
            ObjectUtils.disposeObject(_SmallBg2);
            _SmallBg2 = null;
         }
         if(_attestBtn)
         {
            ObjectUtils.disposeObject(_attestBtn);
            _attestBtn = null;
         }
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.leftView.bg");
         addChild(_bg);
         _sexBg = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.sexBg");
         addChild(_sexBg);
         _sexBg.visible = false;
         _headBg = ComponentFactory.Instance.creatBitmap("asset.ddtcivil.titleBgAsset");
         addChild(_headBg);
         _SmallBg1 = ComponentFactory.Instance.creatBitmap("asset.ddtcivil.leftSmallBgAsset");
         PositionUtils.setPos(_SmallBg1,"ddtcivil.leftSmallBg1");
         addChild(_SmallBg1);
         _SmallBg2 = ComponentFactory.Instance.creatBitmap("asset.ddtcivil.leftSmallBgAsset");
         PositionUtils.setPos(_SmallBg2,"ddtcivil.leftSmallBg2");
         addChild(_SmallBg2);
         _introBg = ClassUtils.CreatInstance("asset.ddtcivil.LeftIntroBgAsset") as MovieClip;
         PositionUtils.setPos(_introBg,"ddtcivil.IntroBg");
         addChild(_introBg);
         _playerName = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.player");
         _playerName.text = LanguageMgr.GetTranslation("civil.leftview.playerName");
         addChild(_playerName);
         _guildName = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.guild");
         _guildName.text = LanguageMgr.GetTranslation("civil.leftview.guildName");
         addChild(_guildName);
         _repute = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.repute");
         _repute.text = LanguageMgr.GetTranslation("civil.leftview.repute");
         addChild(_repute);
         _married = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.married");
         _married.text = LanguageMgr.GetTranslation("civil.leftview.married");
         addChild(_married);
         _Introduction = ComponentFactory.Instance.creatBitmap("asset.ddtcivil.introducntionAsset");
         addChild(_Introduction);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("ddtcivil.levelIcon");
         addChild(_levelIcon);
         _introductionTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.IntroductionText");
         addChild(_introductionTxt);
         _buttonBg = ClassUtils.CreatInstance("asset.ddtcivil.leftviewButtonBgAsset") as MovieClip;
         PositionUtils.setPos(_buttonBg,"ddtcivil.lefeBtnBg");
         addChild(_buttonBg);
      }
      
      private function initContent() : void
      {
         _courtshipBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.courtshipTxtBtn");
         _talkBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.talkTxtBtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.equipTxtBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.addTxtBtn");
         _playerNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.playerName");
         _guildNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.guildName");
         _reputeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.reputeTxt");
         _marriedTxt = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.marriedTxt");
         _equipBtn.text = LanguageMgr.GetTranslation("civil.leftview.equipName");
         _talkBtn.text = LanguageMgr.GetTranslation("civil.leftview.talkName");
         _addBtn.text = LanguageMgr.GetTranslation("civil.leftview.addName");
         _courtshipBtn.text = LanguageMgr.GetTranslation("civil.leftview.courtshipName");
         addChild(_courtshipBtn);
         addChild(_talkBtn);
         addChild(_equipBtn);
         addChild(_addBtn);
         addChild(_playerNameTxt);
         addChild(_guildNameTxt);
         addChild(_reputeTxt);
         addChild(_marriedTxt);
      }
      
      private function initEvent() : void
      {
         _courtshipBtn.addEventListener("click",__onButtonClick);
         _talkBtn.addEventListener("click",__onButtonClick);
         _equipBtn.addEventListener("click",__onButtonClick);
         _addBtn.addEventListener("click",__onButtonClick);
         _model.addEventListener("selected_change",__updateView);
      }
      
      private function removeEvent() : void
      {
         _courtshipBtn.removeEventListener("click",__onButtonClick);
         _talkBtn.removeEventListener("click",__onButtonClick);
         _equipBtn.removeEventListener("click",__onButtonClick);
         _addBtn.removeEventListener("click",__onButtonClick);
         _model.removeEventListener("selected_change",__updateView);
      }
      
      private function __onButtonClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:CivilPlayerInfo = _controller.currentcivilInfo;
         if(_loc2_ && _loc2_.info)
         {
            var _loc3_:* = param1.currentTarget;
            if(_talkBtn !== _loc3_)
            {
               if(_equipBtn !== _loc3_)
               {
                  if(_addBtn !== _loc3_)
                  {
                     if(_courtshipBtn === _loc3_)
                     {
                        ChurchManager.instance.sendValidateMarry(_loc2_.info);
                     }
                  }
                  else
                  {
                     IMManager.Instance.addFriend(_loc2_.info.NickName);
                  }
               }
               else if(_loc2_.IsPublishEquip)
               {
                  PlayerInfoViewControl.viewByID(_loc2_.info.ID,PlayerManager.Instance.Self.ZoneID);
               }
               else if(_loc2_.MarryInfoID == PlayerManager.Instance.Self.MarryInfoID && PlayerManager.Instance.Self.IsPublishEquit)
               {
                  PlayerInfoViewControl.viewByID(_loc2_.info.ID,PlayerManager.Instance.Self.ZoneID);
               }
            }
            else
            {
               ChatManager.Instance.privateChatTo(_loc2_.info.NickName,_loc2_.info.ID);
            }
         }
      }
      
      private function __updateView(param1:CivilEvent) : void
      {
         if(_model.currentcivilItemInfo)
         {
            if(!_sexBg.visible)
            {
               _sexBg.visible = true;
            }
            _sexBg.setFrame(!!_model.sex?1:2);
            updatePlayerView();
         }
         else
         {
            _levelIcon.visible = false;
            _equipBtn.enable = false;
            _talkBtn.enable = false;
            _courtshipBtn.enable = false;
            _addBtn.enable = false;
            _sexBg.visible = false;
            _playerNameTxt.text = "";
            if(_vipName)
            {
               _vipName.text = "";
               DisplayUtils.removeDisplay(_vipName);
            }
            _guildNameTxt.text = "";
            _reputeTxt.text = "";
            _marriedTxt.text = "";
            _introductionTxt.text = "";
         }
         refreshCharater();
      }
      
      private function updatePlayerView() : void
      {
         var _loc2_:CivilPlayerInfo = _model.currentcivilItemInfo;
         var _loc1_:PlayerInfo = _loc2_.info;
         _playerNameTxt.text = _loc1_.NickName;
         if(_loc1_.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(152,_loc1_.typeVIP);
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
         _guildNameTxt.text = !!_loc1_.ConsortiaName?_loc1_.ConsortiaName:"";
         _reputeTxt.text = String(_loc1_.Repute);
         _marriedTxt.text = !!_loc1_.IsMarried?LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.married"):LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.marry");
         _levelIcon.setInfo(_loc1_.Grade,_loc1_.ddtKingGrade,_loc1_.Repute,_loc1_.WinCount,_loc1_.TotalCount,_loc1_.FightPower,_loc1_.Offer,true,false);
         _levelIcon.visible = true;
         if(_model.currentcivilItemInfo.MarryInfoID == PlayerManager.Instance.Self.MarryInfoID && PlayerManager.Instance.Self.Introduction != null)
         {
            _introductionTxt.text = PlayerManager.Instance.Self.Introduction;
            _equipBtn.enable = PlayerManager.Instance.Self.IsPublishEquit;
         }
         else
         {
            _introductionTxt.text = _loc2_.Introduction;
         }
         if(_model.currentcivilItemInfo.MarryInfoID == PlayerManager.Instance.Self.MarryInfoID || _model.currentcivilItemInfo.info.playerState.StateID == 0)
         {
            _talkBtn.enable = false;
         }
         else
         {
            _talkBtn.enable = true;
         }
         if(_loc2_.info.ID == PlayerManager.Instance.Self.ID)
         {
            _addBtn.enable = false;
            _equipBtn.enable = _model.currentcivilItemInfo.IsPublishEquip;
         }
         else
         {
            _addBtn.enable = true;
            _equipBtn.enable = _model.currentcivilItemInfo.IsPublishEquip;
         }
         _courtshipBtn.enable = getCourtshipBtnEnable();
         creatAttestBtn(_loc1_);
      }
      
      private function creatAttestBtn(param1:PlayerInfo) : void
      {
         if(param1.isAttest)
         {
            if(!_attestBtn)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
            }
            if(param1.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _playerNameTxt.x + _playerNameTxt.width;
               _attestBtn.y = _playerNameTxt.y;
            }
         }
         else if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
      }
      
      private function getCourtshipBtnEnable() : Boolean
      {
         if(PlayerManager.Instance.Self.Sex == _model.currentcivilItemInfo.info.Sex || PlayerManager.Instance.Self.IsMarried || _model.currentcivilItemInfo.info.IsMarried || _model.currentcivilItemInfo.info.playerState.StateID == 0)
         {
            return false;
         }
         return true;
      }
      
      private function refreshCharater() : void
      {
         var _loc1_:* = null;
         _info = _controller.currentcivilInfo;
         if(_info != null)
         {
            _loc1_ = _player;
            _player = CharactoryFactory.createCharacter(_info.info,"room") as RoomCharacter;
            _player.show(true,-1);
            _player.setShowLight(true);
            PositionUtils.setPos(_player,"civil.playerPos");
            addChild(_player as DisplayObject);
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         else if(_player)
         {
            _player.dispose();
            _player = null;
         }
      }
   }
}
