package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ExpTotalNums extends Sprite implements Disposeable
   {
      
      public static const EXPERIENCE:uint = 0;
      
      public static const EXPLOIT:uint = 1;
       
      
      public var maxValue:int;
      
      private var _value:int;
      
      private var _type:int;
      
      private var _bg:MovieClip;
      
      private var _operator:Bitmap;
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _bitmapDatas:Vector.<BitmapData>;
      
      public function ExpTotalNums(param1:int)
      {
         super();
         _type = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _operator = new Bitmap();
         _bitmaps = new Vector.<Bitmap>(5);
         _bitmapDatas = new Vector.<BitmapData>();
         if(_type == 0)
         {
            _loc1_ = "asset.experience.TotalExpNum_";
            _bg = ComponentFactory.Instance.creat("asset.experience.TotalExpTxtLight");
         }
         else
         {
            _loc1_ = "asset.experience.TotalExploitNum_";
            _bg = ComponentFactory.Instance.creat("asset.experience.TotalExploitTxtLight");
         }
         PositionUtils.setPos(_bg,"experience.TotalTextLightPos");
         addChildAt(_bg,0);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData(_loc1_ + String(_loc2_)));
            _loc2_++;
         }
         _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData(_loc1_ + "+"));
         _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData(_loc1_ + "-"));
      }
      
      public function playLight() : void
      {
         _bg.gotoAndPlay(2);
      }
      
      public function setValue(param1:int) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         if(param1 > maxValue)
         {
            _value = maxValue;
         }
         else
         {
            _value = param1;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 20;
         if(_value >= 0)
         {
            _operator.bitmapData = _bitmapDatas[10];
         }
         else
         {
            _operator.bitmapData = _bitmapDatas[11];
         }
         addChild(_operator);
         _loc2_ = _loc2_ + _loc3_;
         _value = Math.abs(_value);
         _loc5_ = _value.toString().split("");
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(_bitmaps[_loc4_] == null)
            {
               _bitmaps[_loc4_] = new Bitmap();
            }
            _bitmaps[_loc4_].bitmapData = _bitmapDatas[int(_loc5_[_loc4_])];
            _bitmaps[_loc4_].x = _loc2_;
            _loc2_ = _loc2_ + _loc3_;
            addChild(_bitmaps[_loc4_]);
            _loc4_++;
         }
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg = null;
         }
         if(_operator)
         {
            if(_operator.parent)
            {
               _operator.parent.removeChild(_operator);
            }
            _operator.bitmapData.dispose();
            _operator = null;
         }
         _bitmapDatas = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
