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
      
      public function SelfMarkBar(param1:LocalPlayer, param2:DisplayObjectContainer)
      {
         _nums = new Vector.<DisplayObject>();
         _animateFilter = new BlurFilter();
         _numDic = new Dictionary();
         super();
         _self = param1;
         _container = param2;
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
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.game.mark.Blue" + _loc3_);
            _numDic["Blue" + _loc3_] = _loc1_;
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.game.mark.Red" + _loc2_);
            _numDic["Red" + _loc2_] = _loc1_;
            _loc2_++;
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
      
      protected function onMouseMove(param1:MouseEvent) : void
      {
         _noActionTurn = 0;
      }
      
      private function __skip(param1:MouseEvent) : void
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
      
      private function __beginShoot(param1:LivingEvent) : void
      {
         pause();
         _skipButton.enabled = false;
      }
      
      private function __attackChanged(param1:LivingEvent) : void
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
         for(var _loc1_ in _numDic)
         {
            ObjectUtils.disposeObject(_numDic[_loc1_]);
            delete _numDic[_loc1_];
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
      
      public function startup(param1:int) : void
      {
         if(!_enabled)
         {
            return;
         }
         _skipButton.enabled = true;
         _alreadyTime = param1;
         __mark(null);
         _timer = new Timer(1000,param1);
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
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         _noActionTurn = 0;
         if(param1.keyCode == KeyStroke.VK_P.getCode() && _self.isAttacking && NewHandGuideManager.Instance.mapID != 111)
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
         var _loc1_:DisplayObject = _nums.shift();
         while(_loc1_)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_ = _nums.shift();
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
      
      private function __markComplete(param1:TimerEvent) : void
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
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enabled != param1)
         {
            _enabled = param1;
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
      
      private function __mark(param1:TimerEvent) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         TweenLite.killTweensOf(this);
         clear();
         _alreadyTime = Number(_alreadyTime) - 1;
         var _loc6_:String = _alreadyTime.toString();
         if(_alreadyTime > 9)
         {
            if(_alreadyTime % 11 == 0)
            {
               _loc4_ = _numDic["Blue" + _loc6_.substr(0,1)];
               _loc4_.x = 0;
               _numContainer.addChild(_loc4_);
               _nums.push(_loc4_);
               _loc7_ = new Shape();
               _loc3_ = _numDic["Blue" + _loc6_.substr(0,1)].bitmapData;
               _loc2_ = _loc7_.graphics;
               _loc2_.beginBitmapFill(_loc3_);
               _loc2_.drawRect(0,0,_loc3_.width,_loc3_.height);
               _loc2_.endFill();
               _loc7_.x = _nums[0].width;
               _numContainer.addChild(_loc7_);
               _nums.push(_loc7_);
               _numContainer.x = -_numContainer.width >> 1;
            }
            else
            {
               _loc4_ = _numDic["Blue" + _loc6_.substr(0,1)];
               _loc4_.x = 0;
               _numContainer.addChild(_loc4_);
               _nums.push(_loc4_);
               _loc4_ = _numDic["Blue" + _loc6_.substr(1,1)];
               _loc4_.x = _nums[0].width;
               _numContainer.addChild(_loc4_);
               _nums.push(_loc4_);
               _numContainer.x = -_numContainer.width >> 1;
            }
            SoundManager.instance.play("014");
         }
         else if(_alreadyTime >= 0)
         {
            if(_alreadyTime <= 4)
            {
               _loc4_ = _numDic["Red" + _loc6_];
               Bitmap(_loc4_).smoothing = true;
               _numContainer.addChild(_loc4_);
               _nums.push(_loc4_);
               SoundManager.instance.stop("067");
               SoundManager.instance.play("067");
               _loc5_ = _scale - 1;
               _numContainer.x = -_numContainer.width * _scale >> 1;
               _numContainer.y = -_numContainer.height * _loc5_ >> 1;
               var _loc8_:* = _scale;
               _numContainer.scaleY = _loc8_;
               _numContainer.scaleX = _loc8_;
               TweenLite.to(_numContainer,0.2,{
                  "x":-_loc4_.width >> 1,
                  "y":0,
                  "scaleX":1,
                  "scaleY":1
               });
            }
            else
            {
               _loc4_ = _numDic["Blue" + _loc6_];
               if(_loc4_)
               {
                  _loc4_.x = 0;
                  _numContainer.addChild(_loc4_);
                  _numContainer.x = -_numContainer.width >> 1;
                  _nums.push(_loc4_);
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
