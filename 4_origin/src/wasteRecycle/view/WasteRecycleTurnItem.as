package wasteRecycle.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WasteRecycleTurnItem extends Sprite implements Disposeable
   {
      
      public static const PLAY_COMPLETE:String = "playComplete";
      
      public static const SHINE_COMPLETE:String = "shineComplete";
       
      
      private var _turn:Sprite;
      
      private var _waggleBg:Bitmap;
      
      private var _shine:MovieClip;
      
      private var _result:int;
      
      private var _origin:int;
      
      private var _isPlay:Boolean;
      
      private var _isShine:Boolean;
      
      public function WasteRecycleTurnItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _turn = new Sprite();
         _waggleBg = ComponentFactory.Instance.creatBitmap("asset.wasteRecycle.waggle");
         _shine = ComponentFactory.Instance.creat("asset.wasteRecycle.shine");
         _shine.y = -1;
         _shine.gotoAndStop(1);
         addChild(_turn);
         addChild(_waggleBg);
         addChild(_shine);
         _waggleBg.visible = false;
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(0,0,95,125);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         this.mask = _loc1_;
         createTurn(int(Math.random() * 14) + 1);
      }
      
      private function createTurn(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         ObjectUtils.disposeAllChildren(_turn);
         _loc4_ = -2;
         while(_loc4_ <= 2)
         {
            _loc2_ = param1 + _loc4_;
            if(_loc2_ == -1)
            {
               _loc2_ = 14;
            }
            else if(_loc2_ == 0)
            {
               _loc2_ = 15;
            }
            else if(_loc2_ == 16)
            {
               _loc2_ = 1;
            }
            else if(_loc2_ == 17)
            {
               _loc2_ = 2;
            }
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.wasteRecycle.lottery" + _loc2_);
            if(_loc4_ == 0)
            {
               _origin = (95 - _loc3_.height) / 2 - _turn.height;
            }
            _loc3_.x = (95 - _loc3_.width) / 2;
            _loc3_.y = _turn.height + 20;
            _turn.addChild(_loc3_);
            _loc4_++;
         }
         _turn.y = _origin;
      }
      
      public function turn(param1:int) : void
      {
         _result = param1;
         _shine.gotoAndStop(1);
         _isPlay = true;
         turnStart();
      }
      
      public function shine() : void
      {
         _isShine = true;
         _shine.gotoAndPlay(2);
         _shine.addEventListener("enterFrame",__onEnterFrame);
      }
      
      private function __onEnterFrame(param1:Event) : void
      {
         if(_shine.currentFrame == _shine.totalFrames)
         {
            _isShine = false;
            _shine.removeEventListener("enterFrame",__onEnterFrame);
            _shine.gotoAndStop(1);
            dispatchEvent(new Event("shineComplete"));
         }
      }
      
      private function turnStart() : void
      {
         onComplete1 = function():void
         {
            TweenLite.killTweensOf(_turn,true);
            _turn.visible = false;
         };
         onRepeat = function():void
         {
            TweenLite.killTweensOf(_waggleBg,false);
            repeatCount = Number(repeatCount) + 1;
            if(Number(repeatCount) < 3)
            {
               _waggleBg.visible = true;
               _waggleBg.y = -_waggleBg.height;
               TweenLite.to(_waggleBg,0.3,{
                  "y":0,
                  "onComplete":onRepeat
               }).play();
            }
            else
            {
               createTurn(_result);
               _waggleBg.visible = false;
               onComplete2();
            }
         };
         onComplete2 = function():void
         {
            _turn.y = -_turn.height;
            _turn.visible = true;
            TweenLite.to(_turn,1.5,{
               "y":_origin,
               "ease":Back.easeOut,
               "onComplete":onComplete3
            }).play();
         };
         onComplete3 = function():void
         {
            TweenLite.killTweensOf(_turn,true);
            _isPlay = false;
            dispatchEvent(new Event("playComplete"));
         };
         TweenLite.to(_turn,0.3,{
            "y":0,
            "ease":Back.easeIn,
            "onComplete":onComplete1
         }).play();
         var repeatCount:int = 0;
      }
      
      public function get isPlay() : Boolean
      {
         return _isPlay;
      }
      
      public function get isShine() : Boolean
      {
         return _isShine;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_turn);
         ObjectUtils.disposeAllChildren(this);
         _turn = null;
         _waggleBg = null;
         _shine = null;
      }
   }
}
