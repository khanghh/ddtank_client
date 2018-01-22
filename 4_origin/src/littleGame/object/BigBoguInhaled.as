package littleGame.object
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Bounce;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import littleGame.LittleGameManager;
   import littleGame.interfaces.ILittleObject;
   import littleGame.view.PriceShape;
   import littleGame.view.ScoreShape;
   
   public class BigBoguInhaled extends NormalBoguInhaled
   {
       
      
      private var _clickSoundChannel:SoundChannel;
      
      private var _soundPlaying:Boolean = false;
      
      private var _scoreShape:ScoreShape;
      
      private var _soundPlayVer:int;
      
      private var _scoreTween:Boolean = false;
      
      public function BigBoguInhaled()
      {
         super();
      }
      
      override public function get type() : String
      {
         return "bigbogu";
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_clickSoundChannel)
         {
            _clickSoundChannel.removeEventListener("soundComplete",__soundComplete);
         }
      }
      
      override protected function drawInhaleAsset() : void
      {
         _inhaleAsset = ClassUtils.CreatInstance("asset.littleGame.BigInhale");
         _inhaleAsset.x = 526;
         _inhaleAsset.y = 324;
         addChild(_inhaleAsset);
         var _loc1_:Boolean = false;
         _inhaleAsset.mouseEnabled = _loc1_;
         _inhaleAsset.mouseChildren = _loc1_;
         _inhaleAsset.addEventListener("enterFrame",__inhaleOnFrame);
         _inhaleAsset.gotoAndPlay("born");
         SoundManager.instance.play("163");
      }
      
      private function __inhaleOnFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrameLabel == "bornEnd")
         {
            start();
         }
         else if(_loc2_.currentFrame >= _loc2_.totalFrames)
         {
            ObjectUtils.disposeObject(_loc2_);
            complete();
         }
      }
      
      override protected function drawBackground() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.beginFill(0,0.8);
         _loc1_.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _loc1_.endFill();
      }
      
      override public function execute() : void
      {
         var _loc1_:* = null;
         drawBackground();
         drawMark();
         lockLivings();
         _scene.selfInhaled = true;
         ChatManager.Instance.focusFuncEnabled = false;
         var _loc2_:Dictionary = _scene.littleObjects;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            _loc1_ = _loc2_[_loc3_];
            if(_loc1_.type == "bogugiveup")
            {
               _scene.removeObject(_loc1_);
            }
         }
         LittleGameManager.Instance.mainStage.addChild(this);
         _timer = new Timer(1000,_time);
         _timer.addEventListener("timer",__mark);
         _timer.addEventListener("timerComplete",__markComplete);
         _timer.start();
      }
      
      private function scoreTweenComplete() : void
      {
         _scoreTween = false;
      }
      
      private function priceTweenIn(param1:DisplayObject) : void
      {
         TweenLite.to(param1,0.2,{
            "delay":2,
            "alpha":1,
            "y":param1.y - param1.height * 2,
            "ease":Bounce.easeOut,
            "onComplete":ObjectUtils.disposeObject,
            "onCompleteParams":[param1]
         });
      }
      
      private function __soundComplete(param1:Event) : void
      {
         _soundPlaying = false;
         param1.currentTarget.removeEventListener("soundComplete",__soundComplete);
         if(_soundPlayVer < _clickCount && _running)
         {
            _clickSoundChannel = SoundManager.instance.play("164");
            if(_clickSoundChannel)
            {
               _clickSoundChannel.addEventListener("soundComplete",__soundComplete);
            }
            _soundPlaying = true;
            _soundPlayVer = _clickCount;
         }
      }
      
      override protected function __click(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         _clickCount = Number(_clickCount) + 1;
         if(_inhaleAsset)
         {
            _inhaleAsset["admit"]["water"].gotoAndStop(int(_inhaleAsset["admit"]["water"].totalFrames * _clickCount / _totalClick));
            _inhaleAsset["admit"].play();
         }
         _score = _totalScore * _clickCount / _totalClick;
         var _loc2_:int = 0;
         if(_scoreShape)
         {
            _scoreShape.setScore(_score);
         }
         else
         {
            _scoreShape = new ScoreShape(1);
            _scoreShape.y = StageReferance.stageHeight - _scoreShape.height >> 1;
            _scoreShape.setScore(_score);
            addChild(_scoreShape);
         }
         if(!_scoreTween)
         {
            _scoreShape.alpha = 0;
            _scoreShape.x = 200;
            _scoreTween = true;
            TweenLite.to(_scoreShape,0.3,{
               "alpha":1,
               "x":300,
               "ease":Bounce.easeOut,
               "onComplete":scoreTweenComplete
            });
            SoundManager.instance.stop("164");
            SoundManager.instance.play("164");
         }
         if(_clickCount >= _totalClick)
         {
            removeEventListener("click",__click);
            _loc2_ = _totalScore * 0.2;
            _loc3_ = new PriceShape(_loc2_);
            _loc3_.alpha = 0;
            _loc3_.x = 300;
            _loc3_.y = _scoreShape.y;
            addChild(_loc3_);
            TweenLite.to(_loc3_,0.2,{
               "delay":0.2,
               "alpha":1,
               "y":_loc3_.y - _loc3_.height - 20,
               "onComplete":priceTweenIn,
               "onCompleteParams":[_loc3_]
            });
            _target.dieing = true;
         }
         _score = _score + _loc2_;
      }
      
      override protected function complete() : void
      {
         LittleGameManager.Instance.sendScore(_score,_target.id);
         if(_inhaleAsset)
         {
            _inhaleAsset.removeEventListener("enterFrame",__inhaleOnFrame);
         }
         _running = false;
         dispose();
      }
      
      private function start() : void
      {
         _inhaleAsset.gotoAndPlay("stand");
         if(_timer)
         {
            _timer.start();
         }
         addEvent();
      }
      
      override protected function __markComplete(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.currentTarget as Timer;
         _loc2_.removeEventListener("timer",__mark);
         _loc2_.removeEventListener("timerComplete",__markComplete);
         removeEventListener("click",__click);
         _inhaleAsset.gotoAndPlay("out");
      }
      
      override public function dispose() : void
      {
         _removed = true;
         if(_running)
         {
            return;
         }
         if(_self)
         {
            _self.doAction("stand");
            _self.MotionState = 2;
            _self.inhaled = false;
         }
         releaseLivings();
         super.dispose();
      }
   }
}
