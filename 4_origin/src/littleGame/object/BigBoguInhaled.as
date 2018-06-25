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
      
      private function __inhaleOnFrame(event:Event) : void
      {
         var movie:MovieClip = event.currentTarget as MovieClip;
         if(movie.currentFrameLabel == "bornEnd")
         {
            start();
         }
         else if(movie.currentFrame >= movie.totalFrames)
         {
            ObjectUtils.disposeObject(movie);
            complete();
         }
      }
      
      override protected function drawBackground() : void
      {
         var g:Graphics = graphics;
         g.beginFill(0,0.8);
         g.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         g.endFill();
      }
      
      override public function execute() : void
      {
         var obj:* = null;
         drawBackground();
         drawMark();
         lockLivings();
         _scene.selfInhaled = true;
         ChatManager.Instance.focusFuncEnabled = false;
         var objects:Dictionary = _scene.littleObjects;
         var _loc5_:int = 0;
         var _loc4_:* = objects;
         for(var key in objects)
         {
            obj = objects[key];
            if(obj.type == "bogugiveup")
            {
               _scene.removeObject(obj);
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
      
      private function priceTweenIn(shape:DisplayObject) : void
      {
         TweenLite.to(shape,0.2,{
            "delay":2,
            "alpha":1,
            "y":shape.y - shape.height * 2,
            "ease":Bounce.easeOut,
            "onComplete":ObjectUtils.disposeObject,
            "onCompleteParams":[shape]
         });
      }
      
      private function __soundComplete(event:Event) : void
      {
         _soundPlaying = false;
         event.currentTarget.removeEventListener("soundComplete",__soundComplete);
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
      
      override protected function __click(event:MouseEvent) : void
      {
         var priceShape:* = null;
         _clickCount = Number(_clickCount) + 1;
         if(_inhaleAsset)
         {
            _inhaleAsset["admit"]["water"].gotoAndStop(int(_inhaleAsset["admit"]["water"].totalFrames * _clickCount / _totalClick));
            _inhaleAsset["admit"].play();
         }
         _score = _totalScore * _clickCount / _totalClick;
         var price:int = 0;
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
            price = _totalScore * 0.2;
            priceShape = new PriceShape(price);
            priceShape.alpha = 0;
            priceShape.x = 300;
            priceShape.y = _scoreShape.y;
            addChild(priceShape);
            TweenLite.to(priceShape,0.2,{
               "delay":0.2,
               "alpha":1,
               "y":priceShape.y - priceShape.height - 20,
               "onComplete":priceTweenIn,
               "onCompleteParams":[priceShape]
            });
            _target.dieing = true;
         }
         _score = _score + price;
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
      
      override protected function __markComplete(event:TimerEvent) : void
      {
         var timer:Timer = event.currentTarget as Timer;
         timer.removeEventListener("timer",__mark);
         timer.removeEventListener("timerComplete",__markComplete);
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
