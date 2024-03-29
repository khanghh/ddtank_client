package happyLittleGame.cubesGame
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CubeEffectView extends Sprite implements Disposeable
   {
      
      private static const _DELAY_TIME:uint = 3000;
      
      private static const _COOLDOWN_CNT:uint = 7;
       
      
      private var _passEffect:Bitmap;
      
      private var _overEffect:Bitmap;
      
      private var _againBtn:SimpleBitmapButton;
      
      private var _cooldown:ScaleFrameImage;
      
      private var _alert:Sprite;
      
      private var _nextBtn:TextButton;
      
      private var _cooldownTimer:TimerJuggler;
      
      private var _timer:TimerJuggler;
      
      private var _talkTimer:Timer;
      
      private var _princessDialog:DialogWindow;
      
      private var _heroDialog:DialogWindow;
      
      private var _destroyEffect:ExtraDestroyEffect;
      
      private var _extraEffect:ExtraDestroyEffect;
      
      public function CubeEffectView()
      {
         super();
         initView();
         initListeners();
      }
      
      private function initView() : void
      {
         _passEffect = ComponentFactory.Instance.creatBitmap("asset.cubeGameRankView.passed");
         PositionUtils.setPos(_passEffect,"cubeGame.effectContainer.passEffectPos");
         _passEffect.visible = false;
         addChild(_passEffect);
         _overEffect = ComponentFactory.Instance.creatBitmap("asset.cubeGameRankView.gameOver");
         PositionUtils.setPos(_overEffect,"cubeGame.effectContainer.overEffectPos");
         _overEffect.visible = false;
         addChild(_overEffect);
         _againBtn = ComponentFactory.Instance.creatComponentByStylename("cubeEffectContainer.againBtn");
         PositionUtils.setPos(_againBtn,"cubeGame.effectContainer.againBtnPos");
         _againBtn.visible = false;
         addChild(_againBtn);
         _alert = new Sprite();
         PositionUtils.setPos(_alert,"cubeGame.effectContainer.alertPos");
         addChild(_alert);
         _alert.visible = false;
         var _loc1_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("cubeEffectContinaer.alertBg");
         _alert.addChild(_loc1_);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("cubeEffectContinaer.msgTxt");
         _loc2_.text = LanguageMgr.GetTranslation("ddt.funnyGame.cubeGame.msgTxt");
         PositionUtils.setPos(_loc2_,"cubeGame.effectContainer.msgTxtPos");
         _alert.addChild(_loc2_);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _nextBtn.text = LanguageMgr.GetTranslation("ddt.funnyGame.cubeGame.nextLevel");
         PositionUtils.setPos(_nextBtn,"cubeGame.effectContainer.nextBtnPos");
         _alert.addChild(_nextBtn);
         _princessDialog = new DialogWindow();
         PositionUtils.setPos(_princessDialog,"cubeGame.effectContainer.princessDialogPos");
         _princessDialog.alpha = 0;
         addChild(_princessDialog);
         _heroDialog = new DialogWindow();
         PositionUtils.setPos(_heroDialog,"cubeGame.effectContainer.heroDialogPos");
         _heroDialog.alpha = 0;
         addChild(_heroDialog);
         _destroyEffect = new ExtraDestroyEffect();
         addChild(_destroyEffect);
         _extraEffect = new ExtraDestroyEffect(true);
         addChild(_extraEffect);
      }
      
      private function initListeners() : void
      {
         _againBtn.addEventListener("click",__onClick);
         _nextBtn.addEventListener("click",__onClick);
         CubeGameManager.getInstance().addEventListener("gameResult",__onGameResult);
         CubeGameManager.getInstance().addEventListener("gameStart",__onGameStart);
         CubeGameManager.getInstance().addEventListener("cooldown",__onCooldown);
         CubeGameManager.getInstance().addEventListener("cubeDeath",__showExtraDestroy);
      }
      
      private function __showExtraDestroy(param1:CubeGameEvent) : void
      {
         var _loc2_:Vector.<Object> = param1.data as Vector.<Object>;
         if(_loc2_.length > CubeGameManager.getInstance().gameInfo.extraDestroyCnt)
         {
            _extraEffect.show();
         }
         else if(_loc2_.length > CubeGameManager.getInstance().gameInfo.strongDestroyCnt)
         {
            _destroyEffect.show();
         }
      }
      
      private function __onCooldown(param1:CubeGameEvent) : void
      {
         if(!_talkTimer)
         {
            _talkTimer = new Timer(3000,1);
         }
         _talkTimer.addEventListener("timerComplete",onHeroTalk);
         _talkTimer.start();
         _princessDialog.talk(true);
         CubeGameManager.getInstance().requestStartCubeGame();
         TweenLite.killTweensOf(_overEffect,false);
         _overEffect.visible = false;
         _passEffect.visible = false;
         if(_timer)
         {
            _timer.removeEventListener("timer",delayHandler);
            _timer.stop();
            _timer = null;
         }
         _alert.visible = false;
         TweenLite.killTweensOf(_againBtn,false);
         _againBtn.visible = false;
      }
      
      private function onHeroTalk(param1:TimerEvent) : void
      {
         _heroDialog.talk();
         _talkTimer.stop();
         _talkTimer.removeEventListener("timerComplete",onHeroTalk);
         _talkTimer = null;
      }
      
      private function cooldownBegin(param1:Event = null) : void
      {
         _cooldown.setFrame(7 - _cooldownTimer.currentCount);
         if(_cooldownTimer.currentCount == 7)
         {
            _cooldown.visible = false;
         }
         else if(_cooldownTimer.currentCount == 7 + 1)
         {
            TimerManager.getInstance().removeTimer1000ms(_cooldownTimer);
            CubeGameManager.getInstance().requestStartCubeGame();
         }
         if(_cooldownTimer.currentCount == 2)
         {
            if(_princessDialog)
            {
               _princessDialog.talk(true);
            }
         }
         else if(_cooldownTimer.currentCount == 5)
         {
            if(_heroDialog)
            {
               _heroDialog.talk();
            }
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _againBtn)
         {
            _overEffect.visible = false;
            _againBtn.visible = false;
            CubeGameManager.getInstance().requestRestartGame();
         }
         else if(param1.currentTarget == _nextBtn)
         {
            _alert.visible = false;
            CubeGameManager.getInstance().requestStartCubeGame();
         }
      }
      
      private function removeListener() : void
      {
         _againBtn.removeEventListener("click",__onClick);
         _nextBtn.removeEventListener("click",__onClick);
         CubeGameManager.getInstance().removeEventListener("gameResult",__onGameResult);
         CubeGameManager.getInstance().removeEventListener("gameStart",__onGameStart);
         CubeGameManager.getInstance().removeEventListener("cooldown",__onCooldown);
         CubeGameManager.getInstance().removeEventListener("cubeDeath",__showExtraDestroy);
         if(_cooldownTimer)
         {
            _cooldownTimer.removeEventListener("timer",cooldownBegin);
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",delayHandler);
         }
         if(_talkTimer)
         {
            _talkTimer.stop();
            _talkTimer.removeEventListener("timerComplete",onHeroTalk);
            _talkTimer = null;
         }
      }
      
      private function __onGameResult(param1:CubeGameEvent) : void
      {
         var _loc2_:Boolean = param1.data as Boolean;
         _passEffect.visible = _loc2_;
         _overEffect.visible = !_loc2_;
         _againBtn.visible = false;
         var _loc5_:String = !!_loc2_?"cubeGame.effectContainer.passEffectFromPos":"cubeGame.effectContainer.overEffectFromPos";
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject(_loc5_);
         var _loc6_:Bitmap = !!_loc2_?_passEffect:_overEffect;
         var _loc3_:String = !!_loc2_?"cubeGame.effectContainer.passEffectPos":"cubeGame.effectContainer.overEffectPos";
         PositionUtils.setPos(_loc6_,_loc3_);
         var _loc7_:int = 1;
         _loc6_.scaleY = _loc7_;
         _loc6_.scaleX = _loc7_;
         _loc6_.alpha = 1;
         TweenLite.from(_loc6_,1,{
            "x":_loc4_.x,
            "y":_loc4_.y,
            "alpha":0.5,
            "scaleX":0,
            "scaleY":0,
            "onComplete":onEnd,
            "onCompleteParams":[_loc6_]
         });
      }
      
      private function onEnd(param1:Object) : void
      {
         if(param1 == _overEffect)
         {
            _againBtn.visible = true;
         }
         else if(param1 == _passEffect)
         {
            if(!_timer)
            {
               _timer = TimerManager.getInstance().addTimer1000ms(3000,1);
            }
            _timer.addEventListener("timer",delayHandler);
            _timer.start();
         }
      }
      
      private function delayHandler(param1:Event) : void
      {
         _passEffect.visible = false;
         TimerManager.getInstance().removeTimer1000ms(_timer);
         _alert.visible = true;
      }
      
      private function __onGameStart(param1:CubeGameEvent) : void
      {
         _overEffect.visible = false;
         _againBtn.visible = false;
      }
      
      public function dispose() : void
      {
         removeListener();
         TimerManager.getInstance().removeTimer1000ms(_timer);
         TimerManager.getInstance().removeTimer1000ms(_cooldownTimer);
         TweenLite.killTweensOf(this,false);
         ObjectUtils.disposeAllChildren(_alert);
         ObjectUtils.disposeObject(_alert);
         _alert = null;
         ObjectUtils.disposeAllChildren(this);
         _passEffect = null;
         _overEffect = null;
         _againBtn = null;
         ObjectUtils.disposeAllChildren(_destroyEffect);
         _destroyEffect = null;
         ObjectUtils.disposeAllChildren(_extraEffect);
         _extraEffect = null;
      }
   }
}

import com.greensock.TweenLite;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import ddt.manager.LanguageMgr;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

class DialogWindow extends Sprite implements Disposeable
{
    
   
   private var _bg:Bitmap;
   
   private var _txt:FilterFrameText;
   
   private var _timer:Timer;
   
   private var _data:String;
   
   function DialogWindow()
   {
      super();
      initView();
   }
   
   private function initView() : void
   {
      _bg = ComponentFactory.Instance.creatBitmap("asset.cubeGameEffectView.dialogBg");
      addChild(_bg);
      _txt = ComponentFactory.Instance.creatComponentByStylename("cubeEffectContinaer.dialogTxt");
      PositionUtils.setPos(_txt,"cubeGame.effectContainer.dialogTxtPos");
      addChild(_txt);
   }
   
   public function talk(param1:Boolean = false) : void
   {
      isPrincess = param1;
      var bgSizeName:String = !!isPrincess?"cubeGame.effectContainer.princessDialogBgSize":"cubeGame.effectContainer.heroDialogBgSize";
      var bgSize:Point = ComponentFactory.Instance.creatCustomObject(bgSizeName);
      _bg.width = bgSize.x;
      _bg.height = bgSize.y;
      _data = !!isPrincess?LanguageMgr.GetTranslation("ddt.funnyGame.cubeGame.princessDialogTxt"):LanguageMgr.GetTranslation("ddt.funnyGame.cubeGame.heroDialogTxt");
      TweenLite.killTweensOf(this,false);
      TweenLite.to(this,0.5,{
         "alpha":1,
         "onComplete":function():void
         {
            if(_timer)
            {
               _timer.stop();
               _timer = null;
            }
            _timer = new Timer(100,_data.length);
            _timer.addEventListener("timer",__onTimer);
            _timer.addEventListener("timerComplete",__onCompleteTimer);
            _timer.start();
         }
      });
   }
   
   private function __onCompleteTimer(param1:TimerEvent) : void
   {
      evt = param1;
      TweenLite.killTweensOf(this,false);
      TweenLite.to(this,1,{
         "alpha":0,
         "delay":1,
         "onComplete":function():void
         {
            if(_txt)
            {
               _txt.text = "";
            }
         }
      });
      if(_timer)
      {
         _timer.removeEventListener("timerComplete",__onCompleteTimer);
         _timer.removeEventListener("timer",__onTimer);
         _timer.stop();
         _timer = null;
      }
   }
   
   private function __onTimer(param1:TimerEvent) : void
   {
      if(_txt)
      {
         _txt.text = _data.substr(0,_timer.currentCount);
      }
   }
   
   public function dispose() : void
   {
      if(_timer)
      {
         _timer.removeEventListener("timerComplete",__onCompleteTimer);
         _timer.removeEventListener("timer",__onTimer);
         _timer.stop();
      }
      _timer = null;
      ObjectUtils.disposeAllChildren(this);
      _txt = null;
      _bg = null;
   }
}

import com.greensock.TweenLite;
import com.greensock.easing.Sine;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.image.NumberImage;
import com.pickgliss.utils.ObjectUtils;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import funnyGames.cubeGame.CubeGameManager;

class ExtraDestroyEffect extends Sprite implements Disposeable
{
    
   
   private var _isExtra:Boolean;
   
   private var _numsImg:NumberImage;
   
   function ExtraDestroyEffect(param1:Boolean = false)
   {
      super();
      _isExtra = param1;
      initView();
      this.visible = false;
      this.alpha = 0;
   }
   
   private function initView() : void
   {
      var _loc1_:String = !!_isExtra?"asset.cubeGameEffectView.extraDestroyImg":"asset.cubeGameEffectView.bigDestroyImg";
      var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap(_loc1_);
      addChild(_loc3_);
      var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.cubeEffectViewr.add");
      var _loc4_:String = !!_isExtra?"cubeGame.effectContainer.extraAddEffectPos":"cubeGame.effectContainer.destroyAddEffectPos";
      PositionUtils.setPos(_loc2_,_loc4_);
      addChild(_loc2_);
      _numsImg = ComponentFactory.Instance.creatComponentByStylename("cubeEffectContinaer.numbers");
      _numsImg.y = _loc2_.y;
      _numsImg.x = _loc2_.x + _loc2_.width;
      addChild(_numsImg);
   }
   
   public function show() : void
   {
      _numsImg.count = !!_isExtra?CubeGameManager.getInstance().gameInfo.extraDestroyScore:uint(CubeGameManager.getInstance().gameInfo.strongDestroyScore);
      var endPos:Point = ComponentFactory.Instance.creatCustomObject("cubeGame.effectContainer.destroyEndEffectPos");
      PositionUtils.setPos(this,"cubeGame.effectContainer.destroyStartEffectPos");
      this.visible = true;
      this.alpha = 1;
      TweenLite.killTweensOf(this,false);
      TweenLite.to(this,0.6,{
         "y":endPos.y,
         "ease":Sine.easeIn,
         "onCompleteParams":[this],
         "onComplete":function(param1:DisplayObject):void
         {
            target = param1;
            TweenLite.killTweensOf(target,true);
            TweenLite.to(target,1,{
               "alpha":0,
               "onComplete":function():void
               {
                  target.visible = false;
               }
            });
         }
      });
   }
   
   public function dispose() : void
   {
      TweenLite.killTweensOf(this,false);
      ObjectUtils.disposeAllChildren(this);
      if(parent)
      {
         parent.removeChild(this);
      }
      ObjectUtils.disposeAllChildren(_numsImg);
      _numsImg = null;
   }
}
