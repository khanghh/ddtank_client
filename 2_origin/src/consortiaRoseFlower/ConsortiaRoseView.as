package consortiaRoseFlower
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ConsortiaRoseView extends Sprite
   {
       
      
      private var _resVec:Vector.<BitmapData>;
      
      private var _roseRow1Vec:Vector.<ConsortiaRose>;
      
      private var _roseRow2Vec:Vector.<ConsortiaRose>;
      
      private var _roseRow3Vec:Vector.<ConsortiaRose>;
      
      private var _row1StepPt:Vector.<Point>;
      
      private var _row2StepPt:Vector.<Point>;
      
      private var _row3StepPt:Vector.<Point>;
      
      private var _frameRate:Number;
      
      private var _totalFrames:Number;
      
      private var _row1Number:Number;
      
      private var _row2Number:Number;
      
      private var _row3Number:Number;
      
      private var _speed1:Number;
      
      private var _speed2:Number;
      
      private var _speed3:Number;
      
      private var _scale1:Number;
      
      private var _scale2:Number;
      
      private var _scale3:Number;
      
      private var _count:Number = 0;
      
      public function ConsortiaRoseView()
      {
         var i:int = 0;
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         var config:ConsortiaRoseConfig = ComponentFactory.Instance.creatCustomObject("consortia.rose.config");
         _frameRate = config.frameRate;
         _totalFrames = config.totalFrames;
         _row1Number = config.row1Number;
         _row2Number = config.row2Number;
         _row3Number = config.row3Number;
         _speed1 = config.speed1;
         _speed2 = config.speed2;
         _speed3 = config.speed3;
         _scale1 = config.scale1;
         _scale2 = config.scale2;
         _scale3 = config.scale3;
         var curFrame:* = 0;
         _resVec = new Vector.<BitmapData>();
         for(i = 0; i < _totalFrames; )
         {
            _resVec[i] = ComponentFactory.Instance.creatBitmapData("ast.rose.f" + i.toString());
            i++;
         }
         _roseRow3Vec = new Vector.<ConsortiaRose>();
         for(i = 0; i < _row3Number; )
         {
            curFrame = Number(int(Math.random() * _totalFrames));
            _roseRow3Vec[i] = new ConsortiaRose(_resVec[curFrame]);
            _roseRow3Vec[i].rotation = Math.random() * 360;
            _roseRow3Vec[i].curFrame = curFrame;
            var _loc4_:* = _scale3;
            _roseRow3Vec[i].scaleY = _loc4_;
            _roseRow3Vec[i].scaleX = _loc4_;
            _roseRow3Vec[i].alpha = 1;
            _roseRow3Vec[i].x = Math.random() * 860 + 70;
            _roseRow3Vec[i].y = -730 * Math.random();
            addChild(_roseRow3Vec[i]);
            i++;
         }
         _row3StepPt = new Vector.<Point>();
         for(i = 0; i < _row3Number; )
         {
            _row3StepPt[i] = new Point(0,_speed3);
            i++;
         }
         _roseRow2Vec = new Vector.<ConsortiaRose>();
         for(i = 0; i < _row2Number; )
         {
            curFrame = Number(int(Math.random() * _totalFrames));
            _roseRow2Vec[i] = new ConsortiaRose(_resVec[curFrame]);
            _roseRow2Vec[i].rotation = Math.random() * 360;
            _roseRow2Vec[i].curFrame = curFrame;
            _loc4_ = _scale2;
            _roseRow2Vec[i].scaleY = _loc4_;
            _roseRow2Vec[i].scaleX = _loc4_;
            _roseRow2Vec[i].alpha = 1;
            _roseRow2Vec[i].x = Math.random() * 860 + 70;
            _roseRow2Vec[i].y = -730 * Math.random();
            addChild(_roseRow2Vec[i]);
            i++;
         }
         _row2StepPt = new Vector.<Point>();
         for(i = 0; i < _row2Number; )
         {
            _row2StepPt[i] = new Point(int(Math.random() * 3 - 1.5),_speed2);
            i++;
         }
         _roseRow1Vec = new Vector.<ConsortiaRose>();
         for(i = 0; i < _row1Number; )
         {
            curFrame = Number(int(Math.random() * _totalFrames));
            _roseRow1Vec[i] = new ConsortiaRose(_resVec[curFrame]);
            _roseRow1Vec[i].rotation = Math.random() * 360;
            _roseRow1Vec[i].curFrame = curFrame;
            _loc4_ = _scale1;
            _roseRow1Vec[i].scaleY = _loc4_;
            _roseRow1Vec[i].scaleX = _loc4_;
            _roseRow1Vec[i].alpha = 1;
            _roseRow1Vec[i].x = Math.random() * 860 + 70;
            _roseRow1Vec[i].y = -730 * Math.random();
            addChild(_roseRow1Vec[i]);
            i++;
         }
         _row1StepPt = new Vector.<Point>();
         for(i = 0; i < _row1Number; )
         {
            _row1StepPt[i] = new Point(int(Math.random() * 4 - 2),_speed1);
            i++;
         }
      }
      
      protected function onEF(e:Event) : void
      {
         var rose:* = null;
         var len:int = 0;
         var i:int = 0;
         _count = Number(_count) + 1;
         _count = _count % 2;
         if(_count == 0)
         {
            return;
         }
         len = _roseRow1Vec.length;
         for(i = 0; i < len; )
         {
            rose = _roseRow1Vec[i];
            rose.curFrame = Number(rose.curFrame) + 1;
            rose.curFrame = rose.curFrame % _totalFrames;
            rose.bitmapData = _resVec[rose.curFrame];
            rose.x = rose.x + _row1StepPt[i].x;
            rose.y = rose.y + _row1StepPt[i].y;
            if(rose.y > 600)
            {
               rose.y = -150;
               rose.rotation = Math.random() * 180;
            }
            if(rose.x < -150 || rose.y > 1150)
            {
               rose.x = Math.random() * 860 + 70;
            }
            i++;
         }
         len = _roseRow2Vec.length;
         for(i = 0; i < len; )
         {
            rose = _roseRow2Vec[i];
            rose.curFrame = Number(rose.curFrame) + 1;
            rose.curFrame = rose.curFrame % _totalFrames;
            rose.bitmapData = _resVec[rose.curFrame];
            rose.x = rose.x + _row2StepPt[i].x;
            rose.y = rose.y + _row2StepPt[i].y;
            if(rose.y > 600)
            {
               rose.y = -150;
               rose.rotation = Math.random() * 180;
            }
            if(rose.x < -150 || rose.y > 1150)
            {
               rose.x = Math.random() * 860 + 70;
            }
            i++;
         }
         len = _roseRow3Vec.length;
         for(i = 0; i < len; )
         {
            rose = _roseRow3Vec[i];
            rose.curFrame = Number(rose.curFrame) + 1;
            rose.curFrame = rose.curFrame % _totalFrames;
            rose.bitmapData = _resVec[rose.curFrame];
            rose.x = rose.x + _row3StepPt[i].x;
            rose.y = rose.y + _row3StepPt[i].y;
            if(rose.y > 600)
            {
               rose.y = -150;
               rose.rotation = Math.random() * 180;
            }
            if(rose.x < -150 || rose.y > 1150)
            {
               rose.x = Math.random() * 860 + 70;
            }
            i++;
         }
      }
      
      public function startFly() : void
      {
         _frameRate = StageReferance.stage.frameRate;
         StageReferance.stage.frameRate = 24;
         StageReferance.stage.addEventListener("enterFrame",onEF);
      }
      
      public function stopFly() : void
      {
         StageReferance.stage.frameRate = _frameRate;
         StageReferance.stage.removeEventListener("enterFrame",onEF);
      }
   }
}
