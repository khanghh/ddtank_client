package gameStarling.animations
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.TweenProxyStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.utils.BitmapUtils;
   import flash.display.BitmapData;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class ScaleEffect3D extends Sprite
   {
       
      
      private var src1:Image;
      
      private var src2:Image;
      
      private var _texture:Texture;
      
      private var mainTimeLine:TimelineMax;
      
      private var tp1:TweenProxyStarling;
      
      private var tp2:TweenProxyStarling;
      
      public function ScaleEffect3D(type:int, srcBmd:BitmapData, dir:int = 1)
      {
         super();
         var bmd:BitmapData = srcBmd.clone();
         BitmapUtils.reverseBtimapData(bmd);
         _texture = Texture.fromBitmapData(srcBmd);
         scaleX = dir;
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,1000,600);
         graphics.endFill();
         touchable = false;
         mainTimeLine = new TimelineMax({"useFrames":true});
         if(type == 1)
         {
            runScale();
         }
         else if(type == 2)
         {
            runDownToUp();
         }
         else if(type == 3)
         {
            runRightToLeft();
         }
         else if(type == 4)
         {
            centerToScale();
         }
      }
      
      private function runScale() : void
      {
         src1 = new Image(_texture);
         src2 = new Image(_texture);
         addChild(src1);
         addChild(src2);
         tp1 = new TweenProxyStarling(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp2 = new TweenProxyStarling(src2);
         tp2.registrationX = src2.width / 2;
         tp2.registrationY = src2.height / 2;
         var _loc4_:* = -50;
         tp2.x = _loc4_;
         tp1.x = _loc4_;
         _loc4_ = 750;
         tp2.y = _loc4_;
         tp1.y = _loc4_;
         _loc4_ = 0;
         tp2.alpha = _loc4_;
         tp1.alpha = _loc4_;
         _loc4_ = 1;
         tp2.scaleY = _loc4_;
         _loc4_ = _loc4_;
         tp2.scaleX = _loc4_;
         _loc4_ = _loc4_;
         tp1.scaleY = _loc4_;
         tp1.scaleX = _loc4_;
         var tw1:Array = TweenMax.allTo([tp1,tp2],4,{
            "x":170,
            "y":320,
            "alpha":0.7,
            "scaleX":1.6,
            "scaleY":1.6
         });
         var arr:Array = TweenMax.allTo([tp1,tp2],30,{
            "scaleX":1.7,
            "scaleY":1.7,
            "x":270,
            "y":290
         });
         var arr1:Array = TweenMax.allTo([tp1,tp2],4,{
            "scaleX":3,
            "scaleY":3,
            "alpha":0
         },1);
         mainTimeLine.appendMultiple(tw1);
         mainTimeLine.appendMultiple(arr);
         mainTimeLine.appendMultiple(arr1);
      }
      
      private function runUpToDown() : void
      {
         src1 = new Image(_texture);
         addChild(src1);
         tp1 = new TweenProxyStarling(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 250;
         tp1.y = 0;
         tp1.scale = 2;
         var tw1:Array = TweenMax.allTo([tp1],4,{
            "alpha":1,
            "y":250
         });
         var tw2:Array = TweenMax.allTo([tp1],40,{"y":290});
         var tw3:Array = TweenMax.allTo([tp1],4,{
            "alpha":0,
            "y":700
         });
         mainTimeLine.appendMultiple(tw1);
         mainTimeLine.appendMultiple(tw2);
         mainTimeLine.appendMultiple(tw3);
      }
      
      private function runRightToLeft() : void
      {
         src1 = new Image(_texture);
         addChild(src1);
         tp1 = new TweenProxyStarling(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 1200;
         tp1.y = 270;
         tp1.alpha = 1;
         var tw1:TweenMax = TweenMax.to(tp1,8,{
            "x":170,
            "alpha":1,
            "scaleX":1.8,
            "scaleY":1.8
         });
         var tw2:TweenMax = TweenMax.to(tp1,26,{"x":250});
         var tw3:TweenMax = TweenMax.to(tp1,4,{
            "x":0,
            "alpha":0
         });
         mainTimeLine.append(tw1);
         mainTimeLine.append(tw2);
         mainTimeLine.append(tw3);
      }
      
      private function changeRegist() : void
      {
         tp1.registrationX = src1.width;
         tp1.registrationY = src1.height;
      }
      
      private function runDownToUp() : void
      {
         src1 = new Image(_texture);
         addChild(src1);
         tp1 = new TweenProxyStarling(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 270;
         tp1.y = 1000;
         tp1.scale = 2;
         var tw1:Array = TweenMax.allTo([tp1],4,{
            "alpha":1,
            "y":290
         });
         var tw2:Array = TweenMax.allTo([tp1],22,{"y":250});
         var tw3:Array = TweenMax.allTo([tp1],4,{
            "alpha":0,
            "y":-100
         });
         mainTimeLine.appendMultiple(tw1,8);
         mainTimeLine.appendMultiple(tw2);
         mainTimeLine.appendMultiple(tw3);
      }
      
      private function runLeftToRight(srcBmd:BitmapData) : void
      {
         src1 = new Image(_texture);
         addChild(src1);
         tp1 = new TweenProxyStarling(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 0;
         tp1.y = 270;
         var _loc5_:* = 1.8;
         tp1.scaleY = _loc5_;
         tp1.scaleX = _loc5_;
         tp1.alpha = 0.5;
         var tw1:TweenMax = TweenMax.to(tp1,3,{
            "x":220,
            "alpha":0.8
         });
         var tw2:TweenMax = TweenMax.to(tp1,24,{
            "scaleX":2.1,
            "scaleY":2.1,
            "x":250
         });
         var tw3:TweenMax = TweenMax.to(tp1,5,{
            "scaleX":4,
            "scaleY":4,
            "alpha":0
         });
         mainTimeLine.append(tw1);
         mainTimeLine.append(tw2);
         mainTimeLine.append(tw3);
      }
      
      private function centerToScale() : void
      {
         src1 = new Image(_texture);
         src2 = new Image(_texture);
         addChild(src1);
         addChild(src2);
         tp1 = new TweenProxyStarling(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp2 = new TweenProxyStarling(src2);
         tp2.registrationX = src2.width / 2;
         tp2.registrationY = src2.height / 2;
         var _loc4_:* = 270;
         tp2.x = _loc4_;
         tp1.x = _loc4_;
         _loc4_ = 270;
         tp2.y = _loc4_;
         tp1.y = _loc4_;
         _loc4_ = 0;
         tp2.scaleY = _loc4_;
         _loc4_ = _loc4_;
         tp2.scaleX = _loc4_;
         _loc4_ = _loc4_;
         tp1.scaleY = _loc4_;
         tp1.scaleX = _loc4_;
         _loc4_ = 0.2;
         tp2.alpha = _loc4_;
         tp1.alpha = _loc4_;
         var tw1:Array = TweenMax.allTo([tp1,tp2],6,{
            "scaleX":2,
            "scaleY":2,
            "alpha":0.8
         });
         var tw5:Array = TweenMax.allTo([tp1,tp2],28,{
            "scaleX":2.2,
            "scaleY":2.2
         });
         var tw6:Array = TweenMax.allTo([tp1,tp2],4,{
            "scaleX":3,
            "scaleY":3,
            "alpha":0
         },2);
         mainTimeLine.appendMultiple(tw1);
         mainTimeLine.appendMultiple(tw5);
         mainTimeLine.appendMultiple(tw6);
      }
      
      override public function dispose() : void
      {
         mainTimeLine.complete(true);
         StarlingObjectUtils.disposeObject(src1);
         StarlingObjectUtils.disposeObject(src2);
         StarlingObjectUtils.disposeObject(_texture);
         StarlingObjectUtils.disposeAllChildren(this,true);
         if(parent)
         {
            parent.removeChild(this);
         }
         mainTimeLine = null;
         tp1 = null;
         tp2 = null;
         src1 = null;
         src2 = null;
         _texture = null;
         super.dispose();
      }
   }
}
