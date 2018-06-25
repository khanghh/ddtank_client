package game.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import game.animations.DirectionMovingAnimation;
   import game.view.map.MapView;
   
   public class SpringArrowView extends Sprite
   {
       
      
      private var _rect:Shape;
      
      private var _arrow:Bitmap;
      
      private var _map:MapView;
      
      private var _direction:String;
      
      private var _anit:DirectionMovingAnimation;
      
      private var _hand:MovieClip;
      
      private var _allowDrag:Boolean;
      
      public function SpringArrowView(direction:String, map:MapView = null)
      {
         super();
         _direction = direction;
         initView();
         initEvent();
         _map = map;
      }
      
      public function set allowDrag(value:Boolean) : void
      {
         _allowDrag = value;
      }
      
      private function initView() : void
      {
         _rect = new Shape();
         _rect.graphics.beginFill(0,1);
         _rect.graphics.drawRect(-66,-32,132,63);
         _rect.graphics.endFill();
         _rect.alpha = 0;
         addChild(_rect);
         _arrow = ComponentFactory.Instance.creatBitmap("asset.game.springArrowAsset");
         _hand = ComponentFactory.Instance.creatCustomObject("asset.game.handHotAsset");
         _hand.mouseChildren = false;
         _hand.mouseEnabled = false;
         buttonMode = true;
         useHandCursor = true;
         var _loc1_:* = _direction;
         if("left" !== _loc1_)
         {
            if("right" !== _loc1_)
            {
               if("up" !== _loc1_)
               {
                  if("down" === _loc1_)
                  {
                     _arrow.rotation = 90;
                     _rect.rotation = 90;
                     x = StageReferance.stageWidth / 2;
                     y = StageReferance.stageHeight - height / 2 - 90;
                     _hand.x = _arrow.x - 30;
                     _hand.y = _arrow.y;
                  }
               }
               else
               {
                  _arrow.rotation = -90;
                  _rect.rotation = -90;
                  x = StageReferance.stageWidth / 2;
                  y = height / 2 + 20;
                  _hand.x = _arrow.x;
                  _hand.y = _arrow.y - 20;
               }
            }
            else
            {
               x = StageReferance.stageWidth - width / 2 - 60;
               y = StageReferance.stageHeight / 2;
               _hand.x = _arrow.x + 4;
               _hand.y = _arrow.y - 4;
            }
         }
         else
         {
            _arrow.rotation = 180;
            _arrow.x = _arrow.x - 20;
            _hand.x = _arrow.x - 22;
            _hand.y = _arrow.y - 28;
            x = width / 2 + 10;
            y = StageReferance.stageHeight / 2 + 10;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__over,false,0,true);
         addEventListener("mouseOut",__out,false,0,true);
         addEventListener("mouseDown",__down,false,0,true);
         addEventListener("mouseUp",__up,false,0,true);
      }
      
      private function __over(event:MouseEvent) : void
      {
         addChild(_arrow);
         addChild(_hand);
      }
      
      private function __out(event:MouseEvent) : void
      {
         if(_arrow.parent)
         {
            _arrow.parent.removeChild(_arrow);
         }
         if(_hand.parent)
         {
            _hand.parent.removeChild(_hand);
         }
         if(_anit)
         {
            _anit.cancel();
            _anit = null;
         }
      }
      
      private function __up(event:MouseEvent) : void
      {
         if(_anit)
         {
            _anit.cancel();
            _anit = null;
         }
         addChild(_hand);
      }
      
      private function __down(event:MouseEvent) : void
      {
         if(_allowDrag)
         {
            _anit = new DirectionMovingAnimation(_direction);
            _map.animateSet.addAnimation(_anit);
            if(_hand.parent)
            {
               _hand.parent.removeChild(_hand);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__over);
         removeEventListener("mouseOut",__out);
         removeEventListener("mouseDown",__down);
         removeEventListener("mouseUp",__up);
         removeChild(_rect);
         _rect = null;
         if(_arrow.parent)
         {
            removeChild(_arrow);
         }
         _arrow.bitmapData.dispose();
         _arrow = null;
         if(_hand.parent)
         {
            removeChild(_hand);
         }
         _hand.stop();
         _hand = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _map = null;
         _anit = null;
      }
   }
}
