package roulette
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.roulette.TurnSoundControl;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class RouletteFrame extends Sprite implements Disposeable
   {
      
      public static const TYPE_SPEED_UP:int = 1;
      
      public static const TYPE_SPEED_UNCHANGE:int = 2;
      
      public static const TYPE_SPEED_DOWN:int = 3;
      
      public static const SHADOW_NUMBER:int = 1;
      
      public static const DOWN_SUB_SHADOW_BOL:int = 3;
      
      public static const GLINT_ONE_TIME:int = 3000;
      
      public static const SPEEDUP_RATE:int = -70;
      
      public static const SPEEDDOWN_RATE:int = 40;
      
      public static const MINTIME_PLAY_SOUNDONESTEP:int = 30;
      
      public static const PLAY_SOUNDTHREESTEP_NUMBER:int = 14;
      
      private static const ESCkeyCode:int = 27;
       
      
      private var _rouletteBG:Bitmap;
      
      private var _rechargeableBG:Bitmap;
      
      private var _recurBG:Bitmap;
      
      private var _goodsList:Vector.<RouletteCell>;
      
      private var _glintView:LeftRouletteGlintView;
      
      private var _pointArray:Array;
      
      private var _pointNumArr:Array;
      
      private var _isStopTurn:Boolean = false;
      
      private var _turnSlectedNumber:int;
      
      private var _timer:Timer;
      
      private var _moderationNumber:int = 0;
      
      private var _nowDelayTime:int = 1000;
      
      private var _turnType:int = 1;
      
      private var _delay:Array;
      
      private var _moveTime:Array;
      
      private var _selectedGoodsNumber:int = 0;
      
      private var _turnTypeTimeSum:int = 0;
      
      private var _stepTime:int = 0;
      
      private var _startModerationNumber:int = 0;
      
      private var _arrNum:Array;
      
      private var _close:SelectedButton;
      
      private var _help:SelectedButton;
      
      private var _start:SelectedButton;
      
      private var _exchange:SelectedButton;
      
      private var _numbmpVec:Vector.<Bitmap>;
      
      private var _pointLength:Array;
      
      private var _sound:TurnSoundControl;
      
      private var _mask:Sprite;
      
      private var _endDayBg:Bitmap;
      
      private var _endDayTitle:Bitmap;
      
      private var _endDayTxt:FilterFrameText;
      
      private var _endDayTimer:Timer;
      
      private var _isSend:Boolean;
      
      private var _sparkleNumber:int = 0;
      
      public function RouletteFrame()
      {
         _delay = [600,50,600];
         _moveTime = [2000,3000,2000];
         _pointLength = [6,20];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var a:int = 0;
         var bg:* = null;
         var j:int = 0;
         var bg1:* = null;
         var cell:* = null;
         getAllNumPoint();
         getAllGoodsPoint();
         var rotationsNum:Array = [];
         rotationsNum.push(0,0,0,0,60,60,60,80,-60,-60,-70,-60,0,0,0,0,60,60,50,60);
         var rotations:Array = [];
         rotations.push(0,60,120,180,240,300);
         _goodsList = new Vector.<RouletteCell>();
         _sound = new TurnSoundControl();
         _timer = new Timer(100,1);
         _timer.stop();
         _rouletteBG = ComponentFactory.Instance.creatBitmap("asset.roulette.TurnplateMainView");
         addChild(_rouletteBG);
         _rechargeableBG = ComponentFactory.Instance.creatBitmap("asset.roulette.rechargeable");
         addChild(_rechargeableBG);
         _recurBG = ComponentFactory.Instance.creatBitmap("asset.roulette.recur");
         _recurBG.smoothing = true;
         _recurBG.rotation = -60;
         addChild(_recurBG);
         _arrNum = [];
         _arrNum = LeftGunRouletteManager.instance.ArrNum;
         _numbmpVec = new Vector.<Bitmap>();
         for(a = 0; a < _arrNum.length; )
         {
            bg = ComponentFactory.Instance.creatBitmap("asset.roulette.number.bg" + _arrNum[a]);
            bg.x = _pointNumArr[a].x;
            bg.y = _pointNumArr[a].y;
            bg.rotation = rotationsNum[a];
            bg.smoothing = true;
            addChild(bg);
            _numbmpVec.push(bg);
            a++;
         }
         _start = ComponentFactory.Instance.creatComponentByStylename("roulette.startBtn");
         _exchange = ComponentFactory.Instance.creatComponentByStylename("roulette.exchangeBtn");
         _close = ComponentFactory.Instance.creatComponentByStylename("roulette.closeBtn");
         addChild(_start);
         _start.transparentEnable = true;
         addChild(_exchange);
         _exchange.transparentEnable = true;
         addChild(_close);
         var _maxTicket:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.helpConent.ticketText");
         _maxTicket.text = ServerConfigManager.instance.RouletteMaxTicket;
         _help = HelpFrameUtils.Instance.simpleHelpButton(this,"roulette.helpBtn",null,LanguageMgr.GetTranslation("tank.roulette.helpView.tltle"),["roulette.helpConent.bg",_maxTicket],410,510,false) as SelectedButton;
         for(j = 0; j <= 5; )
         {
            bg1 = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.CellBGAsset");
            cell = new RouletteCell(bg1);
            cell.x = _pointArray[j].x;
            cell.y = _pointArray[j].y;
            cell.rotation = rotations[j];
            cell.selected = false;
            addChild(cell);
            _goodsList.push(cell);
            j++;
         }
         _glintView = new LeftRouletteGlintView(_pointArray);
         addChild(_glintView);
         var gCount:int = LeftGunRouletteManager.instance.gCount;
         var reward:String = LeftGunRouletteManager.instance.reward;
         if(LeftGunRouletteManager.instance.gCount == 0 && LeftGunRouletteManager.instance.reward != "0")
         {
            _start.visible = false;
            _start.mouseEnabled = false;
            test(LeftGunRouletteManager.instance.gCount,LeftGunRouletteManager.instance.reward);
         }
         else
         {
            _exchange.visible = false;
            _exchange.mouseEnabled = false;
         }
         _endDayBg = ComponentFactory.Instance.creatBitmap("roulette.endDayBg");
         _endDayTitle = ComponentFactory.Instance.creatBitmap("roulette.endDayBgTitle");
         _endDayTxt = ComponentFactory.Instance.creatComponentByStylename("roulette.endDayTxt");
         addChild(_endDayBg);
         addChild(_endDayTitle);
         addChild(_endDayTxt);
         updateServerTime();
         _endDayTimer = new Timer(60000);
         _endDayTimer.addEventListener("timer",updateServerTime);
         _endDayTimer.start();
      }
      
      private function updateServerTime(evt:TimerEvent = null) : void
      {
         var tempTime:Number = NaN;
         var tempDay:* = NaN;
         var tempHour:* = NaN;
         var tempMinute:* = NaN;
         var day:int = 0;
         var hour:int = 0;
         var minute:int = 0;
         if(_endDayTxt)
         {
            tempTime = LeftGunRouletteManager.instance.endTime.time - TimeManager.Instance.Now().time;
            tempDay = 86400000;
            tempHour = 3600000;
            tempMinute = 60000;
            day = tempTime / tempDay;
            hour = tempTime % tempDay / tempHour;
            minute = tempTime % tempDay % tempHour / tempMinute;
            if(day > 0)
            {
               _endDayTxt.text = day + LanguageMgr.GetTranslation("ddt.roulette.endDayMsg");
            }
            else if(hour > 0)
            {
               _endDayTxt.text = hour + LanguageMgr.GetTranslation("ddt.roulette.endHourMsg");
            }
            else if(minute > 0)
            {
               _endDayTxt.text = minute + LanguageMgr.GetTranslation("ddt.roulette.endMinuteMsg");
            }
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(163),_getItem);
         _timer.addEventListener("timerComplete",_timeComplete);
         _start.addEventListener("click",__startHandler);
         _exchange.addEventListener("click",__exchangeHandler);
         _close.addEventListener("click",__closeHandler);
         addEventListener("keyDown",__keyDownHandler);
      }
      
      private function __keyDownHandler(event:KeyboardEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function getAllGoodsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = [];
         for(i = 0; i < _pointLength[0]; )
         {
            point = ComponentFactory.Instance.creatCustomObject("roulette.aperture.point" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function getAllNumPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointNumArr = [];
         for(i = 0; i < _pointLength[1]; )
         {
            point = ComponentFactory.Instance.creatCustomObject("roulette.number.point" + i);
            _pointNumArr.push(point);
            i++;
         }
      }
      
      private function test(num:int, str:String) : void
      {
         var count:* = num;
         var result:* = str;
         _isSend = isSendNotice(result);
         if(count <= 0)
         {
            var _loc11_:Boolean = false;
            _start.mouseEnabled = _loc11_;
            _start.visible = _loc11_;
            _loc11_ = true;
            _exchange.mouseEnabled = _loc11_;
            _exchange.visible = _loc11_;
            dispatchEvent(new RouletteFrameEvent("roulette_visible",result,null));
         }
         var rewards:Array = [];
         var num1:String = _arrNum[0] + "." + _arrNum[2];
         var num2:String = _arrNum[4] + "." + _arrNum[6];
         var num3:String = _arrNum[8] + "." + _arrNum[10];
         var num4:String = _arrNum[12] + "." + _arrNum[14];
         var num5:String = _arrNum[16] + "." + _arrNum[18];
         rewards.push(num1,num2,num3,num4,num5,"0");
         turnSlectedNumber = rewards.indexOf(result);
         if(turnSlectedNumber == -1)
         {
            return;
         }
         removeEventListener("keyDown",__keyDownHandler);
         _goodsList[turnSlectedNumber].selected = false;
         _glintView.showThreeCell(turnSlectedNumber);
      }
      
      private function _getItem(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         var result:String = pkg.readUTF();
         LeftGunRouletteManager.instance.gCount = count;
         LeftGunRouletteManager.instance.reward = result;
         _isSend = isSendNotice(result);
         if(count <= 0)
         {
            var _loc11_:Boolean = false;
            _start.mouseEnabled = _loc11_;
            _start.visible = _loc11_;
            _loc11_ = true;
            _exchange.mouseEnabled = _loc11_;
            _exchange.visible = _loc11_;
            dispatchEvent(new RouletteFrameEvent("roulette_visible",result,null));
         }
         var rewards:Array = [];
         var num1:String = _arrNum[0] + "." + _arrNum[2];
         var num2:String = _arrNum[4] + "." + _arrNum[6];
         var num3:String = _arrNum[8] + "." + _arrNum[10];
         var num4:String = _arrNum[12] + "." + _arrNum[14];
         var num5:String = _arrNum[16] + "." + _arrNum[18];
         rewards.push(num1,num2,num3,num4,num5,"0");
         turnSlectedNumber = rewards.indexOf(result);
         if(turnSlectedNumber == -1)
         {
            return;
         }
         removeEventListener("keyDown",__keyDownHandler);
         addMask();
         turnPlate(turnSlectedNumber);
      }
      
      public function addMask() : void
      {
         if(_mask == null)
         {
            _mask = new Sprite();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,2000,1200);
            _mask.graphics.endFill();
            _mask.addEventListener("click",onMaskClick);
         }
         LayerManager.Instance.addToLayer(_mask,3,false,2);
      }
      
      public function removeMask() : void
      {
         if(_mask != null)
         {
            _mask.parent.removeChild(_mask);
            _mask.removeEventListener("click",onMaskClick);
            _mask = null;
         }
      }
      
      private function onMaskClick(event:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roulette.running"));
      }
      
      private function isSendNotice(str:String) : Boolean
      {
         var arr:Array = str.split(".");
         var num:int = arr[0];
         if(num >= 2)
         {
            return true;
         }
         return false;
      }
      
      private function _timeComplete(e:TimerEvent) : void
      {
         updateTurnType(nowDelayTime);
         nowDelayTime = nowDelayTime + _stepTime;
         nextNode();
         startTimer(nowDelayTime);
      }
      
      private function __startHandler(event:MouseEvent) : void
      {
         SoundManager.instance.stopMusic();
         SoundManager.instance.play("008");
         _glintView.stopGlint();
         var _loc2_:Boolean = false;
         _exchange.mouseEnabled = _loc2_;
         _exchange.visible = _loc2_;
         SocketManager.Instance.out.sendStartTurn_LeftGun();
      }
      
      private function __exchangeHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Boolean = false;
         _start.mouseEnabled = _loc2_;
         _start.visible = _loc2_;
         dispatchEvent(new RouletteFrameEvent("button_click"));
      }
      
      private function __closeHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function updateTurnType(value:int) : void
      {
         var i:int = turnSlectedNumber;
         switch(int(turnType) - 1)
         {
            case 0:
               if(value <= _delay[1])
               {
                  turnType = 2;
               }
               break;
            case 1:
               if(_turnTypeTimeSum >= _moveTime[1] && _sparkleNumber == _startModerationNumber)
               {
                  turnType = 3;
               }
               break;
            case 2:
               _moderationNumber = Number(_moderationNumber) - 1;
               if(_moderationNumber <= 0)
               {
                  stopTurn();
                  break;
               }
         }
      }
      
      private function startTimer(time:int) : void
      {
         if(!_isStopTurn)
         {
            _timer.delay = time;
            _timer.reset();
            _timer.start();
         }
      }
      
      private function nextNode() : void
      {
         if(!_isStopTurn)
         {
            sparkleNumber = sparkleNumber + 1;
            if(sparkleNumber == -1)
            {
               return;
            }
            _goodsList[sparkleNumber].setSparkle();
            clearPrevSelct(sparkleNumber,prevSelected);
            if(nowDelayTime > 30 && turnType == 1)
            {
               _sound.stop();
               _sound.playOneStep();
            }
            else if(turnType == 3 && _moderationNumber <= 14)
            {
               _sound.stop();
               _sound.playThreeStep(_moderationNumber);
            }
            else
            {
               _sound.playSound();
            }
         }
      }
      
      private function turnPlate(_select:int, type:int = 1) : void
      {
         turnType = type;
         selectedGoodsNumber = _select;
         startTurn();
         startTimer(nowDelayTime);
      }
      
      private function startTurn() : void
      {
         _isStopTurn = false;
         sparkleNumber = Number(sparkleNumber) - 1;
         WonderfulActivityManager.Instance.isRuning = false;
         var _loc1_:* = false;
         _help.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _exchange.mouseEnabled = _loc1_;
         _start.mouseEnabled = _loc1_;
         _timer.addEventListener("timerComplete",_timeComplete);
      }
      
      private function stopTurn() : void
      {
         _isStopTurn = true;
         WonderfulActivityManager.Instance.isRuning = true;
         _timer.stop();
         _timer.removeEventListener("timerComplete",_timeComplete);
         _turnComplete();
      }
      
      private function _turnComplete() : void
      {
         SoundManager.instance.playMusic("140");
         SoundManager.instance.play("126");
         var _loc1_:* = true;
         _help.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _exchange.mouseEnabled = _loc1_;
         _start.mouseEnabled = _loc1_;
         _goodsList[turnSlectedNumber].selected = false;
         _glintView.showThreeCell(turnSlectedNumber);
         SocketManager.Instance.out.sendEndTurn_LeftGun();
         _loc1_ = turnSlectedNumber == 5?true:false;
         _start.mouseEnabled = _loc1_;
         _start.visible = _loc1_;
         _loc1_ = turnSlectedNumber == 5?false:true;
         _exchange.mouseEnabled = _loc1_;
         _exchange.visible = _loc1_;
         addEventListener("keyDown",__keyDownHandler);
         removeMask();
      }
      
      private function clearPrevSelct(now:int, prev:int) : void
      {
         var one:int = 0;
         var between:int = now - prev < 0?now - prev + _goodsList.length:Number(now - prev);
         if(between == 1)
         {
            _goodsList[prev].selected = false;
         }
         else
         {
            one = now - 1 < 0?now - 1 + _goodsList.length:Number(now - 1);
            _goodsList[one].setGreep();
            _goodsList[prev].selected = false;
         }
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(163),_getItem);
         _timer.removeEventListener("timerComplete",_timeComplete);
         _start.removeEventListener("click",__startHandler);
         _exchange.removeEventListener("click",__exchangeHandler);
         removeEventListener("keyDown",__keyDownHandler);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         removeEvent();
         if(_mask != null)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
         if(_endDayBg)
         {
            ObjectUtils.disposeObject(_endDayBg);
         }
         _endDayBg = null;
         if(_endDayTxt)
         {
            ObjectUtils.disposeObject(_endDayTxt);
         }
         _endDayTxt = null;
         if(_endDayTimer)
         {
            _endDayTimer.stop();
            _endDayTimer.removeEventListener("timer",updateServerTime);
            _endDayTimer = null;
         }
         if(_rouletteBG)
         {
            ObjectUtils.disposeObject(_rouletteBG);
         }
         _rouletteBG = null;
         if(_rechargeableBG)
         {
            ObjectUtils.disposeObject(_rechargeableBG);
         }
         _rechargeableBG = null;
         if(_recurBG)
         {
            ObjectUtils.disposeObject(_recurBG);
         }
         _recurBG = null;
         if(_goodsList && _goodsList.length > 0)
         {
            for(i = 0; i < _goodsList.length; )
            {
               if(_goodsList[i])
               {
                  ObjectUtils.disposeObject(_goodsList[i]);
               }
               _goodsList[i] = null;
               i++;
            }
         }
         _goodsList = null;
         if(_glintView)
         {
            ObjectUtils.disposeObject(_glintView);
         }
         _glintView = null;
         if(_close)
         {
            ObjectUtils.disposeObject(_close);
         }
         _close = null;
         if(_help)
         {
            ObjectUtils.disposeObject(_help);
         }
         _help = null;
         if(_start)
         {
            ObjectUtils.disposeObject(_start);
         }
         _start = null;
         if(_exchange)
         {
            ObjectUtils.disposeObject(_exchange);
         }
         _exchange = null;
         if(_numbmpVec && _numbmpVec.length > 0)
         {
            for(j = 0; j < _numbmpVec.length; )
            {
               if(_numbmpVec[j])
               {
                  ObjectUtils.disposeObject(_numbmpVec[j]);
               }
               _numbmpVec[j] = null;
               j++;
            }
         }
         _numbmpVec = null;
         if(_timer)
         {
            _timer = null;
         }
         if(_sound)
         {
            _sound.stop();
            _sound.dispose();
            _sound = null;
         }
         SoundManager.instance.playMusic("062");
         RouletteControl.instance.setRouletteFramenull();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get turnSlectedNumber() : int
      {
         return _turnSlectedNumber;
      }
      
      public function set turnSlectedNumber(value:int) : void
      {
         _turnSlectedNumber = value;
      }
      
      public function set sparkleNumber(value:int) : void
      {
         _sparkleNumber = value;
         if(_sparkleNumber >= _goodsList.length)
         {
            _sparkleNumber = 0;
         }
      }
      
      public function get sparkleNumber() : int
      {
         return _sparkleNumber;
      }
      
      public function set nowDelayTime(value:int) : void
      {
         _turnTypeTimeSum = _turnTypeTimeSum + _nowDelayTime;
         _nowDelayTime = value;
      }
      
      public function get nowDelayTime() : int
      {
         return _nowDelayTime;
      }
      
      public function set turnType(value:int) : void
      {
         _turnType = value;
         _turnTypeTimeSum = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               _nowDelayTime = _delay[0];
               _stepTime = -70;
               break;
            case 1:
               _nowDelayTime = _delay[1];
               _stepTime = 0;
               break;
            case 2:
               _nowDelayTime = _delay[1];
               _stepTime = 40;
         }
      }
      
      public function get turnType() : int
      {
         return _turnType;
      }
      
      public function set selectedGoodsNumber(value:int) : void
      {
         _selectedGoodsNumber = value;
         _moderationNumber = (_delay[2] - _delay[1]) / 40;
         var m:int = _selectedGoodsNumber - _moderationNumber;
         while(m < 0)
         {
            m = m + _goodsList.length;
         }
         _startModerationNumber = m;
      }
      
      private function get prevSelected() : int
      {
         var step:int = 0;
         var prev:int = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               prev = sparkleNumber == 0?_goodsList.length - 1:Number(_sparkleNumber - 1);
               break;
            case 1:
               prev = sparkleNumber - 1 < 0?sparkleNumber - 1 + _goodsList.length:Number(sparkleNumber - 1);
               break;
            case 2:
               if(_moderationNumber > 3)
               {
                  prev = sparkleNumber - 1 < 0?sparkleNumber - 1 + _goodsList.length:Number(sparkleNumber - 1);
                  break;
               }
               step = _moderationNumber >= 3?_moderationNumber - 2:1;
               prev = sparkleNumber - step < 0?sparkleNumber - step + _goodsList.length:Number(_sparkleNumber - step);
               if(_moderationNumber >= 6)
               {
                  _goodsList[prev + 1 >= _goodsList.length?0:Number(prev + 1)].selected = false;
                  break;
               }
               break;
         }
         return prev;
      }
   }
}
