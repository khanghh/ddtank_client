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
      
      private function startCountDown(count:int) : void
      {
         var countDown:HorseRaceStartCountDown = new HorseRaceStartCountDown(count);
         LayerManager.Instance.addToLayer(countDown,2,false,1);
      }
      
      private function endCountDown(count:int, type:String, _callBack:Function) : void
      {
         var countDown:HorseRaceStartCountDown = new HorseRaceStartCountDown(count,type,_callBack);
         LayerManager.Instance.addToLayer(countDown,2,false,1);
      }
      
      private function initView() : void
      {
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _backBg = ComponentFactory.Instance.creatBitmap("horseRaceView.backBg");
         addChild(_backBg);
         createMap();
         racePlayerPos = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.raceView.Pos");
         var t:String = racePlayerPos.text;
         racePlayerIntPosArr = getPosArr(t);
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
         var i:int = 0;
         var middle:* = null;
         _foreBg = new MovieClip();
         var posX:int = headLinePosX;
         for(i = 0; i < 40; )
         {
            middle = ComponentFactory.Instance.creat("horseRace.raceView.foB");
            middle.x = posX;
            posX = posX + middle.width;
            _foreBg.addChild(middle);
            i++;
         }
         var headLine:Bitmap = ComponentFactory.Instance.creat("horseRace.raceView.forA");
         var endLine:Bitmap = ComponentFactory.Instance.creat("horseRace.raceView.forC");
         _foreBg.addChildAt(headLine,_foreBg.numChildren);
         endLine.x = maxForeMapWidth - endLine.width;
         _foreBg.addChildAt(endLine,_foreBg.numChildren);
         addChild(_foreBg);
         _foreBg.y = -70;
         _foreBg.height = 674;
      }
      
      private function startRace() : void
      {
         var i:int = 0;
         var walkingPlayer:* = null;
         for(i = 0; i < racePlayerList.length; )
         {
            walkingPlayer = racePlayerList[i] as HorseRaceWalkPlayer;
            if(walkingPlayer.id == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer = walkingPlayer;
               _selfPlayer.addEventListener("enterFrame",_setSelfCenter);
               _selfPlayer.gameId = gameId;
            }
            else
            {
               walkingPlayer.addEventListener("enterFrame",_setOtherPlayerWithSelf);
            }
            walkingPlayer.startRace();
            i++;
         }
      }
      
      private function _setTimer(e:Timer) : void
      {
      }
      
      private function _setSelfCenter(e:Event) : void
      {
         var xf:* = NaN;
         var yf:Number = NaN;
         var mySpeedIncreace:int = _selfPlayer.speed / 25;
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
         xf = Number(1000 / 2 - _selfPlayer.raceLen - _selfPlayer.initPosX);
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf <= 1000 - _foreBg.width)
         {
            xf = Number(1000 - _foreBg.width);
            canRanBySpeedToEND = true;
         }
         if(xf > 0 && xf <= 1000 - _foreBg.width)
         {
            selfRanBySpeed = false;
         }
         _foreBg.x = xf;
         forBgPos = xf;
      }
      
      private function _setOtherPlayerWithSelf(e:Event) : void
      {
         var other:HorseRaceWalkPlayer = e.currentTarget as HorseRaceWalkPlayer;
         mycount = Number(mycount) + 1;
         var len:Number = other.raceLen - _selfPlayer.raceLen;
         var len1:int = (other.speed - _selfPlayer.speed) / 25;
         var otherSpeedIncreate:int = other.speed / 25;
         if(mycount > 25)
         {
            getRankByRaceLen();
            mycount = 0;
         }
         if(canRanBySpeedToEND)
         {
            if(other.x < _selfPlayer.x)
            {
               other.x = other.x + other.speed / 25;
               if(other.x >= _selfPlayer.x)
               {
                  other.isGetEnd = true;
                  other.x = _selfPlayer.x;
                  other.removeEventListener("enterFrame",_setOtherPlayerWithSelf);
                  other.stopRace();
                  mycount = 0;
               }
            }
            else if(other.x > _selfPlayer.x)
            {
               other.x = other.x + other.speed / 25;
               if(other.raceLen >= maxRaceLen)
               {
                  other.isGetEnd = true;
                  other.x = 1000 / 2 + other.initPosX;
                  other.removeEventListener("enterFrame",_setOtherPlayerWithSelf);
                  other.stopRace();
                  mycount = 0;
               }
            }
            return;
         }
         if(other.raceLen >= maxRaceLen)
         {
            other.raceLen = maxRaceLen;
            other.isGetEnd = true;
            return;
         }
         other.x = _selfPlayer.x + len;
      }
      
      private function getPosArr(str:String) : Array
      {
         var i:int = 0;
         var str2:* = null;
         var arr3:* = null;
         var x:int = 0;
         var y:int = 0;
         var pos:* = null;
         if(str == "" || str == null)
         {
            return null;
         }
         var arr:Array = str.split("|");
         var arr1:Array = [];
         for(i = 0; i < arr.length; )
         {
            str2 = arr[i];
            arr3 = str2.split(",");
            x = arr3[0];
            y = arr3[1];
            pos = new Point(x,y);
            arr1.push(pos);
            i++;
         }
         return arr1;
      }
      
      public function addPlayer(playerInfo:PlayerInfo, raceIndex:int, $speed:int) : void
      {
         var walkingPlayer:* = null;
         var playerVo:PlayerVO = new PlayerVO();
         playerVo.playerInfo = playerInfo;
         playerInfo.MountsType = Math.max(1,playerInfo.MountsType);
         playerInfo.PetsID = 0;
         walkingPlayer = new HorseRaceWalkPlayer(playerVo,callBack);
         walkingPlayer.index = raceIndex;
         walkingPlayer.rank = raceIndex + 1;
         walkingPlayer.speed = $speed;
         walkingPlayer.id = playerInfo.ID;
         if(walkingPlayer.id == PlayerManager.Instance.Self.ID)
         {
            walkingPlayer.isSelf = true;
         }
         else
         {
            walkingPlayer.isSelf = false;
         }
         var pos:Point = racePlayerIntPosArr[raceIndex];
         walkingPlayer.playerPoint = pos;
         walkingPlayer.initPosX = pos.x;
         addChild(walkingPlayer);
         racePlayerList.push(walkingPlayer);
         walkingPlayer.stand();
      }
      
      private function removePlayer(raceIndex:int) : void
      {
         var walkingPlayer:HorseRaceWalkPlayer = racePlayerList[raceIndex] as HorseRaceWalkPlayer;
         walkingPlayer.stop();
         removeChild(walkingPlayer);
      }
      
      private function removeAllPlayer() : void
      {
         var i:int = 0;
         var walkingPlayer:* = null;
         if(racePlayerList == null)
         {
            return;
         }
         for(i = 0; i < racePlayerList.length; )
         {
            walkingPlayer = racePlayerList[i] as HorseRaceWalkPlayer;
            if(walkingPlayer.id == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer.removeEventListener("enterFrame",_setSelfCenter);
            }
            else
            {
               walkingPlayer.removeEventListener("enterFrame",_setOtherPlayerWithSelf);
            }
            walkingPlayer.stop();
            removeChild(walkingPlayer);
            walkingPlayer.dispose();
            i++;
         }
         racePlayerList = null;
      }
      
      private function findPlayerByID(id:int) : HorseRaceWalkPlayer
      {
         var walkingPlayer:* = null;
         var i:int = 0;
         for(i = 0; i < racePlayerList.length; )
         {
            walkingPlayer = racePlayerList[i] as HorseRaceWalkPlayer;
            if(walkingPlayer.id == id)
            {
               return walkingPlayer;
            }
            i++;
         }
         return null;
      }
      
      private function callBack($walkingPlayer:HorseRaceWalkPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            var _loc4_:* = $walkingPlayer.playerVO.scenePlayerDirection;
            $walkingPlayer.sceneCharacterDirection = _loc4_;
            $walkingPlayer.setSceneCharacterDirectionDefault = _loc4_;
            $walkingPlayer.mouseEnabled = false;
            $walkingPlayer.showPlayerTitle();
            $walkingPlayer.sceneCharacterStateType = "natural";
            $walkingPlayer.showPlayerTitle();
            $walkingPlayer.showVipName();
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
      
      private function _use_pingzhang(e:HorseRaceEvents) : void
      {
         var price:int = 0;
         var content:* = null;
         if(HorseRaceManager.Instance.showPingzhangBuyFram)
         {
            price = ServerConfigManager.instance.HorseGameUsePapawMoney;
            content = LanguageMgr.GetTranslation("horseRace.match.usePingzhangDescription",price);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),content,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
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
      
      private function __onRecoverResponse(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var price:int = ServerConfigManager.instance.HorseGameUsePapawMoney;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(PlayerManager.Instance.Self.Money < price)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendHorseRaceItemUse2(_selfPlayer.gameId,_selfPlayer.id);
         }
         else if(e.responseCode == 4 || e.responseCode == 0 || e.responseCode == 1)
         {
            HorseRaceManager.Instance.showPingzhangBuyFram = true;
         }
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(e.currentTarget);
      }
      
      private function __onClickSelectedBtn(e:MouseEvent) : void
      {
         HorseRaceManager.Instance.showPingzhangBuyFram = !_selectBtn.selected;
      }
      
      private function _use_daoju(e:HorseRaceEvents) : void
      {
         var type:int = e.data;
         if(type == 1)
         {
            if(_buffView.buffItemType1 != 0)
            {
               SocketManager.Instance.out.sendHorseRaceItemUse(_selfPlayer.gameId,_buffView.buffItemType1,_selfPlayer.id,_playerInfoView.selectItemId);
            }
         }
         else if(type == 2)
         {
            if(_buffView.buffItemType2 != 0)
            {
               SocketManager.Instance.out.sendHorseRaceItemUse(_selfPlayer.gameId,_buffView.buffItemType2,_selfPlayer.id,_playerInfoView.selectItemId);
            }
         }
      }
      
      private function __keyDown(event:KeyboardEvent) : void
      {
         var _loc2_:* = event.keyCode;
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
      
      private function _keyShut(e:TimerEvent) : void
      {
         canKeyDown = true;
      }
      
      private function _show_msg(e:HorseRaceEvents) : void
      {
         var pkg:PackageIn = e.data as PackageIn;
         var who:String = pkg.readUTF();
         var target:String = pkg.readUTF();
         var itemName:String = pkg.readUTF();
         var msg:String = LanguageMgr.GetTranslation("horseRace.raceView.msgTxt",who,target,itemName);
         _msgView.addMsg(msg);
      }
      
      private function _buffItem_flush(e:HorseRaceEvents) : void
      {
         var pkg:PackageIn = e.data as PackageIn;
         var buffItem1:int = pkg.readInt();
         var buffItem2:int = pkg.readInt();
         _buffView.buffItemType1 = buffItem1;
         _buffView.buffItemType2 = buffItem2;
         var pingzhangSuccess:Boolean = pkg.readBoolean();
         _buffView.pingzhangUseSuccess = pingzhangSuccess;
         if(pingzhangSuccess)
         {
            _buffView.showPingzhangDaojishi();
         }
      }
      
      private function _synonesecond(e:HorseRaceEvents) : void
      {
         var i:int = 0;
         var id:int = 0;
         var walkingPlayer:* = null;
         var rank:int = 0;
         var raceLen2:int = 0;
         var serverRaceLen:int = 0;
         var raceDic:int = 0;
         var msg:* = null;
         var msg1:* = null;
         var msg2:* = null;
         var buffCount:int = 0;
         var buffList:* = null;
         var j:int = 0;
         var buffType:int = 0;
         var pkg:PackageIn = e.data as PackageIn;
         var timeSyn:int = pkg.readInt();
         _buffView.timeSyn = timeSyn;
         _buffView.flushBuffItem();
         _tenCount = Number(_tenCount) + 1;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            walkingPlayer = findPlayerByID(id);
            pkg.readInt();
            rank = pkg.readInt();
            if(rank != 0)
            {
               walkingPlayer.rank = rank;
               walkingPlayer.isRankByCilent = false;
            }
            raceLen2 = walkingPlayer.raceLen;
            serverRaceLen = pkg.readInt();
            raceDic = serverRaceLen - raceLen2;
            msg = walkingPlayer.id + "客：" + raceLen2 + "服：" + serverRaceLen + "差：" + raceDic;
            if(serverRaceLen > maxRaceLen)
            {
               serverRaceLen = maxRaceLen;
            }
            if(_tenCount > 5)
            {
               walkingPlayer.raceLen = serverRaceLen;
            }
            msg1 = walkingPlayer.id + "原：" + walkingPlayer.speed + "----" + walkingPlayer.raceLen;
            msg2 = walkingPlayer.id + "改：" + walkingPlayer.speed + "----" + walkingPlayer.raceLen;
            walkingPlayer.isGoToEnd = pkg.readBoolean();
            buffCount = pkg.readInt();
            buffList = [];
            for(j = 0; j < buffCount; )
            {
               buffType = pkg.readByte();
               buffList.push(buffType);
               pkg.readInt();
               pkg.readInt();
               pkg.readInt();
               j++;
            }
            if(walkingPlayer.isGoToEnd)
            {
               buffList = [];
            }
            walkingPlayer.buffList = buffList;
            i++;
         }
         getRankByRaceLen();
         _playerInfoView.flushBuffList();
         _first = false;
      }
      
      public function getRankByRaceLen() : void
      {
         var walkingPlayer:* = null;
         var walkingPlayer1:* = null;
         var walkingPlayer2:* = null;
         var i:int = 0;
         var j:int = 0;
         var k:* = 0;
         var temp:* = null;
         var n:int = 0;
         var walkRank:int = 0;
         var m:int = 0;
         var p:int = 0;
         var raceLenList:Array = [];
         var raceLenUnRank:Array = [];
         for(i = 0; i < racePlayerList.length; )
         {
            walkingPlayer = racePlayerList[i] as HorseRaceWalkPlayer;
            if(walkingPlayer.isRankByCilent)
            {
               raceLenList.push(walkingPlayer);
            }
            else
            {
               raceLenUnRank.push(walkingPlayer);
            }
            i++;
         }
         for(j = 0; j < raceLenList.length; )
         {
            for(k = j; k < raceLenList.length; )
            {
               if(raceLenList[j].raceLen < raceLenList[k].raceLen)
               {
                  temp = raceLenList[j];
                  raceLenList[j] = raceLenList[k];
                  raceLenList[k] = temp;
               }
               k++;
            }
            j++;
         }
         var myRankList:Array = [0,0,0,0,0];
         for(n = 0; n < raceLenUnRank.length; )
         {
            walkingPlayer2 = raceLenUnRank[n] as HorseRaceWalkPlayer;
            walkRank = walkingPlayer2.rank;
            myRankList[walkRank - 1] = walkingPlayer2;
            n++;
         }
         for(m = 0; m < raceLenList.length; )
         {
            walkingPlayer1 = raceLenList[m] as HorseRaceWalkPlayer;
            for(p = 0; p < myRankList.length; )
            {
               if(myRankList[p] == 0)
               {
                  myRankList[p] = walkingPlayer1;
                  walkingPlayer1.rank = p + 1;
                  break;
               }
               p++;
            }
            m++;
         }
      }
      
      public function getRankByRaceLen2(arr:Array) : Array
      {
         var temp:int = 0;
         var i:int = 0;
         var j:* = 0;
         for(i = 0; i < arr.length; )
         {
            for(j = i; j < arr.length; )
            {
               if(arr[i] < arr[j])
               {
                  temp = arr[i];
                  arr[i] = arr[j];
                  arr[j] = temp;
               }
               j++;
            }
            i++;
         }
         return arr;
      }
      
      private function _allRaceEnd(e:HorseRaceEvents) : void
      {
         var i:int = 0;
         var id:int = 0;
         var walkingPlayer:* = null;
         var pkg:PackageIn = e.data as PackageIn;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            walkingPlayer = findPlayerByID(id);
            i++;
         }
      }
      
      private function _raceEnd(e:HorseRaceEvents) : void
      {
         var i:int = 0;
         var id:int = 0;
         var walkingPlayer:* = null;
         var pkg:PackageIn = e.data as PackageIn;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            walkingPlayer = findPlayerByID(id);
            i++;
         }
      }
      
      private function _speedChange(e:HorseRaceEvents) : void
      {
         var i:int = 0;
         var id:int = 0;
         var walkingPlayer:* = null;
         var speed:int = 0;
         var pkg:PackageIn = e.data as PackageIn;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            id = pkg.readInt();
            walkingPlayer = findPlayerByID(id);
            speed = pkg.readInt();
            walkingPlayer.speed = speed;
            i++;
         }
      }
      
      private function _beginRace(e:HorseRaceEvents) : void
      {
         startRace();
      }
      
      private function _startFiveCountDown(e:HorseRaceEvents) : void
      {
         var pkg:PackageIn = e.data as PackageIn;
         var count:int = pkg.readInt();
         startCountDown(count / 1000);
      }
      
      private function _initPlayerInfo(e:HorseRaceEvents) : void
      {
         var i:int = 0;
         var info:* = null;
         racePlayerList = [];
         var pkg:PackageIn = e.data as PackageIn;
         gameId = pkg.readInt();
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            info = new HorseRacePlayerInfo();
            info.ID = pkg.readInt();
            info.NickName = pkg.readUTF();
            info.Sex = pkg.readBoolean();
            info.Hide = pkg.readInt();
            info.Style = pkg.readUTF();
            info.Colors = pkg.readUTF();
            info.Skin = pkg.readUTF();
            info.Grade = pkg.readInt();
            info.horseRaceIndex = pkg.readInt();
            info.horseRaceSpeed = pkg.readInt();
            info.MountsType = pkg.readInt();
            addPlayer(info,info.horseRaceIndex - 1,info.horseRaceSpeed);
            i++;
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
         var i:int = 0;
         var walkingPlayer:* = null;
         var itemView:* = null;
         _playerInfoView = new HorseRacePlayerInfoView();
         PositionUtils.setPos(_playerInfoView,"horseRace.raceView.playerInfoViewPos");
         addChild(_playerInfoView);
         for(i = 0; i < racePlayerList.length; )
         {
            walkingPlayer = racePlayerList[i] as HorseRaceWalkPlayer;
            itemView = new HorseRacePlayerItemView(walkingPlayer);
            _playerInfoView.addPlayerItem(itemView);
            i++;
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
