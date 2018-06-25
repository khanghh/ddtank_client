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
         var i:int = 0;
         var rec:* = null;
         var p:* = null;
         var data:* = null;
         super();
         _list = new Vector.<BitmapData>();
         x = 40;
         y = 239;
         rotation = -20;
         _bitMapData = ComponentFactory.Instance.creatBitmapData("fristRecharge.str8");
         var t_width:int = _bitMapData.width / 10;
         var t_height:int = _bitMapData.height;
         for(i = 0; i < 10; )
         {
            rec = new Rectangle(t_width * i,0,t_width,t_height);
            p = new Point(0,0);
            data = new BitmapData(t_width,t_height);
            data.copyPixels(_bitMapData,rec,p);
            _list.push(data);
            i++;
         }
      }
      
      public function setNum(str:String) : void
      {
         var i:int = 0;
         var t:int = 0;
         var data:* = null;
         var bitMap:* = null;
         clear();
         var len:int = str.length;
         for(i = 0; i < len; )
         {
            t = str.charAt(i);
            data = _list[t].clone();
            bitMap = new Bitmap(data);
            bitMap.x = i * (bitMap.width - 8);
            bitMap.smoothing = true;
            addChild(bitMap);
            i++;
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
