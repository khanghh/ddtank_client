package game.animations
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.TweenProxy;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.BitmapUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class ScaleEffect extends Sprite implements Disposeable
   {
       
      
      private var src1:Bitmap;
      
      private var src2:Bitmap;
      
      private var mainTimeLine:TimelineMax;
      
      private var tp1:TweenProxy;
      
      private var tp2:TweenProxy;
      
      public function ScaleEffect(param1:int, param2:BitmapData, param3:int = 1)
      {
         super();
         var _loc4_:BitmapData = param2.clone();
         BitmapUtils.reverseBtimapData(_loc4_);
         scaleX = param3;
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,1000,600);
         graphics.endFill();
         mouseChildren = false;
         mouseEnabled = false;
         mainTimeLine = new TimelineMax({"useFrames":true});
         if(param1 == 1)
         {
            runScale(_loc4_);
         }
         else if(param1 == 2)
         {
            runDownToUp(_loc4_);
         }
         else if(param1 == 3)
         {
            runRightToLeft(_loc4_);
         }
         else if(param1 == 4)
         {
            centerToScale(_loc4_);
         }
      }
      
      private function runScale(param1:BitmapData) : void
      {
         src1 = new Bitmap(param1,"auto",true);
         src2 = new Bitmap(param1,"auto",true);
         addChild(src1);
         addChild(src2);
         var _loc5_:* = [new GlowFilter(16763904,1,38,38,0.3)];
         src2.filters = _loc5_;
         src1.filters = _loc5_;
         tp1 = new TweenProxy(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp2 = new TweenProxy(src2);
         tp2.registrationX = src2.width / 2;
         tp2.registrationY = src2.height / 2;
         _loc5_ = -50;
         tp2.x = _loc5_;
         tp1.x = _loc5_;
         _loc5_ = 750;
         tp2.y = _loc5_;
         tp1.y = _loc5_;
         _loc5_ = 0;
         tp2.alpha = _loc5_;
         tp1.alpha = _loc5_;
         _loc5_ = 1;
         tp2.scaleY = _loc5_;
         _loc5_ = _loc5_;
         tp2.scaleX = _loc5_;
         _loc5_ = _loc5_;
         tp1.scaleY = _loc5_;
         tp1.scaleX = _loc5_;
         var _loc3_:Array = TweenMax.allTo([tp1,tp2],4,{
            "x":170,
            "y":320,
            "alpha":0.7,
            "scaleX":1.6,
            "scaleY":1.6
         });
         var _loc2_:Array = TweenMax.allTo([tp1,tp2],30,{
            "scaleX":1.7,
            "scaleY":1.7,
            "x":170,
            "y":290
         });
         var _loc4_:Array = TweenMax.allTo([tp1,tp2],4,{
            "scaleX":3,
            "scaleY":3,
            "alpha":0
         },1);
         mainTimeLine.appendMultiple(_loc3_);
         mainTimeLine.appendMultiple(_loc2_);
         mainTimeLine.appendMultiple(_loc4_);
      }
      
      private function runUpToDown(param1:BitmapData) : void
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0,1);
         _loc2_.graphics.drawRect(0,0,1000,100);
         _loc2_.graphics.drawRect(0,500,1000,100);
         _loc2_.graphics.endFill();
         src1 = new Bitmap(param1,"auto",true);
         addChild(src1);
         tp1 = new TweenProxy(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 250;
         tp1.y = 0;
         tp1.scale = 2;
         var _loc4_:Array = TweenMax.allTo([tp1],4,{
            "alpha":1,
            "y":250
         });
         var _loc3_:Array = TweenMax.allTo([tp1],40,{"y":290});
         var _loc5_:Array = TweenMax.allTo([tp1],4,{
            "alpha":0,
            "y":700
         });
         mainTimeLine.appendMultiple(_loc4_);
         mainTimeLine.appendMultiple(_loc3_);
         mainTimeLine.appendMultiple(_loc5_);
      }
      
      private function runRightToLeft(param1:BitmapData) : void
      {
         src1 = new Bitmap(param1,"auto",true);
         addChild(src1);
         tp1 = new TweenProxy(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 1200;
         tp1.y = 270;
         tp1.alpha = 1;
         var _loc3_:TweenMax = TweenMax.to(tp1,8,{
            "x":170,
            "alpha":1,
            "scaleX":1.8,
            "scaleY":1.8
         });
         var _loc2_:TweenMax = TweenMax.to(tp1,26,{"x":150});
         var _loc4_:TweenMax = TweenMax.to(tp1,4,{
            "x":0,
            "alpha":0
         });
         mainTimeLine.append(_loc3_);
         mainTimeLine.append(_loc2_);
         mainTimeLine.append(_loc4_);
      }
      
      private function changeRegist() : void
      {
         tp1.registrationX = src1.width;
         tp1.registrationY = src1.height;
      }
      
      private function runDownToUp(param1:BitmapData) : void
      {
         src1 = new Bitmap(param1,"auto",true);
         addChild(src1);
         tp1 = new TweenProxy(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 170;
         tp1.y = 1000;
         tp1.scale = 2;
         var _loc3_:Array = TweenMax.allTo([tp1],4,{
            "alpha":1,
            "y":290
         });
         var _loc2_:Array = TweenMax.allTo([tp1],22,{"y":250});
         var _loc4_:Array = TweenMax.allTo([tp1],4,{
            "alpha":0,
            "y":-100
         });
         mainTimeLine.appendMultiple(_loc3_,8);
         mainTimeLine.appendMultiple(_loc2_);
         mainTimeLine.appendMultiple(_loc4_);
      }
      
      private function runLeftToRight(param1:BitmapData) : void
      {
         src1 = new Bitmap(param1,"auto",true);
         addChild(src1);
         tp1 = new TweenProxy(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp1.x = 0;
         tp1.y = 270;
         var _loc5_:* = 1.8;
         tp1.scaleY = _loc5_;
         tp1.scaleX = _loc5_;
         tp1.alpha = 0.5;
         var _loc3_:TweenMax = TweenMax.to(tp1,3,{
            "x":220,
            "alpha":0.8
         });
         var _loc2_:TweenMax = TweenMax.to(tp1,24,{
            "scaleX":2.1,
            "scaleY":2.1,
            "x":240
         });
         var _loc4_:TweenMax = TweenMax.to(tp1,5,{
            "scaleX":4,
            "scaleY":4,
            "alpha":0
         });
         mainTimeLine.append(_loc3_);
         mainTimeLine.append(_loc2_);
         mainTimeLine.append(_loc4_);
      }
      
      private function centerToScale(param1:BitmapData) : void
      {
         src1 = new Bitmap(param1,"auto",true);
         src2 = new Bitmap(param1,"auto",true);
         addChild(src1);
         addChild(src2);
         var _loc5_:* = [new GlowFilter(16763904,1,40,40,0.3)];
         src2.filters = _loc5_;
         src1.filters = _loc5_;
         tp1 = new TweenProxy(src1);
         tp1.registrationX = src1.width / 2;
         tp1.registrationY = src1.height / 2;
         tp2 = new TweenProxy(src2);
         tp2.registrationX = src2.width / 2;
         tp2.registrationY = src2.height / 2;
         _loc5_ = 170;
         tp2.x = _loc5_;
         tp1.x = _loc5_;
         _loc5_ = 270;
         tp2.y = _loc5_;
         tp1.y = _loc5_;
         _loc5_ = 0;
         tp2.scaleY = _loc5_;
         _loc5_ = _loc5_;
         tp2.scaleX = _loc5_;
         _loc5_ = _loc5_;
         tp1.scaleY = _loc5_;
         tp1.scaleX = _loc5_;
         _loc5_ = 0.2;
         tp2.alpha = _loc5_;
         tp1.alpha = _loc5_;
         var _loc2_:Array = TweenMax.allTo([tp1,tp2],6,{
            "scaleX":2,
            "scaleY":2,
            "alpha":0.8
         });
         var _loc3_:Array = TweenMax.allTo([tp1,tp2],28,{
            "scaleX":2.2,
            "scaleY":2.2
         });
         var _loc4_:Array = TweenMax.allTo([tp1,tp2],4,{
            "scaleX":3,
            "scaleY":3,
            "alpha":0
         },2);
         mainTimeLine.appendMultiple(_loc2_);
         mainTimeLine.appendMultiple(_loc3_);
         mainTimeLine.appendMultiple(_loc4_);
      }
      
      public function dispose() : void
      {
         mainTimeLine.complete(true);
         mainTimeLine = null;
         tp1 = null;
         tp2 = null;
         if(src1)
         {
            if(src1.parent)
            {
               src1.parent.removeChild(src1);
            }
            try
            {
               src1.bitmapData.dispose();
            }
            catch(e:Error)
            {
            }
            src1 = null;
         }
         if(src2)
         {
            if(src2.parent)
            {
               src2.parent.removeChild(src2);
            }
            try
            {
               src2.bitmapData.dispose();
            }
            catch(e:Error)
            {
            }
            src2 = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
