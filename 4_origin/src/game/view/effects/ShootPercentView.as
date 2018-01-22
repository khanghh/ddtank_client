package game.view.effects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.BloodNumberCreater;
   
   public class ShootPercentView extends Sprite
   {
       
      
      private var _type:int;
      
      private var _isAdd:Boolean;
      
      private var _picBmp:Bitmap;
      
      private var add:Boolean = true;
      
      private var tmp:int = 0;
      
      public function ShootPercentView(param1:int, param2:int = 1, param3:Boolean = false)
      {
         super();
         _type = param2;
         _isAdd = param3;
         _picBmp = getPercent(param1);
         this.addEventListener("addedToStage",__addToStage);
         if(_picBmp != null)
         {
            addChild(_picBmp);
         }
      }
      
      public function dispose() : void
      {
         if(_picBmp)
         {
            removeEventListener("enterFrame",__enterFrame);
            _picBmp.bitmapData.dispose();
            removeChild(_picBmp);
            _picBmp = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __addToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__addToStage);
         if(_picBmp == null)
         {
            return;
         }
         if(_type == 1)
         {
            _picBmp.x = -70;
            _picBmp.y = -20;
         }
         else
         {
            var _loc2_:* = 0.5;
            _picBmp.scaleY = _loc2_;
            _picBmp.scaleX = _loc2_;
         }
         _picBmp.alpha = 0;
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(_type == 1)
         {
            doShowType1();
         }
         else
         {
            doShowType2();
         }
      }
      
      private function doShowType1() : void
      {
         if(_picBmp.alpha > 0.95)
         {
            tmp = Number(tmp) + 1;
            if(tmp == 20)
            {
               add = false;
               _picBmp.alpha = 0.9;
            }
         }
         if(_picBmp.alpha < 1)
         {
            if(add)
            {
               _picBmp.y = _picBmp.y - 8;
               _picBmp.alpha = _picBmp.alpha + 0.22;
            }
            else
            {
               _picBmp.y = _picBmp.y - 6;
               _picBmp.alpha = _picBmp.alpha - 0.1;
            }
         }
         if(_picBmp.alpha < 0.05)
         {
            dispose();
         }
      }
      
      private function doShowType2() : void
      {
         if(_picBmp.alpha > 0.95)
         {
            tmp = Number(tmp) + 1;
            if(tmp == 20)
            {
               add = false;
               _picBmp.alpha = 0.9;
            }
         }
         if(_picBmp.alpha < 1)
         {
            if(add)
            {
               _picBmp.scaleY = _picBmp.scaleY + 0.24;
               _picBmp.scaleX = _picBmp.scaleY + 0.24;
               _picBmp.alpha = _picBmp.alpha + 0.4;
            }
            else
            {
               _picBmp.scaleY = _picBmp.scaleY + 0.125;
               _picBmp.scaleX = _picBmp.scaleY + 0.125;
               _picBmp.alpha = _picBmp.alpha - 0.15;
            }
            _picBmp.x = -_picBmp.width / 2 + 10;
            _picBmp.y = -_picBmp.height / 2;
         }
         if(_picBmp.alpha < 0.05)
         {
            dispose();
         }
      }
      
      public function getPercent(param1:int) : Bitmap
      {
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc9_:int = 0;
         var _loc4_:* = null;
         if(param1 > 99999999)
         {
            return null;
         }
         var _loc7_:Sprite = new Sprite();
         var _loc11_:Array = [];
         _loc11_ = [0,0,0,0];
         var _loc12_:Boolean = false;
         _loc7_.mouseEnabled = _loc12_;
         _loc7_.mouseChildren = _loc12_;
         if(_type == 2)
         {
            if(!_isAdd)
            {
               _loc6_ = ComponentFactory.Instance.creatBitmap("asset.game.redNumberBackgoundAsset") as Bitmap;
               _loc6_.x = _loc6_.x + 5;
               _loc6_.y = -10;
               _loc11_.push(_loc6_);
            }
         }
         var _loc5_:String = String(param1);
         var _loc8_:int = _loc5_.length;
         var _loc3_:int = 33 + (4 - _loc8_) * 10;
         if(_isAdd)
         {
            _loc5_ = " " + _loc5_;
            _loc8_ = _loc8_ + 1;
            _loc3_ = _loc3_ - 10;
            _loc10_ = ComponentFactory.Instance.creatBitmap("asset.game.addBloodIconAsset") as Bitmap;
            _loc10_.x = _loc3_;
            _loc10_.y = 20;
            _loc11_.push(_loc10_);
         }
         _loc9_ = !!_isAdd?1:0;
         while(_loc9_ < _loc8_)
         {
            if(_isAdd)
            {
               _loc4_ = BloodNumberCreater.createGreenNum(int(_loc5_.charAt(_loc9_)));
            }
            else
            {
               _loc4_ = BloodNumberCreater.createRedNum(int(_loc5_.charAt(_loc9_)));
            }
            _loc4_.smoothing = true;
            _loc4_.x = _loc3_ + _loc9_ * 20;
            _loc4_.y = 20;
            _loc11_.push(_loc4_);
            _loc9_++;
         }
         _loc11_ = returnNum(_loc11_);
         var _loc2_:BitmapData = new BitmapData(_loc11_[2],_loc11_[3],true,0);
         _picBmp = new Bitmap(_loc2_,"auto",true);
         _loc9_ = 4;
         while(_loc9_ < _loc11_.length)
         {
            _loc2_.copyPixels(_loc11_[_loc9_].bitmapData,new Rectangle(0,0,_loc11_[_loc9_].width,_loc11_[_loc9_].height),new Point(_loc11_[_loc9_].x - _loc11_[0],_loc11_[_loc9_].y - _loc11_[1]),null,null,true);
            _loc9_++;
         }
         _picBmp.x = _loc11_[0];
         _picBmp.y = _loc11_[1];
         _loc11_ = null;
         return _picBmp;
      }
      
      private function returnNum(param1:Array) : Array
      {
         var _loc2_:int = 0;
         _loc2_ = 4;
         while(_loc2_ < param1.length)
         {
            param1[0] = param1[0] > param1[_loc2_].x?param1[_loc2_].x:param1[0];
            param1[1] = param1[1] > param1[_loc2_].y?param1[_loc2_].y:param1[1];
            param1[2] = param1[2] > param1[_loc2_].width + param1[_loc2_].x?param1[2]:param1[_loc2_].width + param1[_loc2_].x;
            param1[3] = param1[3] > param1[_loc2_].height + param1[_loc2_].y?param1[3]:param1[_loc2_].height + param1[_loc2_].y;
            _loc2_++;
         }
         param1[2] = param1[2] - param1[0];
         param1[3] = param1[3] - param1[1];
         return param1;
      }
   }
}
