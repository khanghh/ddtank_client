package ringStation.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ringStation.event.RingStationEvent;
   import road7th.comm.PackageIn;
   
   public class StationUserView extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _userInfoBg:Bitmap;
      
      private var _countDownBg:Bitmap;
      
      private var _awardIcon:Bitmap;
      
      private var _countDownSprite:Sprite;
      
      private var _rankInfo:FilterFrameText;
      
      private var _rankNum:FilterFrameText;
      
      private var _challengeInfo:FilterFrameText;
      
      private var _challengeTime:FilterFrameText;
      
      private var _challengeTimeNum:FilterFrameText;
      
      private var _rankAwardInfo:FilterFrameText;
      
      private var _getAwardTimeInfo:FilterFrameText;
      
      private var _getAwardTime:FilterFrameText;
      
      private var _getAwardNum:FilterFrameText;
      
      private var _champion:FilterFrameText;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _addChallengeBtn:BaseButton;
      
      private var _fastForwardBtn:BaseButton;
      
      private var _battleFieldsBtn:BaseButton;
      
      private var _heroStandingsBtn:BaseButton;
      
      private var _player:ICharacter;
      
      private var _armoryView:ArmoryView;
      
      private var _battleFieldsView:BattleFieldsView;
      
      private var _rewardBtn:SimpleBitmapButton;
      
      private var _buyCount:int;
      
      private var _buyPrice:int;
      
      private var _cdPrice:int;
      
      private var _countDownTime:Number;
      
      private var _timer:Timer;
      
      private var _timeFlag:Boolean;
      
      private var signBG:Bitmap;
      
      private var signText:FilterFrameText;
      
      private var signBnt:BaseButton;
      
      private var signChampionText:FilterFrameText;
      
      private var _signInputFrame:RingStationSingInputFrame;
      
      public function StationUserView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("ringStation.view.userBg");
         addChild(_bg);
         _userInfoBg = ComponentFactory.Instance.creat("ringStation.view.userInfoBg");
         addChild(_userInfoBg);
         _countDownSprite = new Sprite();
         _countDownSprite.visible = false;
         addChild(_countDownSprite);
         PositionUtils.setPos(_countDownSprite,"ringStation.view.countDownPos");
         _countDownBg = ComponentFactory.Instance.creat("ringStation.view.countdownBg");
         _countDownSprite.addChild(_countDownBg);
         _challengeTime = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.challengeTime");
         _challengeTime.text = LanguageMgr.GetTranslation("ringStation.view.challengeTimeText");
         _countDownSprite.addChild(_challengeTime);
         _challengeTimeNum = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.challengeTimeNum");
         _countDownSprite.addChild(_challengeTimeNum);
         _fastForwardBtn = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.fastforwardBtn");
         _fastForwardBtn.tipData = LanguageMgr.GetTranslation("ringStation.view.countDownTipText");
         _countDownSprite.addChild(_fastForwardBtn);
         _rankInfo = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.rankInfo");
         _rankInfo.text = LanguageMgr.GetTranslation("ddt.ringstation.rankInfoText");
         addChild(_rankInfo);
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.rankNum");
         addChild(_rankNum);
         _champion = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.champion");
         addChild(_champion);
         _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
         addChild(_attestBtn);
         _attestBtn.visible = false;
         _challengeInfo = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.challengeInfo");
         addChild(_challengeInfo);
         _addChallengeBtn = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.addChallegeCountBtn");
         _addChallengeBtn.tipData = LanguageMgr.GetTranslation("ringStation.view.buyCountTipText");
         addChild(_addChallengeBtn);
         _rankAwardInfo = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.rankAwardInfo");
         _rankAwardInfo.text = LanguageMgr.GetTranslation("ringStation.view.rankAwardInfoText");
         addChild(_rankAwardInfo);
         _getAwardTimeInfo = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.getAwardTimeInfo");
         _getAwardTimeInfo.text = LanguageMgr.GetTranslation("ringStation.view.getAwardTimeInfoText");
         addChild(_getAwardTimeInfo);
         _getAwardTime = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.getAwardTime");
         addChild(_getAwardTime);
         _getAwardNum = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.getAwardNum");
         addChild(_getAwardNum);
         _awardIcon = ComponentFactory.Instance.creat("ringStation.view.awardIcon");
         addChild(_awardIcon);
         _battleFieldsBtn = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.balltleFieldsBtn");
         addChild(_battleFieldsBtn);
         _heroStandingsBtn = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.heroStandingsBtn");
         addChild(_heroStandingsBtn);
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.getRewardBtn");
         addChild(_rewardBtn);
         _player = CharactoryFactory.createCharacter(PlayerManager.Instance.Self,"room");
         _player.showGun = true;
         _player.show(false,-1);
         _player.setShowLight(true);
         PositionUtils.setPos(_player,"ringStation.view.playerPos");
         addChild(_player as DisplayObject);
         addSignCell();
      }
      
      private function addSignCell() : void
      {
         signBG = ComponentFactory.Instance.creat("ringStation.view.signBG");
         signText = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.signText");
         signBnt = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.signBnt");
         signChampionText = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.signText2");
         addChild(signBG);
         addChild(signText);
         addChild(signBnt);
         addChild(signChampionText);
      }
      
      private function initEvent() : void
      {
         _addChallengeBtn.addEventListener("click",__onBuyCount);
         _fastForwardBtn.addEventListener("click",__onBuyTime);
         _battleFieldsBtn.addEventListener("click",__onBattleFieldsHandle);
         _heroStandingsBtn.addEventListener("click",__onArmoryHandle);
         signBnt.addEventListener("click",__signClick);
         _rewardBtn.addEventListener("click",__onGetRewardClickHandle);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,2),__buyCountOrTime);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,8),__onGetReward);
      }
      
      protected function __onGetReward(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc4_:Boolean = _loc5_.readBoolean();
         if(_loc4_)
         {
            _loc3_ = _loc5_.readInt();
            _loc2_ = _loc5_.readInt();
         }
         var _loc6_:String = !!_loc4_?LanguageMgr.GetTranslation("ringStation.view.getReward.success",_loc3_,_loc2_):LanguageMgr.GetTranslation("ringStation.view.getReward.failed");
         MessageTipManager.getInstance().show(_loc6_);
         ChatManager.Instance.sysChatYellow(_loc6_);
         setReardEnable(false);
      }
      
      protected function __onGetRewardClickHandle(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         setReardEnable(false);
         SocketManager.Instance.out.sendGetRingStationReward();
      }
      
      public function setReardEnable(param1:Boolean) : void
      {
         if(_rewardBtn != null)
         {
            _rewardBtn.enable = param1;
         }
      }
      
      private function __signClick(param1:MouseEvent) : void
      {
         if(_signInputFrame == null)
         {
            _signInputFrame = ComponentFactory.Instance.creatComponentByStylename("ringStation.RingStationSingInputFrame");
         }
         LayerManager.Instance.addToLayer(_signInputFrame,3,true,2);
         _signInputFrame.addEventListener("ringStation_sign",__updateSign);
      }
      
      private function __updateSign(param1:RingStationEvent) : void
      {
         signText.text = param1.sign;
      }
      
      public function setRankNum(param1:int) : void
      {
         _rankNum.text = param1.toString();
      }
      
      public function setChampionText(param1:String, param2:Boolean) : void
      {
         if(param1.length > 0)
         {
            _champion.text = LanguageMgr.GetTranslation("ringstation.view.ChampionName",param1);
            if(param2)
            {
               _attestBtn.visible = true;
               _attestBtn.x = _champion.x + _champion.width;
               _attestBtn.y = _champion.y;
            }
            else
            {
               _attestBtn.visible = false;
            }
         }
      }
      
      public function setSignText(param1:String) : void
      {
         if(param1.length > 0)
         {
            signText.text = param1;
         }
         else
         {
            signText.text = LanguageMgr.GetTranslation("ringstation.view.signNormal");
         }
      }
      
      public function setChallengeNum(param1:int) : void
      {
         _challengeInfo.text = LanguageMgr.GetTranslation("ringStation.view.challengeInfoText",param1);
         _addChallengeBtn.x = _challengeInfo.x + _challengeInfo.width + 3;
      }
      
      public function setChallengeTime(param1:Date) : void
      {
         _countDownTime = param1.time - TimeManager.Instance.Now().time;
         if(_countDownTime < 0)
         {
            _countDownSprite.visible = false;
            _challengeTimeNum.text = "00:00";
         }
         else
         {
            _countDownSprite.visible = true;
            _countDownTime = _countDownTime / 1000;
            _challengeTimeNum.text = transSecond(_countDownTime);
            if(!_timer)
            {
               _timer = new Timer(1000);
               _timer.addEventListener("timer",__onTimer);
            }
            _timer.start();
         }
      }
      
      protected function __onTimer(param1:TimerEvent) : void
      {
         _countDownTime = Number(_countDownTime) - 1;
         if(_countDownTime < 0)
         {
            if(_countDownSprite)
            {
               _countDownSprite.visible = false;
            }
            _timer.stop();
            _timer.reset();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
            SocketManager.Instance.out.sendRingStationFightFlag();
         }
         else if(_challengeTimeNum)
         {
            _challengeTimeNum.text = transSecond(_countDownTime);
         }
      }
      
      public function setAwardNum(param1:int) : void
      {
         _getAwardNum.text = param1.toString();
      }
      
      public function setAwardTime(param1:Date) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = TimeManager.Instance.Now().time;
         var _loc4_:Number = (param1.time - _loc3_) / 3600000;
         if(_loc4_ < 0)
         {
            _getAwardTime.text = LanguageMgr.GetTranslation("ringStation.view.getAwardTimeText3");
         }
         else if(_loc4_ < 1)
         {
            _getAwardTime.text = LanguageMgr.GetTranslation("ringStation.view.getAwardTimeText4");
         }
         else if(_loc4_ < 24)
         {
            _getAwardTime.text = LanguageMgr.GetTranslation("ringStation.view.getAwardTimeText2",int(_loc4_));
         }
         else
         {
            _loc2_ = _loc4_ / 24;
            _getAwardTime.text = LanguageMgr.GetTranslation("ringStation.view.getAwardTimeText1",_loc2_);
         }
      }
      
      protected function __onArmoryHandle(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _armoryView = ComponentFactory.Instance.creatComponentByStylename("ringStation.ArmoryView");
         _armoryView.show();
      }
      
      protected function __onBattleFieldsHandle(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _battleFieldsView = ComponentFactory.Instance.creatComponentByStylename("ringStation.BattleFieldsView");
         _battleFieldsView.show();
      }
      
      protected function __onBuyCount(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _timeFlag = false;
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ringStation.view.buyCount.alertInfo",_buyPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,1);
         _loc2_.addEventListener("response",__alertBuyCountOrTime);
      }
      
      protected function __onBuyTime(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         _timeFlag = true;
         if(_countDownTime > 0)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ringStation.view.buyTime.alertInfo",_cdPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,1);
            _loc2_.addEventListener("response",__alertBuyCountOrTime);
         }
      }
      
      protected function __buyCountOrTime(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(_loc2_)
         {
            if(_loc3_.readBoolean())
            {
               _challengeTimeNum.text = "00:00";
               _timer.stop();
               _timer.reset();
               _countDownSprite.visible = false;
            }
         }
         else
         {
            _buyCount = _loc3_.readInt();
            setChallengeNum(_loc3_.readInt());
         }
      }
      
      protected function __alertBuyCountOrTime(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertBuyCountOrTime);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               if(_loc3_.isBand)
               {
                  if(!checkMoney(true))
                  {
                     _loc3_.dispose();
                     _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
                     _loc2_.addEventListener("response",onResponseHander);
                     return;
                  }
               }
               else if(!checkMoney(false))
               {
                  _loc3_.dispose();
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  return;
               }
               SocketManager.Instance.out.sendBuyBattleCountOrTime(_loc3_.isBand,_timeFlag);
               break;
         }
         _loc3_.dispose();
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onResponseHander);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(!checkMoney(false))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               return;
            }
            SocketManager.Instance.out.sendBuyBattleCountOrTime(false,_timeFlag);
         }
         param1.currentTarget.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function checkMoney(param1:Boolean) : Boolean
      {
         var _loc2_:int = !!_timeFlag?_cdPrice:int(_buyPrice);
         if(param1)
         {
            if(PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               return false;
            }
         }
         else if(PlayerManager.Instance.Self.Money < _loc2_)
         {
            return false;
         }
         return true;
      }
      
      private function transSecond(param1:Number) : String
      {
         return (String("0" + Math.floor(param1 / 60))).substr(-2) + ":" + (String("0" + Math.floor(param1 % 60))).substr(-2);
      }
      
      private function removeEvent() : void
      {
         _addChallengeBtn.removeEventListener("click",__onBuyCount);
         _battleFieldsBtn.removeEventListener("click",__onBattleFieldsHandle);
         _heroStandingsBtn.removeEventListener("click",__onArmoryHandle);
         signBnt.removeEventListener("click",__signClick);
         _rewardBtn.removeEventListener("click",__onGetRewardClickHandle);
         SocketManager.Instance.removeEventListener(PkgEvent.format(404,2),__buyCountOrTime);
         SocketManager.Instance.removeEventListener(PkgEvent.format(404,8),__onGetReward);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_userInfoBg)
         {
            _userInfoBg.bitmapData.dispose();
            _userInfoBg = null;
         }
         if(_awardIcon)
         {
            _awardIcon.bitmapData.dispose();
            _awardIcon = null;
         }
         if(_countDownBg)
         {
            _countDownBg.bitmapData.dispose();
            _countDownBg = null;
         }
         if(_rankInfo)
         {
            _rankInfo.dispose();
            _rankInfo = null;
         }
         if(_rankNum)
         {
            _rankNum.dispose();
            _rankNum = null;
         }
         if(_challengeInfo)
         {
            _challengeInfo.dispose();
            _challengeInfo = null;
         }
         if(_challengeTime)
         {
            _challengeTime.dispose();
            _challengeTime = null;
         }
         if(_challengeTimeNum)
         {
            _challengeTimeNum.dispose();
            _challengeTimeNum = null;
         }
         if(_addChallengeBtn)
         {
            _addChallengeBtn.dispose();
            _addChallengeBtn = null;
         }
         if(_fastForwardBtn)
         {
            _fastForwardBtn.dispose();
            _fastForwardBtn = null;
         }
         if(_battleFieldsBtn)
         {
            _battleFieldsBtn.dispose();
            _battleFieldsBtn = null;
         }
         if(_heroStandingsBtn)
         {
            _heroStandingsBtn.dispose();
            _heroStandingsBtn = null;
         }
         if(_rankAwardInfo)
         {
            _rankAwardInfo.dispose();
            _rankAwardInfo = null;
         }
         if(_getAwardTimeInfo)
         {
            _getAwardTimeInfo.dispose();
            _getAwardTimeInfo = null;
         }
         if(_getAwardTime)
         {
            _getAwardTime.dispose();
            _getAwardTime = null;
         }
         if(_getAwardNum)
         {
            _getAwardNum.dispose();
            _getAwardNum = null;
         }
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         if(_champion)
         {
            _champion.dispose();
            _champion = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(_countDownSprite)
         {
            _countDownSprite = null;
         }
         if(_rewardBtn)
         {
            _rewardBtn.dispose();
            _rewardBtn = null;
         }
         if(signBG)
         {
            signBG.bitmapData.dispose();
            signBG = null;
         }
         if(signBnt)
         {
            signBnt.dispose();
            signBnt = null;
         }
         if(signText)
         {
            signText.dispose();
            signText = null;
         }
         if(signChampionText)
         {
            signChampionText.dispose();
            signChampionText = null;
         }
      }
      
      public function get buyCount() : int
      {
         return _buyCount;
      }
      
      public function set buyCount(param1:int) : void
      {
         _buyCount = param1;
      }
      
      public function get buyPrice() : int
      {
         return _buyPrice;
      }
      
      public function set buyPrice(param1:int) : void
      {
         _buyPrice = param1;
      }
      
      public function get cdPrice() : int
      {
         return _cdPrice;
      }
      
      public function set cdPrice(param1:int) : void
      {
         _cdPrice = param1;
      }
   }
}
