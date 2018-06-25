package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StarBar extends Sprite implements Disposeable
   {
      
      public static var SPACE:Number = 0.2;
      
      public static var TOTAL_STAR:int = 5;
       
      
      private var _starImgVec:Vector.<Bitmap>;
      
      public function StarBar()
      {
         super();
         _starImgVec = new Vector.<Bitmap>();
      }
      
      public function starNum(num:int, assetResource:String = "assets.petsBag.star") : void
      {
         var img:* = null;
         if(num > 0)
         {
            if(num > TOTAL_STAR)
            {
               num = TOTAL_STAR;
            }
            remove();
            while(true)
            {
               num--;
               if(!num)
               {
                  break;
               }
               img = ComponentFactory.Instance.creatBitmap(assetResource);
               _starImgVec.push(img);
            }
            update();
         }
         else
         {
            remove();
         }
      }
      
      private function update() : void
      {
         var index:int = 0;
         var count:int = _starImgVec.length;
         for(index = 0; index < count; )
         {
            addChild(_starImgVec[index]);
            _starImgVec[index].x = index * (_starImgVec[index].width - 3) + SPACE;
            index++;
         }
      }
      
      private function remove() : void
      {
         var index:int = 0;
         var count:int = _starImgVec.length;
         for(index = 0; index < count; )
         {
            ObjectUtils.disposeObject(_starImgVec[index]);
            index++;
         }
         _starImgVec.splice(0,_starImgVec.length);
      }
      
      public function dispose() : void
      {
         remove();
         _starImgVec = null;
      }
   }
}
