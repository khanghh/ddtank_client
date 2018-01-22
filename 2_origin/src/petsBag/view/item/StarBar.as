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
      
      public static var TOTAL_STAR:int = 6;
       
      
      private var _starImgVec:Vector.<Bitmap>;
      
      public function StarBar()
      {
         super();
         _starImgVec = new Vector.<Bitmap>();
      }
      
      public function starNum(param1:int, param2:String = "assets.petsBag.star") : void
      {
         var _loc3_:* = null;
         if(param1 > 0)
         {
            if(param1 > TOTAL_STAR)
            {
               param1 = TOTAL_STAR;
            }
            remove();
            while(true)
            {
               param1--;
               if(!param1)
               {
                  break;
               }
               _loc3_ = ComponentFactory.Instance.creatBitmap(param2);
               _starImgVec.push(_loc3_);
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
         var _loc1_:int = 0;
         var _loc2_:int = _starImgVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            addChild(_starImgVec[_loc1_]);
            _starImgVec[_loc1_].x = _loc1_ * (_starImgVec[_loc1_].width - 3) + SPACE;
            _loc1_++;
         }
      }
      
      private function remove() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _starImgVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            ObjectUtils.disposeObject(_starImgVec[_loc1_]);
            _loc1_++;
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
