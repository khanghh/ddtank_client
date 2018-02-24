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
      
      public function CubeEffectView(){super();}
      
      private function initView() : void{}
      
      private function initListeners() : void{}
      
      private function __showExtraDestroy(param1:CubeGameEvent) : void{}
      
      private function __onCooldown(param1:CubeGameEvent) : void{}
      
      private function onHeroTalk(param1:TimerEvent) : void{}
      
      private function cooldownBegin(param1:Event = null) : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function removeListener() : void{}
      
      private function __onGameResult(param1:CubeGameEvent) : void{}
      
      private function onEnd(param1:Object) : void{}
      
      private function delayHandler(param1:Event) : void{}
      
      private function __onGameStart(param1:CubeGameEvent) : void{}
      
      public function dispose() : void{}
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
   
   function DialogWindow(){super();}
   
   private function initView() : void{}
   
   public function talk(param1:Boolean = false) : void{}
   
   private function __onCompleteTimer(param1:TimerEvent) : void{}
   
   private function __onTimer(param1:TimerEvent) : void{}
   
   public function dispose() : void{}
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
   
   function ExtraDestroyEffect(param1:Boolean = false){super();}
   
   private function initView() : void{}
   
   public function show() : void{}
   
   public function dispose() : void{}
}
