package gameCommon.view.playerThumbnail
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.BitmapManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.LevelTipInfo;
   import ddt.view.tips.MarriedTip;
   import ddt.view.tips.PetTip;
   import ddt.view.tips.TeamTip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import room.RoomManager;
   import trainer.view.NewHandContainer;
   
   [Event(name="playerThumbnailEvent",type="flash.events.Event")]
   public class PlayerThumbnail extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _info:Player;
      
      private var _headFigure:HeadFigure;
      
      private var _blood:BloodItem;
      
      private var _bg:Bitmap;
      
      private var _fore:Bitmap;
      
      private var _shiner:IEffect;
      
      private var _selectShiner:IEffect;
      
      private var _digitalbg:Bitmap;
      
      private var _smallPlayerFP:FilterFrameText;
      
      private var lightingFilter:BitmapFilter;
      
      private var _marryTip:MarriedTip;
      
      private var _dirct:int;
      
      private var _vip:DisplayObject;
      
      private var _bitmapMgr:BitmapManager;
      
      private var _routeBtn:BaseButton;
      
      private var _effectTarget:Shape;
      
      private var _petTip:PetTip;
      
      private var _hpPercentTxt:FilterFrameText;
      
      private var _trusteeshipIcon:ScaleBitmapImage;
      
      private var _waitingIcon:Bitmap;
      
      private var _actionIcon:Bitmap;
      
      private var _flagBattleBg:Bitmap;
      
      private var _escapeBattleBg:Bitmap;
      
      private var _waitRevive:Bitmap;
      
      private var _flagCount:NumberImage;
      
      private var _teamTip:TeamTip;
      
      private var _levelTipInfo:LevelTipInfo;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      public function PlayerThumbnail(param1:Player, param2:int)
      {
         super();
         _info = param1;
         _dirct = param2;
         init();
         initEvents();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.back");
         addChild(_bg);
         _effectTarget = new Shape();
         addChild(_effectTarget);
         PositionUtils.setPos(_effectTarget,"asset.game.smallplayer.effectPos");
         _headFigure = new HeadFigure(36,36,_info);
         _headFigure.y = 3;
         addChild(_headFigure);
         _blood = new BloodItem(_info.blood,_info.maxBlood);
         _blood.y = 43;
         addChild(_blood);
         _fore = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.fore");
         var _loc2_:int = 1;
         _fore.y = _loc2_;
         _fore.x = _loc2_;
         addChild(_fore);
         _digitalbg = ComponentFactory.Instance.creatBitmap("asset.game.digitalbg");
         _digitalbg.visible = false;
         addChild(_digitalbg);
         PositionUtils.setPos(_digitalbg,"asset.game.smallplayer.digitalbgPos");
         _smallPlayerFP = ComponentFactory.Instance.creatComponentByStylename("wishView.smallplayerFightPower");
         _smallPlayerFP.visible = false;
         addChild(_smallPlayerFP);
         _routeBtn = ComponentFactory.Instance.creatComponentByStylename("core.thumbnail.selectBtn");
         _routeBtn.visible = false;
         addChild(_routeBtn);
         if(_info.playerInfo.IsVIP)
         {
            _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
            _vip = _bitmapMgr.creatBitmapShape("asset.game.smallplayer.vip");
            addChild(_vip);
         }
         if(RoomManager.Instance.current && RoomManager.Instance.current.type == 19)
         {
            _hpPercentTxt = ComponentFactory.Instance.creatComponentByStylename("game.view.thumbnail.hpPercentTxt");
            _hpPercentTxt.text = int((_info.blood < 0?0:Number(_info.blood)) * 100 / _info.maxBlood) + "%";
            addChild(_hpPercentTxt);
         }
         if(_dirct == -1)
         {
            _headFigure.scaleX = -_headFigure.scaleX;
            _headFigure.x = 42;
            if(_vip)
            {
               PositionUtils.setPos(_vip,"asset.game.smallplayer.vipPos1");
            }
         }
         else
         {
            _headFigure.x = 4;
            if(_vip)
            {
               PositionUtils.setPos(_vip,"asset.game.smallplayer.vipPos2");
            }
         }
         _shiner = EffectManager.Instance.creatEffect(1,this,"asset.gameII.thumbnailShineAsset");
         _selectShiner = EffectManager.Instance.creatEffect(1,_effectTarget,"asset.gameIII.thumbnailShineSelect");
         if(_info.playerInfo.SpouseName)
         {
            _marryTip = new MarriedTip();
            _marryTip.tipData = {
               "nickName":_info.playerInfo.SpouseName,
               "gender":_info.playerInfo.Sex
            };
         }
         var _loc1_:PetInfo = _info.playerInfo.currentPet;
         if(_loc1_)
         {
            _petTip = ComponentFactory.Instance.creatComponentByStylename("core.PetTip");
            _petTip.tipData = {
               "petName":_loc1_.Name,
               "petLevel":_loc1_.Level,
               "petIconUrl":PetsBagManager.instance().getPicStrByLv(_loc1_)
            };
         }
         _trusteeshipIcon = ComponentFactory.Instance.creatComponentByStylename("game.smallplayer.trusteeship");
         _waitingIcon = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.waitingStatus");
         _waitingIcon.visible = false;
         _actionIcon = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.actionStatus");
         _actionIcon.visible = false;
         if(_info.playerInfo && _info.playerInfo.Grade >= 26)
         {
            _teamTip = ComponentFactory.Instance.creatComponentByStylename("core.TeamTip");
            _teamTip.tipData = _info.playerInfo;
         }
         addChild(_waitingIcon);
         addChild(_actionIcon);
         if(RoomManager.Instance.current && GameControl.Instance.Current.togetherShoot)
         {
            __fightStatusChange(null);
         }
         createLevelTip();
         buttonMode = true;
         setUpLintingFilter();
         updateFlagNum();
      }
      
      public function getInfo() : Player
      {
         return _info;
      }
      
      public function get info() : PlayerInfo
      {
         return _info.playerInfo;
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      private function createLevelTip() : void
      {
         tipStyle = "core.SmallPlayerTips";
         tipDirctions = "7";
         tipGapV = 10;
         tipGapH = 10;
         var _loc1_:LevelTipInfo = new LevelTipInfo();
         _loc1_.enableTip = true;
         _loc1_.Battle = _info.playerInfo.FightPower;
         _loc1_.ddtKingGraed = _info.playerInfo.ddtKingGrade;
         _loc1_.Level = _info.playerInfo.Grade;
         _loc1_.Repute = _info.playerInfo.Repute;
         _loc1_.Total = _info.playerInfo.TotalCount;
         _loc1_.Win = _info.playerInfo.WinCount;
         _loc1_.exploit = _info.playerInfo.Offer;
         _loc1_.team = _info.team;
         _loc1_.nickName = _info.playerInfo.NickName;
         tipData = _loc1_;
         ShowTipManager.Instance.addTip(this);
      }
      
      protected function overHandler(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         this.filters = [lightingFilter];
         if(_marryTip)
         {
            _marryTip.visible = true;
            LayerManager.Instance.addToLayer(_marryTip,3);
            _loc4_ = ShowTipManager.Instance.getTipInstanceByStylename(tipStyle);
            _marryTip.x = _loc4_.x;
            _marryTip.y = _loc4_.y + _loc4_.height;
         }
         if(_petTip)
         {
            _petTip.visible = true;
            LayerManager.Instance.addToLayer(_petTip,3);
            _loc3_ = ShowTipManager.Instance.getTipInstanceByStylename(tipStyle);
            _petTip.x = _loc3_.x + _loc3_.width;
            _petTip.y = _loc3_.y;
         }
         if(_teamTip)
         {
            _teamTip.visible = true;
            LayerManager.Instance.addToLayer(_teamTip,3);
            if(_marryTip)
            {
               _teamTip.x = _marryTip.x;
               _teamTip.y = _marryTip.y + _marryTip.height;
            }
            else
            {
               _loc2_ = ShowTipManager.Instance.getTipInstanceByStylename(tipStyle);
               _teamTip.x = _loc2_.x;
               _teamTip.y = _loc2_.y + _loc2_.height;
            }
         }
      }
      
      protected function outHandler(param1:MouseEvent) : void
      {
         this.filters = null;
         if(_marryTip)
         {
            _marryTip.visible = false;
         }
         if(_petTip)
         {
            _petTip.visible = false;
         }
         if(_teamTip)
         {
            _teamTip.visible = false;
         }
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         removeTipTemp();
         dispatchEvent(new Event("playerThumbnailEvent"));
      }
      
      private function removeTipTemp() : void
      {
         if(_marryTip)
         {
            _marryTip.visible = false;
         }
         if(_petTip)
         {
            _petTip.visible = false;
         }
         if(_teamTip)
         {
            _teamTip.visible = false;
         }
         ShowTipManager.Instance.removeTip(this);
         removeEventListener("rollOver",overHandler);
         removeEventListener("rollOut",outHandler);
      }
      
      public function recoverTip() : void
      {
         SoundManager.instance.play("008");
         ShowTipManager.Instance.addTip(this);
         addEventListener("rollOver",overHandler);
         addEventListener("rollOut",outHandler);
      }
      
      private function initEvents() : void
      {
         _info.addEventListener("bloodChanged",__updateBlood);
         _info.addEventListener("die",__die);
         _info.addEventListener("livingRevive",__revive);
         _info.addEventListener("attackingChanged",__shineChange);
         _info.addEventListener("fightPowerChange",__setSmallFP);
         _info.addEventListener("wishSelectChange",__setShiner);
         _info.addEventListener("updateFlagNum",__onUpdateFlagNum);
         _info.addEventListener("updateFeignDeathState",__onUpdateState);
         if(!isShowTrusteeship())
         {
         }
         _info.playerInfo.addEventListener("gameFightStatusChange",__fightStatusChange);
         _routeBtn.addEventListener("click",__routeLine);
         SocketManager.Instance.addEventListener("playerChange",__playerChange);
         addEventListener("rollOver",overHandler);
         addEventListener("rollOut",outHandler);
         addEventListener("click",clickHandler);
      }
      
      private function isShowTrusteeship() : Boolean
      {
         if(RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 12 || RoomManager.Instance.current.type == 13 || RoomManager.Instance.current.type == 12 || RoomManager.Instance.current.type == 25 || RoomManager.Instance.current.type == 0 || RoomManager.Instance.current.type == 1 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 123)
         {
            return true;
         }
         return false;
      }
      
      private function __playerChange(param1:CrazyTankSocketEvent) : void
      {
         _routeBtn.visible = false;
         _smallPlayerFP.visible = false;
         _digitalbg.visible = false;
         _selectShiner.stop();
      }
      
      private function __routeLine(param1:MouseEvent) : void
      {
         dispatchEvent(new GameEvent("wishSelect",_info.LivingID));
      }
      
      private function setUpLintingFilter() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,25]);
         _loc1_ = _loc1_.concat([0,1,0,0,25]);
         _loc1_ = _loc1_.concat([0,0,1,0,25]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(_loc1_);
      }
      
      private function __setSmallFP(param1:LivingEvent) : void
      {
         if(_info.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            _routeBtn.visible = true;
         }
         if(_info.fightPower < 100 && _info.fightPower > 0)
         {
            _smallPlayerFP.text = String(_info.fightPower);
            _smallPlayerFP.visible = true;
            _digitalbg.visible = true;
         }
         else
         {
            _smallPlayerFP.text = "";
            _digitalbg.visible = false;
            _smallPlayerFP.visible = false;
         }
      }
      
      private function __setShiner(param1:LivingEvent) : void
      {
         if(_info.currentSelectId == _info.LivingID)
         {
            _selectShiner.play();
         }
         else
         {
            _selectShiner.stop();
         }
      }
      
      private function __shineChange(param1:LivingEvent) : void
      {
         if(_info && _info.isAttacking)
         {
            _shiner.play();
         }
         else
         {
            _shiner.stop();
         }
      }
      
      private function __trusteeshipChange(param1:GameEvent) : void
      {
         if(_trusteeshipIcon == null)
         {
            return;
         }
         var _loc2_:Boolean = param1.data as Boolean;
         if(_loc2_)
         {
            addChild(_trusteeshipIcon);
         }
         else if(this.contains(_trusteeshipIcon))
         {
            removeChild(_trusteeshipIcon);
         }
         if(RoomManager.Instance.current && GameControl.Instance.Current.togetherShoot)
         {
            __fightStatusChange(null);
         }
      }
      
      private function __fightStatusChange(param1:GameEvent) : void
      {
         if(!_waitingIcon || !_actionIcon)
         {
            return;
         }
         if(_info.playerInfo.isTrusteeship)
         {
            _waitingIcon.visible = false;
            _actionIcon.visible = false;
         }
         else if(_info.playerInfo.fightStatus == 0)
         {
            _waitingIcon.visible = true;
            _actionIcon.visible = false;
         }
         else
         {
            _waitingIcon.visible = false;
            _actionIcon.visible = true;
         }
      }
      
      private function __onUpdateFlagNum(param1:LivingEvent) : void
      {
         updateFlagNum();
      }
      
      private function updateFlagNum() : void
      {
         if(GameControl.Instance.Current.gameMode == 57)
         {
            if(_flagBattleBg == null)
            {
               _flagBattleBg = ComponentFactory.Instance.creatBitmap("asset.game.flagBattle.headBg");
               addChild(_flagBattleBg);
            }
            if(_flagCount == null)
            {
               _flagCount = ComponentFactory.Instance.creatComponentByStylename("game.flagBattle.flagNum");
               addChild(_flagCount);
            }
            _flagCount.count = _info.flagNum;
         }
      }
      
      private function __onUpdateState(param1:LivingEvent) : void
      {
         if(_info.isFeignDeath)
         {
            if(GameControl.Instance.Current.gameMode == 57)
            {
               if(_waitRevive == null)
               {
                  _waitRevive = ComponentFactory.Instance.creatBitmap("asset.game.flagBattle.waitRevive");
                  addChild(_waitRevive);
               }
               _waitRevive.visible = true;
            }
            else if(GameControl.Instance.Current.gameMode == 56)
            {
               if(_escapeBattleBg == null)
               {
                  _escapeBattleBg = ComponentFactory.Instance.creatBitmap("asset.game.escapeBattle.headBg");
                  addChild(_escapeBattleBg);
               }
               _escapeBattleBg.visible = true;
            }
            if(_info.isSelf)
            {
               createArrow();
            }
         }
         else
         {
            if(_waitRevive)
            {
               _waitRevive.visible = false;
            }
            if(_escapeBattleBg)
            {
               _escapeBattleBg.visible = false;
            }
            clearArrow();
         }
      }
      
      private function createArrow() : void
      {
         var _loc1_:int = 100000 + _info.LivingID;
         NewHandContainer.Instance.showArrow(_loc1_,180,new Point(25,145),"","",this,0,true);
      }
      
      private function clearArrow() : void
      {
         var _loc1_:int = 100000 + _info.LivingID;
         NewHandContainer.Instance.clearArrowByID(_loc1_);
      }
      
      override public function set x(param1:Number) : void
      {
         .super.x = param1;
         __shineChange(null);
      }
      
      override public function set y(param1:Number) : void
      {
         .super.y = param1;
         __shineChange(null);
      }
      
      private function __die(param1:LivingEvent) : void
      {
         if(_headFigure)
         {
            _headFigure.gray();
         }
         if(_blood && _blood.parent)
         {
            _blood.parent.removeChild(_blood);
         }
         if(_waitingIcon)
         {
            _waitingIcon.alpha = 0;
         }
         if(_actionIcon)
         {
            _actionIcon.alpha = 0;
         }
      }
      
      private function __revive(param1:LivingEvent) : void
      {
         if(_headFigure)
         {
            _headFigure.reset();
         }
         if(_blood)
         {
            addChild(_blood);
         }
         if(_waitingIcon)
         {
            _waitingIcon.alpha = 1;
         }
         if(_actionIcon)
         {
            _actionIcon.alpha = 1;
         }
      }
      
      private function removeEvents() : void
      {
         if(_info)
         {
            _info.removeEventListener("fightPowerChange",__setSmallFP);
            _info.removeEventListener("bloodChanged",__updateBlood);
            _info.removeEventListener("die",__die);
            _info.removeEventListener("livingRevive",__revive);
            _info.removeEventListener("attackingChanged",__shineChange);
            _info.removeEventListener("wishSelectChange",__setShiner);
            _info.removeEventListener("updateFlagNum",__onUpdateFlagNum);
            _info.removeEventListener("updateFeignDeathState",__onUpdateState);
            if(_info.playerInfo != null)
            {
            }
            _info.playerInfo.removeEventListener("gameFightStatusChange",__fightStatusChange);
         }
         SocketManager.Instance.removeEventListener("playerChange",__playerChange);
         removeEventListener("rollOver",overHandler);
         removeEventListener("rollOut",outHandler);
         removeEventListener("click",clickHandler);
         _routeBtn.removeEventListener("click",__routeLine);
      }
      
      private function __updateBlood(param1:LivingEvent) : void
      {
         _blood.setProgress(_info.blood,_info.maxBlood);
         if(_hpPercentTxt)
         {
            _hpPercentTxt.text = int((_info.blood < 0?0:Number(_info.blood)) * 100 / _info.maxBlood) + "%";
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         clearArrow();
         ShowTipManager.Instance.removeTip(this);
         EffectManager.Instance.removeEffect(_shiner);
         _shiner = null;
         EffectManager.Instance.removeEffect(_selectShiner);
         _selectShiner = null;
         ObjectUtils.disposeObject(_marryTip);
         _marryTip = null;
         ObjectUtils.disposeObject(_petTip);
         _petTip = null;
         ObjectUtils.disposeObject(_teamTip);
         _teamTip = null;
         ObjectUtils.disposeObject(_headFigure);
         _headFigure = null;
         ObjectUtils.disposeObject(_blood);
         _blood = null;
         ObjectUtils.disposeObject(_trusteeshipIcon);
         _trusteeshipIcon = null;
         ObjectUtils.disposeObject(_effectTarget);
         _effectTarget = null;
         ObjectUtils.disposeObject(_vip);
         _vip = null;
         ObjectUtils.disposeObject(_bitmapMgr);
         _bitmapMgr = null;
         ObjectUtils.disposeObject(_hpPercentTxt);
         _hpPercentTxt = null;
         ObjectUtils.disposeObject(_flagBattleBg);
         _flagBattleBg = null;
         ObjectUtils.disposeObject(_escapeBattleBg);
         _escapeBattleBg = null;
         ObjectUtils.disposeObject(_waitRevive);
         _waitRevive = null;
         ObjectUtils.disposeObject(_flagCount);
         _flagCount = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_fore);
         _fore = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         return _levelTipInfo;
      }
      
      public function set tipData(param1:Object) : void
      {
         _levelTipInfo = param1 as LevelTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
