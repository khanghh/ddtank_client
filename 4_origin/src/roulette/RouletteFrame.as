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
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc5_:* = null;
         getAllNumPoint();
         getAllGoodsPoint();
         var _loc10_:Array = [];
         _loc10_.push(0,0,0,0,60,60,60,80,-60,-60,-70,-60,0,0,0,0,60,60,50,60);
         var _loc2_:Array = [];
         _loc2_.push(0,60,120,180,240,300);
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
         _loc6_ = 0;
         while(_loc6_ < _arrNum.length)
         {
            _loc7_ = ComponentFactory.Instance.creatBitmap("asset.roulette.number.bg" + _arrNum[_loc6_]);
            _loc7_.x = _pointNumArr[_loc6_].x;
            _loc7_.y = _pointNumArr[_loc6_].y;
            _loc7_.rotation = _loc10_[_loc6_];
            _loc7_.smoothing = true;
            addChild(_loc7_);
            _numbmpVec.push(_loc7_);
            _loc6_++;
         }
         _start = ComponentFactory.Instance.creatComponentByStylename("roulette.startBtn");
         _exchange = ComponentFactory.Instance.creatComponentByStylename("roulette.exchangeBtn");
         _close = ComponentFactory.Instance.creatComponentByStylename("roulette.closeBtn");
         addChild(_start);
         _start.transparentEnable = true;
         addChild(_exchange);
         _exchange.transparentEnable = true;
         addChild(_close);
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.helpConent.ticketText");
         _loc4_.text = ServerConfigManager.instance.RouletteMaxTicket;
         _help = HelpFrameUtils.Instance.simpleHelpButton(this,"roulette.helpBtn",null,LanguageMgr.GetTranslation("tank.roulette.helpView.tltle"),["roulette.helpConent.bg",_loc4_],410,510,false) as SelectedButton;
         _loc9_ = 0;
         while(_loc9_ <= 5)
         {
            _loc8_ = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.CellBGAsset");
            _loc5_ = new RouletteCell(_loc8_);
            _loc5_.x = _pointArray[_loc9_].x;
            _loc5_.y = _pointArray[_loc9_].y;
            _loc5_.rotation = _loc2_[_loc9_];
            _loc5_.selected = false;
            addChild(_loc5_);
            _goodsList.push(_loc5_);
            _loc9_++;
         }
         _glintView = new LeftRouletteGlintView(_pointArray);
         addChild(_glintView);
         var _loc1_:int = LeftGunRouletteManager.instance.gCount;
         var _loc3_:String = LeftGunRouletteManager.instance.reward;
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
      
      private function updateServerTime(param1:TimerEvent = null) : void
      {
         var _loc8_:Number = NaN;
         var _loc7_:* = NaN;
         var _loc3_:* = NaN;
         var _loc6_:* = NaN;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_endDayTxt)
         {
            _loc8_ = LeftGunRouletteManager.instance.endTime.time - TimeManager.Instance.Now().time;
            _loc7_ = 86400000;
            _loc3_ = 3600000;
            _loc6_ = 60000;
            _loc5_ = _loc8_ / _loc7_;
            _loc4_ = _loc8_ % _loc7_ / _loc3_;
            _loc2_ = _loc8_ % _loc7_ % _loc3_ / _loc6_;
            if(_loc5_ > 0)
            {
               _endDayTxt.text = _loc5_ + LanguageMgr.GetTranslation("ddt.roulette.endDayMsg");
            }
            else if(_loc4_ > 0)
            {
               _endDayTxt.text = _loc4_ + LanguageMgr.GetTranslation("ddt.roulette.endHourMsg");
            }
            else if(_loc2_ > 0)
            {
               _endDayTxt.text = _loc2_ + LanguageMgr.GetTranslation("ddt.roulette.endMinuteMsg");
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
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function getAllGoodsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = [];
         _loc2_ = 0;
         while(_loc2_ < _pointLength[0])
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("roulette.aperture.point" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function getAllNumPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointNumArr = [];
         _loc2_ = 0;
         while(_loc2_ < _pointLength[1])
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("roulette.number.point" + _loc2_);
            _pointNumArr.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function test(param1:int, param2:String) : void
      {
         var _loc4_:* = param1;
         var _loc3_:* = param2;
         _isSend = isSendNotice(_loc3_);
         if(_loc4_ <= 0)
         {
            var _loc11_:Boolean = false;
            _start.mouseEnabled = _loc11_;
            _start.visible = _loc11_;
            _loc11_ = true;
            _exchange.mouseEnabled = _loc11_;
            _exchange.visible = _loc11_;
            dispatchEvent(new RouletteFrameEvent("roulette_visible",_loc3_,null));
         }
         var _loc6_:Array = [];
         var _loc10_:String = _arrNum[0] + "." + _arrNum[2];
         var _loc8_:String = _arrNum[4] + "." + _arrNum[6];
         var _loc9_:String = _arrNum[8] + "." + _arrNum[10];
         var _loc5_:String = _arrNum[12] + "." + _arrNum[14];
         var _loc7_:String = _arrNum[16] + "." + _arrNum[18];
         _loc6_.push(_loc10_,_loc8_,_loc9_,_loc5_,_loc7_,"0");
         turnSlectedNumber = _loc6_.indexOf(_loc3_);
         if(turnSlectedNumber == -1)
         {
            return;
         }
         removeEventListener("keyDown",__keyDownHandler);
         _goodsList[turnSlectedNumber].selected = false;
         _glintView.showThreeCell(turnSlectedNumber);
      }
      
      private function _getItem(param1:PkgEvent) : void
      {
         var _loc7_:PackageIn = param1.pkg;
         var _loc3_:int = _loc7_.readInt();
         var _loc2_:String = _loc7_.readUTF();
         LeftGunRouletteManager.instance.gCount = _loc3_;
         LeftGunRouletteManager.instance.reward = _loc2_;
         _isSend = isSendNotice(_loc2_);
         if(_loc3_ <= 0)
         {
            var _loc11_:Boolean = false;
            _start.mouseEnabled = _loc11_;
            _start.visible = _loc11_;
            _loc11_ = true;
            _exchange.mouseEnabled = _loc11_;
            _exchange.visible = _loc11_;
            dispatchEvent(new RouletteFrameEvent("roulette_visible",_loc2_,null));
         }
         var _loc5_:Array = [];
         var _loc10_:String = _arrNum[0] + "." + _arrNum[2];
         var _loc8_:String = _arrNum[4] + "." + _arrNum[6];
         var _loc9_:String = _arrNum[8] + "." + _arrNum[10];
         var _loc4_:String = _arrNum[12] + "." + _arrNum[14];
         var _loc6_:String = _arrNum[16] + "." + _arrNum[18];
         _loc5_.push(_loc10_,_loc8_,_loc9_,_loc4_,_loc6_,"0");
         turnSlectedNumber = _loc5_.indexOf(_loc2_);
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
      
      private function onMaskClick(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roulette.running"));
      }
      
      private function isSendNotice(param1:String) : Boolean
      {
         var _loc3_:Array = param1.split(".");
         var _loc2_:int = _loc3_[0];
         if(_loc2_ >= 2)
         {
            return true;
         }
         return false;
      }
      
      private function _timeComplete(param1:TimerEvent) : void
      {
         updateTurnType(nowDelayTime);
         nowDelayTime = nowDelayTime + _stepTime;
         nextNode();
         startTimer(nowDelayTime);
      }
      
      private function __startHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.stopMusic();
         SoundManager.instance.play("008");
         _glintView.stopGlint();
         var _loc2_:Boolean = false;
         _exchange.mouseEnabled = _loc2_;
         _exchange.visible = _loc2_;
         SocketManager.Instance.out.sendStartTurn_LeftGun();
      }
      
      private function __exchangeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Boolean = false;
         _start.mouseEnabled = _loc2_;
         _start.visible = _loc2_;
         dispatchEvent(new RouletteFrameEvent("button_click"));
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function updateTurnType(param1:int) : void
      {
         var _loc2_:int = turnSlectedNumber;
         switch(int(turnType) - 1)
         {
            case 0:
               if(param1 <= _delay[1])
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
      
      private function startTimer(param1:int) : void
      {
         if(!_isStopTurn)
         {
            _timer.delay = param1;
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
      
      private function turnPlate(param1:int, param2:int = 1) : void
      {
         turnType = param2;
         selectedGoodsNumber = param1;
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
      
      private function clearPrevSelct(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = param1 - param2 < 0?param1 - param2 + _goodsList.length:Number(param1 - param2);
         if(_loc4_ == 1)
         {
            _goodsList[param2].selected = false;
         }
         else
         {
            _loc3_ = param1 - 1 < 0?param1 - 1 + _goodsList.length:Number(param1 - 1);
            _goodsList[_loc3_].setGreep();
            _goodsList[param2].selected = false;
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
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
            _loc2_ = 0;
            while(_loc2_ < _goodsList.length)
            {
               if(_goodsList[_loc2_])
               {
                  ObjectUtils.disposeObject(_goodsList[_loc2_]);
               }
               _goodsList[_loc2_] = null;
               _loc2_++;
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
            _loc1_ = 0;
            while(_loc1_ < _numbmpVec.length)
            {
               if(_numbmpVec[_loc1_])
               {
                  ObjectUtils.disposeObject(_numbmpVec[_loc1_]);
               }
               _numbmpVec[_loc1_] = null;
               _loc1_++;
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
      
      public function set turnSlectedNumber(param1:int) : void
      {
         _turnSlectedNumber = param1;
      }
      
      public function set sparkleNumber(param1:int) : void
      {
         _sparkleNumber = param1;
         if(_sparkleNumber >= _goodsList.length)
         {
            _sparkleNumber = 0;
         }
      }
      
      public function get sparkleNumber() : int
      {
         return _sparkleNumber;
      }
      
      public function set nowDelayTime(param1:int) : void
      {
         _turnTypeTimeSum = _turnTypeTimeSum + _nowDelayTime;
         _nowDelayTime = param1;
      }
      
      public function get nowDelayTime() : int
      {
         return _nowDelayTime;
      }
      
      public function set turnType(param1:int) : void
      {
         _turnType = param1;
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
      
      public function set selectedGoodsNumber(param1:int) : void
      {
         _selectedGoodsNumber = param1;
         _moderationNumber = (_delay[2] - _delay[1]) / 40;
         var _loc2_:int = _selectedGoodsNumber - _moderationNumber;
         while(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + _goodsList.length;
         }
         _startModerationNumber = _loc2_;
      }
      
      private function get prevSelected() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         switch(int(_turnType) - 1)
         {
            case 0:
               _loc2_ = sparkleNumber == 0?_goodsList.length - 1:Number(_sparkleNumber - 1);
               break;
            case 1:
               _loc2_ = sparkleNumber - 1 < 0?sparkleNumber - 1 + _goodsList.length:Number(sparkleNumber - 1);
               break;
            case 2:
               if(_moderationNumber > 3)
               {
                  _loc2_ = sparkleNumber - 1 < 0?sparkleNumber - 1 + _goodsList.length:Number(sparkleNumber - 1);
                  break;
               }
               _loc1_ = _moderationNumber >= 3?_moderationNumber - 2:1;
               _loc2_ = sparkleNumber - _loc1_ < 0?sparkleNumber - _loc1_ + _goodsList.length:Number(_sparkleNumber - _loc1_);
               if(_moderationNumber >= 6)
               {
                  _goodsList[_loc2_ + 1 >= _goodsList.length?0:Number(_loc2_ + 1)].selected = false;
                  break;
               }
               break;
         }
         return _loc2_;
      }
   }
}
