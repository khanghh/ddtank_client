package gameStarling.view.effects
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import gameCommon.BloodNumberCreater;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ShootPercentView3D extends Sprite
   {
       
      
      private var _type:int;
      
      private var _isAdd:Boolean;
      
      private var _picBmp:Sprite;
      
      private var add:Boolean = true;
      
      private var tmp:int = 0;
      
      public function ShootPercentView3D(param1:int, param2:int = 1, param3:Boolean = false)
      {
         super();
         _type = param2;
         _isAdd = param3;
         _picBmp = getPercent(param1);
         addChild(_picBmp);
         this.addEventListener("addedToStage",__addToStage);
      }
      
      override public function dispose() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         StarlingObjectUtils.disposeAllChildren(_picBmp);
         StarlingObjectUtils.disposeObject(_picBmp);
         _picBmp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
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
      
      public function getPercent(param1:int) : Sprite
      {
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:* = null;
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc7_:Sprite = new Sprite();
         _loc7_.touchable = false;
         if(param1 <= 99999999)
         {
            _loc11_ = [];
            _loc11_ = [0,0,0,0];
            _loc4_ = String(param1);
            _loc8_ = _loc4_.length;
            _loc2_ = 33 + (4 - _loc8_) * 10;
            if(_isAdd)
            {
               _loc4_ = " " + _loc4_;
               _loc8_ = _loc8_ + 1;
               _loc2_ = _loc2_ - 10;
               _loc10_ = StarlingMain.instance.createImage("game_blood_addIcon");
               _loc10_.x = _loc2_;
               _loc10_.y = 20;
               _loc11_.push(_loc10_);
            }
            else if(_type == 2)
            {
               _loc6_ = StarlingMain.instance.createImage("game_blood_RBg");
               _loc6_.x = _loc6_.x + 5;
               _loc6_.y = -10;
               _loc11_.push(_loc6_);
            }
            _loc9_ = !!_isAdd?1:0;
            while(_loc9_ < _loc8_)
            {
               if(_isAdd)
               {
                  _loc3_ = BloodNumberCreater.createGreenImageNum(int(_loc4_.charAt(_loc9_)));
               }
               else
               {
                  _loc3_ = BloodNumberCreater.createRedImageNum(int(_loc4_.charAt(_loc9_)));
               }
               _loc3_.x = _loc2_ + _loc9_ * 20;
               _loc3_.y = 20;
               _loc11_.push(_loc3_);
               _loc9_++;
            }
            _loc11_ = returnNum(_loc11_);
            _loc9_ = 4;
            while(_loc9_ < _loc11_.length)
            {
               _loc5_ = new Point(_loc11_[_loc9_].x - _loc11_[0],_loc11_[_loc9_].y - _loc11_[1]);
               PositionUtils.setPos(_loc5_,_loc11_[_loc9_]);
               _loc7_.addChild(_loc11_[_loc9_]);
               _loc9_++;
            }
            _loc7_.x = _loc11_[0];
            _loc7_.y = _loc11_[1];
            _loc11_ = null;
         }
         return _loc7_;
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
