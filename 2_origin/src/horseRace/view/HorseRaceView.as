package horseRace.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.player.vo.PlayerVO;
   import horseRace.controller.HorseRaceManager;
   import horseRace.data.HorseRacePlayerInfo;
   import horseRace.events.HorseRaceEvents;
   import invite.InviteManager;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import road7th.comm.PackageIn;
   
   public class HorseRaceView extends Sprite implements Disposeable
   {
      
      public static const GAME_WIDTH:int = 1000;
       
      
      private var _backBg:Bitmap;
      
      private var _foreBg:MovieClip;
      
      private var racePlayerList:Array;
      
      private var racePlayerPos:FilterFrameText;
      
      private var racePlayerIntPosArr:Array;
      
      private var moreLen:int = 17;
      
      private var _selfPlayer:HorseRaceWalkPlayer;
      
      private var _playerInfoView:HorseRacePlayerInfoView;
      
      private var _msgView:HorseRaceMsgView;
      
      private var _buffView:HorseRaceBuffView;
      
      private var maxForeMapWidth:int = 40500;
      
      private var maxRaceLen:int = 40000;
      
      private var headLinePosX:int = 250;
      
      private var buffMsgTxt:FilterFrameText;
      
      private var canRanBySpeedToEND:Boolean = false;
      
      private var selfRanBySpeed:Boolean = false;
      
      private var forBgPos:Number;
      
      private var mycount:uint = 0;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var alert:BaseAlerFrame;
      
      private var canKeyDown:Boolean = true;
      
      private var keyShutTimer:Timer;
      
      private var serverTime:int;
      
      private var _first:Boolean = true;
      
      private var _tenCount:int = 0;
      
      private var gameId:int;
      
      public function HorseRaceView()
      {
         racePlayerList = [];
         racePlayerIntPosArr = [];
         super();
         initView();
         initEvent();
         InviteManager.Instance.enabled = false;
      }
      
      private function startCountDown(param1:int) : void
      {
         var _loc2_:HorseRaceStartCountDown = new HorseRaceStartCountDown(param1);
         LayerManager.Instance.addToLayer(_loc2_,2,false,1);
      }
      
      private function endCountDown(param1:int, param2:String, param3:Function) : void
      {
         var _loc4_:HorseRaceStartCountDown = new HorseRaceStartCountDown(param1,param2,param3);
         LayerManager.Instance.addToLayer(_loc4_,2,false,1);
      }
      
      private function initView() : void
      {
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _backBg = ComponentFactory.Instance.creatBitmap("horseRaceView.backBg");
         addChild(_backBg);
         createMap();
         racePlayerPos = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.raceView.Pos");
         var _loc1_:String = racePlayerPos.text;
         racePlayerIntPosArr = getPosArr(_loc1_);
      }
      
      private function addBuffMsg() : void
      {
         buffMsgTxt = ComponentFactory.Instance.creat("asset.hall.playerInfo.lblName");
         buffMsgTxt.mouseEnabled = false;
         PositionUtils.setPos(buffMsgTxt,"horseRace.race.raceView.buffMsgPOS");
         addChild(buffMsgTxt);
         buffMsgTxt.text = "buff描述:~~~~~~~~~~~~~~";
      }
      
      private function createMap() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _foreBg = new MovieClip();
         var _loc2_:int = headLinePosX;
         _loc5_ = 0;
         while(_loc5_ < 40)
         {
            _loc4_ = ComponentFactory.Instance.creat("horseRace.raceView.foB");
            _loc4_.x = _loc2_;
            _loc2_ = _loc2_ + _loc4_.width;
            _foreBg.addChild(_loc4_);
            _loc5_++;
         }
         var _loc1_:Bitmap = ComponentFactory.Instance.creat("horseRace.raceView.forA");
         var _loc3_:Bitmap = ComponentFactory.Instance.creat("horseRace.raceView.forC");
         _foreBg.addChildAt(_loc1_,_foreBg.numChildren);
         _loc3_.x = maxForeMapWidth - _loc3_.width;
         _foreBg.addChildAt(_loc3_,_foreBg.numChildren);
         addChild(_foreBg);
         _foreBg.y = -70;
         _foreBg.height = 674;
      }
      
      private function startRace() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < racePlayerList.length)
         {
            _loc1_ = racePlayerList[_loc2_] as HorseRaceWalkPlayer;
            if(_loc1_.id == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer = _loc1_;
               _selfPlayer.addEventListener("enterFrame",_setSelfCenter);
               _selfPlayer.gameId = gameId;
            }
            else
            {
               _loc1_.addEventListener("enterFrame",_setOtherPlayerWithSelf);
            }
            _loc1_.startRace();
            _loc2_++;
         }
      }
      
      private function _setTimer(param1:Timer) : void
      {
      }
      
      private function _setSelfCenter(param1:Event) : void
      {
         var _loc4_:* = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = _selfPlayer.speed / 25;
         if(_selfPlayer.raceLen >= maxRaceLen)
         {
            _selfPlayer.removeEventListener("enterFrame",_setSelfCenter);
            _selfPlayer.isGetEnd = true;
            _selfPlayer.stopRace();
            _selfPlayer.raceLen = maxRaceLen;
            _selfPlayer.x = 1000 / 2 + _selfPlayer.initPosX;
            endCountDown(6,"end",dispose2);
            return;
         }
         if(_selfPlayer.raceLen + _selfPlayer.initPosX < 1000 / 2)
         {
            _selfPlayer.x = _selfPlayer.raceLen + _selfPlayer.initPosX;
            selfRanBySpeed = true;
         }
         else if(_selfPlayer.raceLen + _selfPlayer.initPosX >= 1000 / 2 && _selfPlayer.raceLen + _selfPlayer.initPosX <= _foreBg.width - 1000 / 2)
         {
            _selfPlayer.x = 1000 / 2;
            selfRanBySpeed = false;
         }
         else if(_selfPlayer.raceLen + _selfPlayer.initPosX > _foreBg.width - 1000 / 2 && _selfPlayer.raceLen + _selfPlayer.initPosX < _foreBg.width - (1000 / 2 - _selfPlayer.initPosX))
         {
            _selfPlayer.x = _selfPlayer.raceLen + _selfPlayer.initPosX - (_foreBg.width - 1000);
            selfRanBySpeed = true;
         }
         else if(_selfPlayer.raceLen + _selfPlayer.initPosX >= _foreBg.width - (1000 / 2 - _selfPlayer.initPosX))
         {
         }
         _loc4_ = Number(1000 / 2 - _selfPlayer.raceLen - _selfPlayer.initPosX);
         if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ <= 1000 - _foreBg.width)
         {
            _loc4_ = Number(1000 - _foreBg.width);
            canRanBySpeedToEND = true;
         }
         if(_loc4_ > 0 && _loc4_ <= 1000 - _foreBg.width)
         {
            selfRanBySpeed = false;
         }
         _foreBg.x = _loc4_;
         forBgPos = _loc4_;
      }
      
      private function _setOtherPlayerWithSelf(param1:Event) : void
      {
         var _loc3_:HorseRaceWalkPlayer = param1.currentTarget as HorseRaceWalkPlayer;
         mycount = Number(mycount) + 1;
         var _loc5_:Number = _loc3_.raceLen - _selfPlayer.raceLen;
         var _loc4_:int = (_loc3_.speed - _selfPlayer.speed) / 25;
         var _loc2_:int = _loc3_.speed / 25;
         if(mycount > 25)
         {
            getRankByRaceLen();
            mycount = 0;
         }
         if(canRanBySpeedToEND)
         {
            if(_loc3_.x < _selfPlayer.x)
            {
               _loc3_.x = _loc3_.x + _loc3_.speed / 25;
               if(_loc3_.x >= _selfPlayer.x)
               {
                  _loc3_.isGetEnd = true;
                  _loc3_.x = _selfPlayer.x;
                  _loc3_.removeEventListener("enterFrame",_setOtherPlayerWithSelf);
                  _loc3_.stopRace();
                  mycount = 0;
               }
            }
            else if(_loc3_.x > _selfPlayer.x)
            {
               _loc3_.x = _loc3_.x + _loc3_.speed / 25;
               if(_loc3_.raceLen >= maxRaceLen)
               {
                  _loc3_.isGetEnd = true;
                  _loc3_.x = 1000 / 2 + _loc3_.initPosX;
                  _loc3_.removeEventListener("enterFrame",_setOtherPlayerWithSelf);
                  _loc3_.stopRace();
                  mycount = 0;
               }
            }
            return;
         }
         if(_loc3_.raceLen >= maxRaceLen)
         {
            _loc3_.raceLen = maxRaceLen;
            _loc3_.isGetEnd = true;
            return;
         }
         _loc3_.x = _selfPlayer.x + _loc5_;
      }
      
      private function getPosArr(param1:String) : Array
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         if(param1 == "" || param1 == null)
         {
            return null;
         }
         var _loc3_:Array = param1.split("|");
         var _loc5_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc9_];
            _loc4_ = _loc2_.split(",");
            _loc8_ = _loc4_[0];
            _loc6_ = _loc4_[1];
            _loc7_ = new Point(_loc8_,_loc6_);
            _loc5_.push(_loc7_);
            _loc9_++;
         }
         return _loc5_;
      }
      
      public function addPlayer(param1:PlayerInfo, param2:int, param3:int) : void
      {
         var _loc5_:* = null;
         var _loc4_:PlayerVO = new PlayerVO();
         _loc4_.playerInfo = param1;
         param1.MountsType = Math.max(1,param1.MountsType);
         param1.PetsID = 0;
         _loc5_ = new HorseRaceWalkPlayer(_loc4_,callBack);
         _loc5_.index = param2;
         _loc5_.rank = param2 + 1;
         _loc5_.speed = param3;
         _loc5_.id = param1.ID;
         if(_loc5_.id == PlayerManager.Instance.Self.ID)
         {
            _loc5_.isSelf = true;
         }
         else
         {
            _loc5_.isSelf = false;
         }
         var _loc6_:Point = racePlayerIntPosArr[param2];
         _loc5_.playerPoint = _loc6_;
         _loc5_.initPosX = _loc6_.x;
         addChild(_loc5_);
         racePlayerList.push(_loc5_);
         _loc5_.stand();
      }
      
      private function removePlayer(param1:int) : void
      {
         var _loc2_:HorseRaceWalkPlayer = racePlayerList[param1] as HorseRaceWalkPlayer;
         _loc2_.stop();
         removeChild(_loc2_);
      }
      
      private function removeAllPlayer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(racePlayerList == null)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < racePlayerList.length)
         {
            _loc1_ = racePlayerList[_loc2_] as HorseRaceWalkPlayer;
            if(_loc1_.id == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer.removeEventListener("enterFrame",_setSelfCenter);
            }
            else
            {
               _loc1_.removeEventListener("enterFrame",_setOtherPlayerWithSelf);
            }
            _loc1_.stop();
            removeChild(_loc1_);
            _loc1_.dispose();
            _loc2_++;
         }
         racePlayerList = null;
      }
      
      private function findPlayerByID(param1:int) : HorseRaceWalkPlayer
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < racePlayerList.length)
         {
            _loc2_ = racePlayerList[_loc3_] as HorseRaceWalkPlayer;
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function callBack(param1:HorseRaceWalkPlayer, param2:Boolean, param3:int) : void
      {
         if(param3 == 0)
         {
            var _loc4_:* = param1.playerVO.scenePlayerDirection;
            param1.sceneCharacterDirection = _loc4_;
            param1.setSceneCharacterDirectionDefault = _loc4_;
            param1.mouseEnabled = false;
            param1.showPlayerTitle();
            param1.sceneCharacterStateType = "natural";
            param1.showPlayerTitle();
            param1.showVipName();
         }
      }
      
      private function initEvent() : void
      {
         HorseRaceManager.Instance.addEventListener("horseRace_initPlayer",_initPlayerInfo);
         HorseRaceManager.Instance.addEventListener("HORSERACE_START_FIVE",_startFiveCountDown);
         HorseRaceManager.Instance.addEventListener("HORSERACE_BEGIN_RACE",_beginRace);
         HorseRaceManager.Instance.addEventListener("HORSERACE_PLAYERSPEED_CHANGE",_speedChange);
         HorseRaceManager.Instance.addEventListener("HORSERACE_RACE_END",_raceEnd);
         HorseRaceManager.Instance.addEventListener("HORSERACE_ALLPLAYER_RACEEND",_allRaceEnd);
         HorseRaceManager.Instance.addEventListener("HORSERACE_SYN_ONESECOND",_synonesecond);
         HorseRaceManager.Instance.addEventListener("HORSERACE_BUFF_ITEMFLUSH",_buffItem_flush);
         HorseRaceManager.Instance.addEventListener("HORSERACE_SHOW_MSG",_show_msg);
         HorseRaceManager.Instance.addEventListener("HORSERACE_USE_PINGZHANG",_use_pingzhang);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         HorseRaceManager.Instance.addEventListener("HORSERACE_USE_DAOJU",_use_daoju);
      }
      
      private function removeEvent() : void
      {
         HorseRaceManager.Instance.removeEventListener("horseRace_initPlayer",_initPlayerInfo);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_START_FIVE",_startFiveCountDown);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_BEGIN_RACE",_beginRace);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_PLAYERSPEED_CHANGE",_speedChange);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_RACE_END",_raceEnd);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_ALLPLAYER_RACEEND",_allRaceEnd);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_SYN_ONESECOND",_synonesecond);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_BUFF_ITEMFLUSH",_buffItem_flush);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_SHOW_MSG",_show_msg);
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_USE_PINGZHANG",_use_pingzhang);
         HorseRaceManager.Instance.removeEventListener("HORSERACE_USE_DAOJU",_use_daoju);
         if(keyShutTimer)
         {
            keyShutTimer.stop();
            keyShutTimer.removeEventListener("timer",_keyShut);
            keyShutTimer = null;
         }
      }
      
      private function _use_pingzhang(param1:HorseRaceEvents) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(HorseRaceManager.Instance.showPingzhangBuyFram)
         {
            _loc3_ = ServerConfigManager.instance.HorseGameUsePapawMoney;
            _loc2_ = LanguageMgr.GetTranslation("horseRace.match.usePingzhangDescription",_loc3_);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn.addEventListener("click",__onClickSelectedBtn);
            alert.addToContent(_selectBtn);
            alert.moveEnable = false;
            alert.addEventListener("response",__onRecoverResponse);
            alert.height = 200;
            _selectBtn.x = 102;
            _selectBtn.y = 67;
         }
         else
         {
            SocketManager.Instance.out.sendHorseRaceItemUse2(_selfPlayer.gameId,_selfPlayer.id);
         }
      }
      
      private function __onRecoverResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = ServerConfigManager.instance.HorseGameUsePapawMoney;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendHorseRaceItemUse2(_selfPlayer.gameId,_selfPlayer.id);
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            HorseRaceManager.Instance.showPingzhangBuyFram = true;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void
      {
         HorseRaceManager.Instance.showPingzhangBuyFram = !_selectBtn.selected;
      }
      
      private function _use_daoju(param1:HorseRaceEvents) : void
      {
         var _loc2_:int = param1.data;
         if(_loc2_ == 1)
         {
            if(_buffView.buffItemType1 != 0)
            {
               SocketManager.Instance.out.sendHorseRaceItemUse(_selfPlayer.gameId,_buffView.buffItemType1,_selfPlayer.id,_playerInfoView.selectItemId);
            }
         }
         else if(_loc2_ == 2)
         {
            if(_buffView.buffItemType2 != 0)
            {
               SocketManager.Instance.out.sendHorseRaceItemUse(_selfPlayer.gameId,_buffView.buffItemType2,_selfPlayer.id,_playerInfoView.selectItemId);
            }
         }
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = param1.keyCode;
         if(KeyStroke.VK_1.getCode() !== _loc2_)
         {
            if(KeyStroke.VK_2.getCode() === _loc2_)
            {
               if(_buffView.buffItemType2 != 0)
               {
                  SocketManager.Instance.out.sendHorseRaceItemUse(_selfPlayer.gameId,_buffView.buffItemType2,_selfPlayer.id,_playerInfoView.selectItemId);
               }
            }
         }
         else if(_buffView.buffItemType1 != 0)
         {
            SocketManager.Instance.out.sendHorseRaceItemUse(_selfPlayer.gameId,_buffView.buffItemType1,_selfPlayer.id,_playerInfoView.selectItemId);
         }
      }
      
      private function _keyShut(param1:TimerEvent) : void
      {
         canKeyDown = true;
      }
      
      private function _show_msg(param1:HorseRaceEvents) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc6_:String = _loc4_.readUTF();
         var _loc3_:String = _loc4_.readUTF();
         var _loc2_:String = _loc4_.readUTF();
         var _loc5_:String = LanguageMgr.GetTranslation("horseRace.raceView.msgTxt",_loc6_,_loc3_,_loc2_);
         _msgView.addMsg(_loc5_);
      }
      
      private function _buffItem_flush(param1:HorseRaceEvents) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc4_:int = _loc3_.readInt();
         var _loc5_:int = _loc3_.readInt();
         _buffView.buffItemType1 = _loc4_;
         _buffView.buffItemType2 = _loc5_;
         var _loc2_:Boolean = _loc3_.readBoolean();
         _buffView.pingzhangUseSuccess = _loc2_;
         if(_loc2_)
         {
            _buffView.showPingzhangDaojishi();
         }
      }
      
      private function _synonesecond(param1:HorseRaceEvents) : void
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc15_:* = null;
         var _loc14_:int = 0;
         var _loc18_:int = 0;
         var _loc17_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc4_:int = 0;
         var _loc16_:* = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc13_:int = _loc5_.readInt();
         _buffView.timeSyn = _loc13_;
         _buffView.flushBuffItem();
         _tenCount = Number(_tenCount) + 1;
         var _loc3_:int = _loc5_.readInt();
         _loc11_ = 0;
         while(_loc11_ < _loc3_)
         {
            _loc12_ = _loc5_.readInt();
            _loc15_ = findPlayerByID(_loc12_);
            _loc5_.readInt();
            _loc14_ = _loc5_.readInt();
            if(_loc14_ != 0)
            {
               _loc15_.rank = _loc14_;
               _loc15_.isRankByCilent = false;
            }
            _loc18_ = _loc15_.raceLen;
            _loc17_ = _loc5_.readInt();
            _loc2_ = _loc17_ - _loc18_;
            _loc7_ = _loc15_.id + "客：" + _loc18_ + "服：" + _loc17_ + "差：" + _loc2_;
            if(_loc17_ > maxRaceLen)
            {
               _loc17_ = maxRaceLen;
            }
            if(_tenCount > 5)
            {
               _loc15_.raceLen = _loc17_;
            }
            _loc9_ = _loc15_.id + "原：" + _loc15_.speed + "----" + _loc15_.raceLen;
            _loc10_ = _loc15_.id + "改：" + _loc15_.speed + "----" + _loc15_.raceLen;
            _loc15_.isGoToEnd = _loc5_.readBoolean();
            _loc4_ = _loc5_.readInt();
            _loc16_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc8_ = _loc5_.readByte();
               _loc16_.push(_loc8_);
               _loc5_.readInt();
               _loc5_.readInt();
               _loc5_.readInt();
               _loc6_++;
            }
            if(_loc15_.isGoToEnd)
            {
               _loc16_ = [];
            }
            _loc15_.buffList = _loc16_;
            _loc11_++;
         }
         getRankByRaceLen();
         _playerInfoView.flushBuffList();
         _first = false;
      }
      
      public function getRankByRaceLen() : void
      {
         var _loc9_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc14_:* = null;
         var _loc4_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < racePlayerList.length)
         {
            _loc9_ = racePlayerList[_loc8_] as HorseRaceWalkPlayer;
            if(_loc9_.isRankByCilent)
            {
               _loc2_.push(_loc9_);
            }
            else
            {
               _loc3_.push(_loc9_);
            }
            _loc8_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc7_ = _loc6_;
            while(_loc7_ < _loc2_.length)
            {
               if(_loc2_[_loc6_].raceLen < _loc2_[_loc7_].raceLen)
               {
                  _loc14_ = _loc2_[_loc6_];
                  _loc2_[_loc6_] = _loc2_[_loc7_];
                  _loc2_[_loc7_] = _loc14_;
               }
               _loc7_++;
            }
            _loc6_++;
         }
         var _loc1_:Array = [0,0,0,0,0];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc12_ = _loc3_[_loc4_] as HorseRaceWalkPlayer;
            _loc13_ = _loc12_.rank;
            _loc1_[_loc13_ - 1] = _loc12_;
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc11_ = _loc2_[_loc5_] as HorseRaceWalkPlayer;
            _loc10_ = 0;
            while(_loc10_ < _loc1_.length)
            {
               if(_loc1_[_loc10_] == 0)
               {
                  _loc1_[_loc10_] = _loc11_;
                  _loc11_.rank = _loc10_ + 1;
                  break;
               }
               _loc10_++;
            }
            _loc5_++;
         }
      }
      
      public function getRankByRaceLen2(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = _loc4_;
            while(_loc3_ < param1.length)
            {
               if(param1[_loc4_] < param1[_loc3_])
               {
                  _loc2_ = param1[_loc4_];
                  param1[_loc4_] = param1[_loc3_];
                  param1[_loc3_] = _loc2_;
               }
               _loc3_++;
            }
            _loc4_++;
         }
         return param1;
      }
      
      private function _allRaceEnd(param1:HorseRaceEvents) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc3_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = _loc5_.readInt();
            _loc4_ = findPlayerByID(_loc2_);
            _loc6_++;
         }
      }
      
      private function _raceEnd(param1:HorseRaceEvents) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc3_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = _loc5_.readInt();
            _loc4_ = findPlayerByID(_loc2_);
            _loc6_++;
         }
      }
      
      private function _speedChange(param1:HorseRaceEvents) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc3_:int = _loc6_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = _loc6_.readInt();
            _loc5_ = findPlayerByID(_loc2_);
            _loc4_ = _loc6_.readInt();
            _loc5_.speed = _loc4_;
            _loc7_++;
         }
      }
      
      private function _beginRace(param1:HorseRaceEvents) : void
      {
         startRace();
      }
      
      private function _startFiveCountDown(param1:HorseRaceEvents) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:int = _loc3_.readInt();
         startCountDown(_loc2_ / 1000);
      }
      
      private function _initPlayerInfo(param1:HorseRaceEvents) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         racePlayerList = [];
         var _loc3_:PackageIn = param1.data as PackageIn;
         gameId = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new HorseRacePlayerInfo();
            _loc4_.ID = _loc3_.readInt();
            _loc4_.NickName = _loc3_.readUTF();
            _loc4_.Sex = _loc3_.readBoolean();
            _loc4_.Hide = _loc3_.readInt();
            _loc4_.Style = _loc3_.readUTF();
            _loc4_.Colors = _loc3_.readUTF();
            _loc4_.Skin = _loc3_.readUTF();
            _loc4_.Grade = _loc3_.readInt();
            _loc4_.horseRaceIndex = _loc3_.readInt();
            _loc4_.horseRaceSpeed = _loc3_.readInt();
            _loc4_.MountsType = _loc3_.readInt();
            addPlayer(_loc4_,_loc4_.horseRaceIndex - 1,_loc4_.horseRaceSpeed);
            _loc5_++;
         }
         initPlayerInfoView();
         initMsgView();
         initBuffView();
      }
      
      private function initBuffView() : void
      {
         _buffView = new HorseRaceBuffView();
         PositionUtils.setPos(_buffView,"horseRace.raceView.buffViewPos");
         addChild(_buffView);
      }
      
      private function initMsgView() : void
      {
         _msgView = new HorseRaceMsgView();
         PositionUtils.setPos(_msgView,"horseRace.raceView.msgViewPos");
         addChild(_msgView);
      }
      
      private function initPlayerInfoView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _playerInfoView = new HorseRacePlayerInfoView();
         PositionUtils.setPos(_playerInfoView,"horseRace.raceView.playerInfoViewPos");
         addChild(_playerInfoView);
         _loc3_ = 0;
         while(_loc3_ < racePlayerList.length)
         {
            _loc2_ = racePlayerList[_loc3_] as HorseRaceWalkPlayer;
            _loc1_ = new HorseRacePlayerItemView(_loc2_);
            _playerInfoView.addPlayerItem(_loc1_);
            _loc3_++;
         }
      }
      
      public function dispose2() : void
      {
         KeyboardShortcutsManager.Instance.cancelForbidden();
         if(alert)
         {
            alert.removeEventListener("response",__onRecoverResponse);
            ObjectUtils.disposeObject(alert);
         }
         SocketManager.Instance.out.sendHorseRaceEnd(_selfPlayer.gameId,_selfPlayer.id);
         removeAllPlayer();
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         InviteManager.Instance.enabled = true;
      }
      
      public function dispose() : void
      {
         KeyboardShortcutsManager.Instance.cancelForbidden();
         if(alert)
         {
            alert.removeEventListener("response",__onRecoverResponse);
            ObjectUtils.disposeObject(alert);
         }
         removeAllPlayer();
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         InviteManager.Instance.enabled = true;
      }
   }
}
