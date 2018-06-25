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
         var mask:Shape = new Shape();
         mask.graphics.beginFill(0);
         mask.graphics.drawRect(0,0,95,125);
         mask.graphics.endFill();
         addChild(mask);
         this.mask = mask;
         createTurn(int(Math.random() * 14) + 1);
      }
      
      private function createTurn(value:int) : void
      {
         var i:int = 0;
         var index:int = 0;
         var btm:* = null;
         ObjectUtils.disposeAllChildren(_turn);
         for(i = -2; i <= 2; )
         {
            index = value + i;
            if(index == -1)
            {
               index = 14;
            }
            else if(index == 0)
            {
               index = 15;
            }
            else if(index == 16)
            {
               index = 1;
            }
            else if(index == 17)
            {
               index = 2;
            }
            btm = ComponentFactory.Instance.creatBitmap("asset.wasteRecycle.lottery" + index);
            if(i == 0)
            {
               _origin = (95 - btm.height) / 2 - _turn.height;
            }
            btm.x = (95 - btm.width) / 2;
            btm.y = _turn.height + 20;
            _turn.addChild(btm);
            i++;
         }
         _turn.y = _origin;
      }
      
      public function turn(result:int) : void
      {
         _result = result;
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
      
      private function __onEnterFrame(e:Event) : void
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
