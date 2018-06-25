package morn.core.ex
{
   import flash.display.DisplayObject;
   
   public class TabEx extends GroupEx
   {
      
      public static const HORIZENTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
       
      
      protected var _offset:String;
      
      public function TabEx(imageLabels:String = null, skin:String = null)
      {
         super(imageLabels,skin);
         _direction = "horizontal";
      }
      
      override protected function createItem(skin:String, imageLabel:String) : DisplayObject
      {
         return new ButtonEx(skin,imageLabel);
      }
      
      public function set offset(value:String) : void
      {
         if(_offset != value)
         {
            _offset = value;
            callLater(changeImageLabels);
         }
      }
      
      public function get offset() : String
      {
         return _offset;
      }
      
      override protected function changeImageLabels() : void
      {
         var left:* = NaN;
         var imgLabels:* = null;
         var skinArr:* = null;
         var offsetArr:* = null;
         var offsetValue:* = NaN;
         var i:int = 0;
         var n:int = 0;
         var btn:* = null;
         if(_items)
         {
            left = 0;
            imgLabels = imageLabels.split(",");
            skinArr = _skin.split(",");
            offsetArr = !!_offset?_offset.split(","):[];
            offsetValue = 0;
            for(i = 0,n = _items.length; i < n; )
            {
               btn = _items[i] as ButtonEx;
               if(skinArr && skinArr.length > i)
               {
                  btn.skin = skinArr[i];
               }
               if(imgLabels && imgLabels.length > i)
               {
                  btn.imageLabel = imgLabels[i];
               }
               if(offsetArr && offsetArr.length > i)
               {
                  offsetValue = Number(offsetArr[i]);
               }
               if(_direction == "horizontal")
               {
                  btn.y = 0;
                  btn.x = left;
                  left = Number(left + (btn.width + _space + offsetValue));
               }
               else
               {
                  btn.x = 0;
                  btn.y = left;
                  left = Number(left + (btn.height + _space + offsetValue));
               }
               i++;
            }
         }
      }
   }
}
