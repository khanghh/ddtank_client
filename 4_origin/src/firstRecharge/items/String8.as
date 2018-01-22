package firstRecharge.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class String8 extends Sprite
   {
       
      
      private var _bitMapData:BitmapData;
      
      private var _list:Vector.<BitmapData>;
      
      public function String8()
      {
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         super();
         _list = new Vector.<BitmapData>();
         x = 40;
         y = 239;
         rotation = -20;
         _bitMapData = ComponentFactory.Instance.creatBitmapData("fristRecharge.str8");
         var _loc3_:int = _bitMapData.width / 10;
         var _loc2_:int = _bitMapData.height;
         _loc6_ = 0;
         while(_loc6_ < 10)
         {
            _loc1_ = new Rectangle(_loc3_ * _loc6_,0,_loc3_,_loc2_);
            _loc4_ = new Point(0,0);
            _loc5_ = new BitmapData(_loc3_,_loc2_);
            _loc5_.copyPixels(_bitMapData,_loc1_,_loc4_);
            _list.push(_loc5_);
            _loc6_++;
         }
      }
      
      public function setNum(param1:String) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         clear();
         var _loc4_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = param1.charAt(_loc6_);
            _loc3_ = _list[_loc2_].clone();
            _loc5_ = new Bitmap(_loc3_);
            _loc5_.x = _loc6_ * (_loc5_.width - 8);
            _loc5_.smoothing = true;
            addChild(_loc5_);
            _loc6_++;
         }
      }
      
      public function clear() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
