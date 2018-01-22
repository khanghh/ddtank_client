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
         var _loc3_:int = 0;
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         var _loc2_:ConsortiaRoseConfig = ComponentFactory.Instance.creatCustomObject("consortia.rose.config");
         _frameRate = _loc2_.frameRate;
         _totalFrames = _loc2_.totalFrames;
         _row1Number = _loc2_.row1Number;
         _row2Number = _loc2_.row2Number;
         _row3Number = _loc2_.row3Number;
         _speed1 = _loc2_.speed1;
         _speed2 = _loc2_.speed2;
         _speed3 = _loc2_.speed3;
         _scale1 = _loc2_.scale1;
         _scale2 = _loc2_.scale2;
         _scale3 = _loc2_.scale3;
         var _loc1_:* = 0;
         _resVec = new Vector.<BitmapData>();
         _loc3_ = 0;
         while(_loc3_ < _totalFrames)
         {
            _resVec[_loc3_] = ComponentFactory.Instance.creatBitmapData("ast.rose.f" + _loc3_.toString());
            _loc3_++;
         }
         _roseRow3Vec = new Vector.<ConsortiaRose>();
         _loc3_ = 0;
         while(_loc3_ < _row3Number)
         {
            _loc1_ = Number(int(Math.random() * _totalFrames));
            _roseRow3Vec[_loc3_] = new ConsortiaRose(_resVec[_loc1_]);
            _roseRow3Vec[_loc3_].rotation = Math.random() * 360;
            _roseRow3Vec[_loc3_].curFrame = _loc1_;
            var _loc4_:* = _scale3;
            _roseRow3Vec[_loc3_].scaleY = _loc4_;
            _roseRow3Vec[_loc3_].scaleX = _loc4_;
            _roseRow3Vec[_loc3_].alpha = 1;
            _roseRow3Vec[_loc3_].x = Math.random() * 860 + 70;
            _roseRow3Vec[_loc3_].y = -730 * Math.random();
            addChild(_roseRow3Vec[_loc3_]);
            _loc3_++;
         }
         _row3StepPt = new Vector.<Point>();
         _loc3_ = 0;
         while(_loc3_ < _row3Number)
         {
            _row3StepPt[_loc3_] = new Point(0,_speed3);
            _loc3_++;
         }
         _roseRow2Vec = new Vector.<ConsortiaRose>();
         _loc3_ = 0;
         while(_loc3_ < _row2Number)
         {
            _loc1_ = Number(int(Math.random() * _totalFrames));
            _roseRow2Vec[_loc3_] = new ConsortiaRose(_resVec[_loc1_]);
            _roseRow2Vec[_loc3_].rotation = Math.random() * 360;
            _roseRow2Vec[_loc3_].curFrame = _loc1_;
            _loc4_ = _scale2;
            _roseRow2Vec[_loc3_].scaleY = _loc4_;
            _roseRow2Vec[_loc3_].scaleX = _loc4_;
            _roseRow2Vec[_loc3_].alpha = 1;
            _roseRow2Vec[_loc3_].x = Math.random() * 860 + 70;
            _roseRow2Vec[_loc3_].y = -730 * Math.random();
            addChild(_roseRow2Vec[_loc3_]);
            _loc3_++;
         }
         _row2StepPt = new Vector.<Point>();
         _loc3_ = 0;
         while(_loc3_ < _row2Number)
         {
            _row2StepPt[_loc3_] = new Point(int(Math.random() * 3 - 1.5),_speed2);
            _loc3_++;
         }
         _roseRow1Vec = new Vector.<ConsortiaRose>();
         _loc3_ = 0;
         while(_loc3_ < _row1Number)
         {
            _loc1_ = Number(int(Math.random() * _totalFrames));
            _roseRow1Vec[_loc3_] = new ConsortiaRose(_resVec[_loc1_]);
            _roseRow1Vec[_loc3_].rotation = Math.random() * 360;
            _roseRow1Vec[_loc3_].curFrame = _loc1_;
            _loc4_ = _scale1;
            _roseRow1Vec[_loc3_].scaleY = _loc4_;
            _roseRow1Vec[_loc3_].scaleX = _loc4_;
            _roseRow1Vec[_loc3_].alpha = 1;
            _roseRow1Vec[_loc3_].x = Math.random() * 860 + 70;
            _roseRow1Vec[_loc3_].y = -730 * Math.random();
            addChild(_roseRow1Vec[_loc3_]);
            _loc3_++;
         }
         _row1StepPt = new Vector.<Point>();
         _loc3_ = 0;
         while(_loc3_ < _row1Number)
         {
            _row1StepPt[_loc3_] = new Point(int(Math.random() * 4 - 2),_speed1);
            _loc3_++;
         }
      }
      
      protected function onEF(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _count = Number(_count) + 1;
         _count = _count % 2;
         if(_count == 0)
         {
            return;
         }
         _loc3_ = _roseRow1Vec.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _roseRow1Vec[_loc4_];
            _loc2_.curFrame = Number(_loc2_.curFrame) + 1;
            _loc2_.curFrame = _loc2_.curFrame % _totalFrames;
            _loc2_.bitmapData = _resVec[_loc2_.curFrame];
            _loc2_.x = _loc2_.x + _row1StepPt[_loc4_].x;
            _loc2_.y = _loc2_.y + _row1StepPt[_loc4_].y;
            if(_loc2_.y > 600)
            {
               _loc2_.y = -150;
               _loc2_.rotation = Math.random() * 180;
            }
            if(_loc2_.x < -150 || _loc2_.y > 1150)
            {
               _loc2_.x = Math.random() * 860 + 70;
            }
            _loc4_++;
         }
         _loc3_ = _roseRow2Vec.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _roseRow2Vec[_loc4_];
            _loc2_.curFrame = Number(_loc2_.curFrame) + 1;
            _loc2_.curFrame = _loc2_.curFrame % _totalFrames;
            _loc2_.bitmapData = _resVec[_loc2_.curFrame];
            _loc2_.x = _loc2_.x + _row2StepPt[_loc4_].x;
            _loc2_.y = _loc2_.y + _row2StepPt[_loc4_].y;
            if(_loc2_.y > 600)
            {
               _loc2_.y = -150;
               _loc2_.rotation = Math.random() * 180;
            }
            if(_loc2_.x < -150 || _loc2_.y > 1150)
            {
               _loc2_.x = Math.random() * 860 + 70;
            }
            _loc4_++;
         }
         _loc3_ = _roseRow3Vec.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _roseRow3Vec[_loc4_];
            _loc2_.curFrame = Number(_loc2_.curFrame) + 1;
            _loc2_.curFrame = _loc2_.curFrame % _totalFrames;
            _loc2_.bitmapData = _resVec[_loc2_.curFrame];
            _loc2_.x = _loc2_.x + _row3StepPt[_loc4_].x;
            _loc2_.y = _loc2_.y + _row3StepPt[_loc4_].y;
            if(_loc2_.y > 600)
            {
               _loc2_.y = -150;
               _loc2_.rotation = Math.random() * 180;
            }
            if(_loc2_.x < -150 || _loc2_.y > 1150)
            {
               _loc2_.x = Math.random() * 860 + 70;
            }
            _loc4_++;
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
