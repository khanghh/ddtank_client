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
      
      public function ExpTotalNums(type:int)
      {
         super();
         _type = type;
         init();
      }
      
      private function init() : void
      {
         var str:* = null;
         var i:int = 0;
         _operator = new Bitmap();
         _bitmaps = new Vector.<Bitmap>(5);
         _bitmapDatas = new Vector.<BitmapData>();
         if(_type == 0)
         {
            str = "asset.experience.TotalExpNum_";
            _bg = ComponentFactory.Instance.creat("asset.experience.TotalExpTxtLight");
         }
         else
         {
            str = "asset.experience.TotalExploitNum_";
            _bg = ComponentFactory.Instance.creat("asset.experience.TotalExploitTxtLight");
         }
         PositionUtils.setPos(_bg,"experience.TotalTextLightPos");
         addChildAt(_bg,0);
         for(i = 0; i < 10; )
         {
            _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData(str + String(i)));
            i++;
         }
         _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData(str + "+"));
         _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData(str + "-"));
      }
      
      public function playLight() : void
      {
         _bg.gotoAndPlay(2);
      }
      
      public function setValue(value:int) : void
      {
         var strArr:* = null;
         var i:int = 0;
         if(value > maxValue)
         {
            _value = maxValue;
         }
         else
         {
            _value = value;
         }
         var posX:int = 0;
         var offset:int = 20;
         if(_value >= 0)
         {
            _operator.bitmapData = _bitmapDatas[10];
         }
         else
         {
            _operator.bitmapData = _bitmapDatas[11];
         }
         addChild(_operator);
         posX = posX + offset;
         _value = Math.abs(_value);
         strArr = _value.toString().split("");
         for(i = 0; i < strArr.length; )
         {
            if(_bitmaps[i] == null)
            {
               _bitmaps[i] = new Bitmap();
            }
            _bitmaps[i].bitmapData = _bitmapDatas[int(strArr[i])];
            _bitmaps[i].x = posX;
            posX = posX + offset;
            addChild(_bitmaps[i]);
            i++;
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
