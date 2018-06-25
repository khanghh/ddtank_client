package ringStation.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hall.hallInfo.playerInfo.PlayerFighterPower;
   import ringStation.RingStationControl;
   import vip.VipController;
   
   public class ChallengePerson extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _waiting:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _rank:FilterFrameText;
      
      private var _player:ICharacter;
      
      private var _challengeBtn:MovieImage;
      
      private var _playerInfo:PlayerInfo;
      
      private var _clickDate:Number = 0;
      
      private var _signBG:Bitmap;
      
      private var _signBG2:Bitmap;
      
      private var _signText:FilterFrameText;
      
      private var _maskSprite:Sprite;
      
      private var _playerSprite:Sprite;
      
      private var _fightingBg:Bitmap;
      
      private var _fightPower:PlayerFighterPower;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function ChallengePerson()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("ringStation.view.challengeBg");
         addChild(_bg);
         _levelIcon = new LevelIcon();
         PositionUtils.setPos(_levelIcon,"ringStation.view.player.levelPos");
         addChild(_levelIcon);
         _playerSprite = new Sprite();
         addChild(_playerSprite);
         _signBG2 = ComponentFactory.Instance.creat("ringStation.view.challengeSingBG");
         _signBG2.y = 27;
         _signBG2.alpha = 0.5;
         addChild(_signBG2);
         _nickNameText = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.person.nickNameText");
         addChild(_nickNameText);
         _rank = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.person.rank");
         _fightingBg = ComponentFactory.Instance.creat("ringStation.view.fightingBg");
         _fightPower = new PlayerFighterPower();
         _fightPower.sp.visible = false;
         PositionUtils.setPos(_fightPower,"ringStation.challenge.fightPowerPos");
         _challengeBtn = ComponentFactory.Instance.creat("ringStation.view.player.challengeBtn");
         _challengeBtn.buttonMode = true;
         _challengeBtn.visible = false;
      }
      
      private function creatAttestBtn() : void
      {
         if(_playerInfo.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            addChild(_attestBtn);
            if(_playerInfo.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _nickNameText.x + _nickNameText.width;
               _attestBtn.y = _nickNameText.y;
            }
         }
      }
      
      private function addSignCell() : void
      {
         _signBG = ComponentFactory.Instance.creat("ringStation.view.challengeSingBG");
         _signBG.alpha = 0.5;
         _signText = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.signText2");
         _signText.text = LanguageMgr.GetTranslation("ringstation.view.signNormal");
         addChild(_signBG);
         addChild(_signText);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
         _challengeBtn.addEventListener("click",__onMouseClick);
      }
      
      public function setWaiting() : void
      {
         _waiting = ComponentFactory.Instance.creat("ringStation.view.player.waiting");
         addChild(_waiting);
      }
      
      public function updatePerson(personInfo:PlayerInfo) : void
      {
         _playerInfo = personInfo;
         _levelIcon.setInfo(personInfo.Grade,personInfo.ddtKingGrade,personInfo.Repute,personInfo.WinCount,personInfo.TotalCount,personInfo.FightPower,personInfo.Offer,true,false);
         _nickNameText.text = personInfo.NickName;
         if(personInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(104,personInfo.typeVIP);
            _vipName.textSize = 16;
            _vipName.x = _nickNameText.x;
            _vipName.y = _nickNameText.y - 2;
            _vipName.text = personInfo.NickName;
            addChild(_vipName);
         }
         PositionUtils.adaptNameStyle(personInfo,_nickNameText,_vipName);
         _player = CharactoryFactory.createCharacter(personInfo,"room");
         _player.showGun = true;
         _player.show();
         _player.setShowLight(true);
         PositionUtils.setPos(_player,"ringStation.view.player.playerPos");
         _playerSprite.addChild(_player as DisplayObject);
         addChild(_challengeBtn);
         if(personInfo.Rank == 0)
         {
            _rank.text = LanguageMgr.GetTranslation("ringStation.view.person.noRank");
         }
         else
         {
            _rank.text = LanguageMgr.GetTranslation("ringStation.view.person.rankText",personInfo.Rank);
         }
         addChild(_rank);
         addSignCell();
         var nomal:String = LanguageMgr.GetTranslation("ringstation.view.signNormal");
         if(personInfo.signMsg == "" || personInfo.signMsg == nomal)
         {
            _signText.text = LanguageMgr.GetTranslation("ringstation.view.signNormal");
         }
         else
         {
            _signText.text = personInfo.signMsg;
            if(_signText.text.length > 25)
            {
               _signText.text = _signText.text.substr(0,25) + "...";
            }
         }
         if(_signText.textHeight > _signBG.height)
         {
            _signBG.height = _signText.textHeight + 5;
         }
         _fightPower.setPowerNum(personInfo.FightPower);
         addChild(_fightingBg);
         addChild(_fightPower);
         creatAttestBtn();
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         if(new Date().time - _clickDate > 1000)
         {
            _clickDate = new Date().time;
            SoundManager.instance.playButtonSound();
            RingStationControl.challenge = true;
            SocketManager.Instance.out.sendRingStationChallenge(_playerInfo.ID,_playerInfo.Rank);
         }
      }
      
      protected function __onMouseOver(event:MouseEvent) : void
      {
         _challengeBtn.visible = true;
      }
      
      protected function __onMouseOut(event:MouseEvent) : void
      {
         _challengeBtn.visible = false;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
         _challengeBtn.removeEventListener("click",__onMouseClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_waiting)
         {
            _waiting.bitmapData.dispose();
            _waiting = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_nickNameText)
         {
            _nickNameText.dispose();
            _nickNameText = null;
         }
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         if(_rank)
         {
            _rank.dispose();
            _rank = null;
         }
         if(_fightingBg)
         {
            _fightingBg.bitmapData.dispose();
            _fightingBg = null;
         }
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_challengeBtn)
         {
            _challengeBtn.dispose();
            _challengeBtn = null;
         }
         if(_playerSprite)
         {
            ObjectUtils.disposeAllChildren(_playerSprite);
            ObjectUtils.disposeObject(_playerSprite);
            _playerSprite = null;
         }
         if(_signBG)
         {
            _signBG.bitmapData.dispose();
            _signBG = null;
         }
         if(_signBG2)
         {
            _signBG2.bitmapData.dispose();
            _signBG2 = null;
         }
         if(_signText)
         {
            _signText.dispose();
            _signText = null;
         }
         if(_fightPower)
         {
            _fightPower.dispose();
            _fightPower = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
      }
   }
}
