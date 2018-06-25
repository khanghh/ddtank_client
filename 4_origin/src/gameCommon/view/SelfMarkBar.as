package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BlurFilter;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import trainer.controller.NewHandGuideManager;
   
   public class SelfMarkBar extends Sprite implements Disposeable
   {
       
      
      private var _self:LocalPlayer;
      
      private var _timer:Timer;
      
      private var _nums:Vector.<DisplayObject>;
      
      private var _numContainer:Sprite;
      
      private var _alreadyTime:int;
      
      private var _animateFilter:BlurFilter;
      
      private var _scale:Number = 2;
      
      private var _skipButton:SkipButton;
      
      private var _container:DisplayObjectContainer;
      
      private var _noActionTurn:int;
      
      private var _numDic:Dictionary;
      
      private var _enabled:Boolean = true;
      
      public function SelfMarkBar(self:LocalPlayer, container:DisplayObjectContainer)
      {
         _nums = new Vector.<DisplayObject>();
         _animateFilter = new BlurFilter();
         _numDic = new Dictionary();
         super();
         _self = self;
         _container = container;
         _numContainer = new Sprite();
         var _loc3_:Boolean = false;
         _numContainer.mouseEnabled = _loc3_;
         _numContainer.mouseChildren = _loc3_;
         addChild(_numContainer);
         _skipButton = ComponentFactory.Instance.creatCustomObject("SkipButton");
         _skipButton.x = -_skipButton.width >> 1;
         _skipButton.y = 70;
         addChild(_skipButton);
         creatNums();
         addEvent();
      }
      
      private function creatNums() : void
      {
         var bitmap:* = null;
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < 10; )
         {
            bitmap = ComponentFactory.Instance.creatBitmap("asset.game.mark.Blue" + i);
            _numDic["Blue" + i] = bitmap;
            i++;
         }
         for(j = 0; j < 5; )
         {
            bitmap = ComponentFactory.Instance.creatBitmap("asset.game.mark.Red" + j);
            _numDic["Red" + j] = bitmap;
            j++;
         }
      }
      
      private function addEvent() : void
      {
         _self.addEventListener("attackingChanged",__attackChanged);
         _self.addEventListener("beginShoot",__beginShoot);
         _skipButton.addEventListener("click",__skip);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         StageReferance.stage.addEventListener("mouseMove",onMouseMove);
      }
      
      protected function onMouseMove(event:MouseEvent) : void
      {
         _noActionTurn = 0;
      }
      
      private function __skip(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_skipButton.enabled && !_self.autoOnHook)
         {
            skip();
         }
      }
      
      private function removeEvent() : void
      {
         _self.removeEventListener("attackingChanged",__attackChanged);
         _self.removeEventListener("beginShoot",__beginShoot);
         if(_skipButton)
         {
            _skipButton.removeEventListener("click",__skip);
         }
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
         StageReferance.stage.removeEventListener("mouseMove",onMouseMove);
      }
      
      private function __beginShoot(evt:LivingEvent) : void
      {
         pause();
         _skipButton.enabled = false;
      }
      
      private function __attackChanged(event:LivingEvent) : void
      {
         if(_self.isAttacking && GameControl.Instance.Current.currentLiving && GameControl.Instance.Current.currentLiving.isSelf)
         {
            startup(_self.turnTime);
         }
         else
         {
            pause();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         shutdown();
         clear();
         if(_skipButton)
         {
            ObjectUtils.disposeObject(_skipButton);
            _skipButton = null;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _numDic;
         for(var key in _numDic)
         {
            ObjectUtils.disposeObject(_numDic[key]);
            delete _numDic[key];
         }
         if(_numContainer)
         {
            ObjectUtils.disposeObject(_numContainer);
            _numContainer = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function startup(time:int) : void
      {
         if(!_enabled)
         {
            return;
         }
         _skipButton.enabled = true;
         _alreadyTime = time;
         __mark(null);
         _timer = new Timer(1000,time);
         _timer.addEventListener("timer",__mark);
         _timer.addEventListener("timerComplete",__markComplete);
         _timer.start();
         _container.addChild(this);
         _animateFilter.blurX = 40;
         filters = [_animateFilter];
         TweenLite.to(_animateFilter,0.3,{
            "blurX":0,
            "onUpdate":tweenRender,
            "onComplete":tweenComplete
         });
      }
      
      private function __keyDown(evt:KeyboardEvent) : void
      {
         _noActionTurn = 0;
         if(evt.keyCode == KeyStroke.VK_P.getCode() && _self.isAttacking && NewHandGuideManager.Instance.mapID != 111)
         {
            SoundManager.instance.play("008");
            skip();
         }
      }
      
      public function pause() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
      }
      
      public function shutdown() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__mark);
            _timer.removeEventListener("timerComplete",__markComplete);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function clear() : void
      {
         var num:DisplayObject = _nums.shift();
         while(num)
         {
            if(num.parent)
            {
               num.parent.removeChild(num);
            }
            num = _nums.shift();
         }
      }
      
      private function skip() : void
      {
         pause();
         _self.skip();
      }
      
      private function tweenRender() : void
      {
         filters = [_animateFilter];
      }
      
      private function tweenComplete() : void
      {
         filters = null;
      }
      
      private function __markComplete(event:TimerEvent) : void
      {
         _noActionTurn = Number(_noActionTurn) + 1;
         shutdown();
         _self.skip();
         if(_noActionTurn >= 2000)
         {
            SocketManager.Instance.out.sendGameTrusteeship(true);
         }
      }
      
      public function get runnning() : Boolean
      {
         return _timer != null && _timer.running;
      }
      
      public function set enabled(val:Boolean) : void
      {
         if(_enabled != val)
         {
            _enabled = val;
            if(_enabled && runnning)
            {
               _container.addChild(this);
            }
            else
            {
               shutdown();
            }
         }
      }
      
      private function __mark(event:TimerEvent) : void
      {
         var num:* = null;
         var shape:* = null;
         var bmd:* = null;
         var pen:* = null;
         var rate:Number = NaN;
         TweenLite.killTweensOf(this);
         clear();
         _alreadyTime = Number(_alreadyTime) - 1;
         var numStr:String = _alreadyTime.toString();
         if(_alreadyTime > 9)
         {
            if(_alreadyTime % 11 == 0)
            {
               num = _numDic["Blue" + numStr.substr(0,1)];
               num.x = 0;
               _numContainer.addChild(num);
               _nums.push(num);
               shape = new Shape();
               bmd = _numDic["Blue" + numStr.substr(0,1)].bitmapData;
               pen = shape.graphics;
               pen.beginBitmapFill(bmd);
               pen.drawRect(0,0,bmd.width,bmd.height);
               pen.endFill();
               shape.x = _nums[0].width;
               _numContainer.addChild(shape);
               _nums.push(shape);
               _numContainer.x = -_numContainer.width >> 1;
            }
            else
            {
               num = _numDic["Blue" + numStr.substr(0,1)];
               num.x = 0;
               _numContainer.addChild(num);
               _nums.push(num);
               num = _numDic["Blue" + numStr.substr(1,1)];
               num.x = _nums[0].width;
               _numContainer.addChild(num);
               _nums.push(num);
               _numContainer.x = -_numContainer.width >> 1;
            }
            SoundManager.instance.play("014");
         }
         else if(_alreadyTime >= 0)
         {
            if(_alreadyTime <= 4)
            {
               num = _numDic["Red" + numStr];
               Bitmap(num).smoothing = true;
               _numContainer.addChild(num);
               _nums.push(num);
               SoundManager.instance.stop("067");
               SoundManager.instance.play("067");
               rate = _scale - 1;
               _numContainer.x = -_numContainer.width * _scale >> 1;
               _numContainer.y = -_numContainer.height * rate >> 1;
               var _loc8_:* = _scale;
               _numContainer.scaleY = _loc8_;
               _numContainer.scaleX = _loc8_;
               TweenLite.to(_numContainer,0.2,{
                  "x":-num.width >> 1,
                  "y":0,
                  "scaleX":1,
                  "scaleY":1
               });
            }
            else
            {
               num = _numDic["Blue" + numStr];
               if(num)
               {
                  num.x = 0;
                  _numContainer.addChild(num);
                  _numContainer.x = -_numContainer.width >> 1;
                  _nums.push(num);
               }
               SoundManager.instance.play("014");
            }
         }
         else
         {
            return;
         }
      }
   }
}
