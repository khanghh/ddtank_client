package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Bounce;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.FightAchievModel;
   import ddt.display.BitmapShape;
   import ddt.manager.BitmapManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   [Event(name="complete",type="flash.events.Event")]
   public class AchieveAnimation extends Sprite implements Disposeable
   {
      
      public static const Show:int = 1;
      
      public static const Hold:int = 2;
      
      public static const Hide:int = -1;
       
      
      private var _startY:int;
      
      private var _startX:int;
      
      private var _flashTime:Number;
      
      private var _holdTime:Number;
      
      private var _fadeOutTime:Number;
      
      private var _elapsed:int;
      
      private var _lastTime:int;
      
      private var _state:int = -1;
      
      private var _currentAchiev:int;
      
      private var _num:int = 0;
      
      private var _achievImage:ScaleFrameImage;
      
      private var _numShape:AchievNumShape;
      
      private var _center:Point;
      
      private var _holdTimeField:TextField;
      
      private var _shine:AchievShineShape;
      
      private var _shineTime:Number;
      
      private var _interval:int = -1;
      
      private var _show:Boolean = false;
      
      private var _start:int = 0;
      
      private var _achiev:int;
      
      private var _bitmapMgr:BitmapManager;
      
      private var _achievShape:BitmapShape;
      
      public function AchieveAnimation(achiev:int, num:int, interval:int, start:int)
      {
         _center = new Point();
         super();
         _interval = interval;
         _start = start;
         _achiev = achiev;
         _num = num;
         _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
         _shine = ComponentFactory.Instance.creatCustomObject("AchievShineShape");
         addChild(_shine);
         _achievShape = _bitmapMgr.creatBitmapShape("asset.game.achiev" + _achiev);
         addChild(_achievShape);
         _startX = StageReferance.stageWidth;
         mouseEnabled = false;
         mouseChildren = false;
         _numShape = new AchievNumShape();
         addChild(_numShape);
      }
      
      public function dispose() : void
      {
         kill();
         if(_bitmapMgr)
         {
            ObjectUtils.disposeObject(_bitmapMgr);
            _bitmapMgr = null;
         }
         if(_numShape)
         {
            ObjectUtils.disposeObject(_numShape);
            _numShape = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_achievShape)
         {
            ObjectUtils.disposeObject(_achievShape);
            _achievShape = null;
         }
      }
      
      private function drawNum() : void
      {
         _numShape.drawNum(_num);
         _numShape.filters = [new GlowFilter(FightAchievModel.getInstance().getAchievColor(_achiev),1,10,10,3)];
         _numShape.x = _center.x - (_numShape.width >> 1);
         _numShape.y = _center.y - (_numShape.height >> 1);
      }
      
      public function flash() : void
      {
         alpha = 0;
         _state = 1;
         _show = true;
      }
      
      private function flashComplete() : void
      {
         _lastTime = getTimer();
         _elapsed = 0;
         _state = 2;
         StageReferance.stage.addEventListener("enterFrame",__holdFrame);
         if(!FightAchievModel.getInstance().isNumAchiev(_achiev))
         {
            _shine.setColor(FightAchievModel.getInstance().getAchievColor(_achiev));
            TweenLite.to(_shine,_shineTime,{
               "alpha":1,
               "yoyo":true,
               "repeat":1,
               "onComplete":shineComplete
            });
         }
      }
      
      private function shineComplete() : void
      {
         _shine.alpha = 0;
      }
      
      private function __holdFrame(event:Event) : void
      {
         var now:int = getTimer();
         _elapsed = _elapsed + (now - _lastTime);
         if(_elapsed >= _holdTime * 1000)
         {
            holdComplete();
            return;
         }
         _lastTime = now;
      }
      
      private function holdComplete() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",__holdFrame);
         fadeOut();
      }
      
      public function fadeOut() : void
      {
         _state = -1;
         TweenLite.to(this,_fadeOutTime,{
            "alpha":0,
            "onComplete":fadeOutComplete
         });
      }
      
      private function fadeOutComplete() : void
      {
         _numShape.visible = false;
         dispatchEvent(new Event("complete"));
      }
      
      public function kill() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",__holdFrame);
         TweenLite.killTweensOf(this);
         TweenLite.killTweensOf(_shine);
         _numShape.visible = false;
         _shine.alpha = 0;
         _show = false;
      }
      
      public function play() : void
      {
         x = width;
         alpha = 0;
         _state = 1;
         _show = true;
         if(FightAchievModel.getInstance().isNumAchiev(_achiev))
         {
            drawNum();
         }
         TweenLite.to(this,_flashTime,{
            "x":0,
            "alpha":1,
            "onComplete":flashComplete,
            "ease":Bounce.easeOut
         });
         _show = true;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set startY(val:int) : void
      {
         _startY = val;
         y = _startY;
      }
      
      public function set numCenter(val:String) : void
      {
         var arr:Array = val.split(",");
         _center.x = arr[0];
         _center.y = arr[1];
      }
      
      public function set time(val:String) : void
      {
         var arr:Array = val.split(",");
         if(arr.length == 4)
         {
            _flashTime = arr[0] > 0?arr[0]:0.6;
            _holdTime = arr[1] > 0?arr[1]:2;
            _fadeOutTime = arr[2] > 0?arr[2]:0.6;
            _shineTime = arr[3] > 0?arr[3]:0.6;
            return;
         }
         throw new Error("在初始化小成就动画时传入了错误的时间值。");
      }
      
      public function get interval() : int
      {
         return _interval;
      }
      
      public function get show() : Boolean
      {
         return _show;
      }
      
      public function get delay() : int
      {
         return _start + _interval;
      }
      
      public function get id() : int
      {
         return _achiev;
      }
      
      public function setNum(num:int) : void
      {
         _num = num > 0?num:0;
         drawNum();
         if(_state == 2)
         {
            _elapsed = 0;
         }
      }
      
      override public function get height() : Number
      {
         trace("height:" + _achievShape.height);
         return _achievShape.height;
      }
      
      override public function set y(value:Number) : void
      {
         trace(_achiev + ":" + value);
         .super.y = value;
      }
   }
}
