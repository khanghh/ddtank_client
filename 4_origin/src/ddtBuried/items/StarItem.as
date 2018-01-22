package ddtBuried.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class StarItem extends Sprite
   {
       
      
      private var _list:Vector.<MovieClip>;
      
      public function StarItem()
      {
         super();
         initStarList();
      }
      
      private function initStarList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _list = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creat("buried.core.improveEffect");
            _loc1_.x = (_loc1_.width + 2) * _loc2_;
            _loc1_.stop();
            addChild(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function clearMc() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _list[_loc2_].stop();
            while(_list[_loc2_].numChildren)
            {
               if(_list[_loc2_].getChildAt(0) is MovieClip)
               {
                  _loc1_ = _list[_loc2_].getChildAt(0) as MovieClip;
                  while(_loc1_.numChildren)
                  {
                     ObjectUtils.disposeObject(_loc1_.getChildAt(0));
                  }
               }
               ObjectUtils.disposeObject(_list[_loc2_].getChildAt(0));
            }
            _loc2_++;
         }
      }
      
      public function setStarList(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _list[_loc2_].play();
            _loc2_++;
         }
      }
      
      public function updataStarLevel(param1:int) : void
      {
         _list[param1 - 1].play();
      }
      
      public function dispose() : void
      {
         if(_list)
         {
            clearMc();
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _list = null;
      }
   }
}
