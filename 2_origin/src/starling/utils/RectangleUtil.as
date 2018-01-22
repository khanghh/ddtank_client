package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.errors.AbstractClassError;
   
   public class RectangleUtil
   {
      
      private static const sHelperPoint:Point = new Point();
      
      private static const sPositions:Vector.<Point> = new <Point>[new Point(0,0),new Point(1,0),new Point(0,1),new Point(1,1)];
       
      
      public function RectangleUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function intersect(param1:Rectangle, param2:Rectangle, param3:Rectangle = null) : Rectangle
      {
         if(param3 == null)
         {
            param3 = new Rectangle();
         }
         var _loc5_:Number = param1.x > param2.x?param1.x:Number(param2.x);
         var _loc6_:Number = param1.right < param2.right?param1.right:Number(param2.right);
         var _loc7_:Number = param1.y > param2.y?param1.y:Number(param2.y);
         var _loc4_:Number = param1.bottom < param2.bottom?param1.bottom:Number(param2.bottom);
         if(_loc5_ > _loc6_ || _loc7_ > _loc4_)
         {
            param3.setEmpty();
         }
         else
         {
            param3.setTo(_loc5_,_loc7_,_loc6_ - _loc5_,_loc4_ - _loc7_);
         }
         return param3;
      }
      
      public static function fit(param1:Rectangle, param2:Rectangle, param3:String = "showAll", param4:Boolean = false, param5:Rectangle = null) : Rectangle
      {
         if(!ScaleMode.isValid(param3))
         {
            throw new ArgumentError("Invalid scaleMode: " + param3);
         }
         if(param5 == null)
         {
            param5 = new Rectangle();
         }
         var _loc9_:Number = param1.width;
         var _loc6_:Number = param1.height;
         var _loc7_:Number = param2.width / _loc9_;
         var _loc8_:Number = param2.height / _loc6_;
         var _loc10_:* = 1;
         if(param3 == "showAll")
         {
            _loc10_ = Number(_loc7_ < _loc8_?_loc7_:Number(_loc8_));
            if(param4)
            {
               _loc10_ = Number(nextSuitableScaleFactor(_loc10_,false));
            }
         }
         else if(param3 == "noBorder")
         {
            _loc10_ = Number(_loc7_ > _loc8_?_loc7_:Number(_loc8_));
            if(param4)
            {
               _loc10_ = Number(nextSuitableScaleFactor(_loc10_,true));
            }
         }
         _loc9_ = _loc9_ * _loc10_;
         _loc6_ = _loc6_ * _loc10_;
         param5.setTo(param2.x + (param2.width - _loc9_) / 2,param2.y + (param2.height - _loc6_) / 2,_loc9_,_loc6_);
         return param5;
      }
      
      private static function nextSuitableScaleFactor(param1:Number, param2:Boolean) : Number
      {
         var _loc3_:* = 1;
         if(param2)
         {
            if(param1 >= 0.5)
            {
               return Math.ceil(param1);
            }
            while(1 / (_loc3_ + 1) > param1)
            {
               _loc3_++;
            }
         }
         else
         {
            if(param1 >= 1)
            {
               return Math.floor(param1);
            }
            while(1 / _loc3_ > param1)
            {
               _loc3_++;
            }
         }
         return 1 / _loc3_;
      }
      
      public static function normalize(param1:Rectangle) : void
      {
         if(param1.width < 0)
         {
            param1.width = -param1.width;
            param1.x = param1.x - param1.width;
         }
         if(param1.height < 0)
         {
            param1.height = -param1.height;
            param1.y = param1.y - param1.height;
         }
      }
      
      public static function getBounds(param1:Rectangle, param2:Matrix, param3:Rectangle = null) : Rectangle
      {
         var _loc7_:int = 0;
         if(param3 == null)
         {
            param3 = new Rectangle();
         }
         var _loc6_:* = 1.79769313486232e308;
         var _loc5_:* = -1.79769313486232e308;
         var _loc8_:* = 1.79769313486232e308;
         var _loc4_:* = -1.79769313486232e308;
         _loc7_ = 0;
         while(_loc7_ < 4)
         {
            MatrixUtil.transformCoords(param2,sPositions[_loc7_].x * param1.width,sPositions[_loc7_].y * param1.height,sHelperPoint);
            if(_loc6_ > sHelperPoint.x)
            {
               _loc6_ = Number(sHelperPoint.x);
            }
            if(_loc5_ < sHelperPoint.x)
            {
               _loc5_ = Number(sHelperPoint.x);
            }
            if(_loc8_ > sHelperPoint.y)
            {
               _loc8_ = Number(sHelperPoint.y);
            }
            if(_loc4_ < sHelperPoint.y)
            {
               _loc4_ = Number(sHelperPoint.y);
            }
            _loc7_++;
         }
         param3.setTo(_loc6_,_loc8_,_loc5_ - _loc6_,_loc4_ - _loc8_);
         return param3;
      }
   }
}
