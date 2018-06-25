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
         var i:int = 0;
         var _starMc:* = null;
         _list = new Vector.<MovieClip>();
         for(i = 0; i < 5; )
         {
            _starMc = ComponentFactory.Instance.creat("buried.core.improveEffect");
            _starMc.x = (_starMc.width + 2) * i;
            _starMc.stop();
            addChild(_starMc);
            _list.push(_starMc);
            i++;
         }
      }
      
      private function clearMc() : void
      {
         var i:int = 0;
         var mc:* = null;
         for(i = 0; i < 5; )
         {
            _list[i].stop();
            while(_list[i].numChildren)
            {
               if(_list[i].getChildAt(0) is MovieClip)
               {
                  mc = _list[i].getChildAt(0) as MovieClip;
                  while(mc.numChildren)
                  {
                     ObjectUtils.disposeObject(mc.getChildAt(0));
                  }
               }
               ObjectUtils.disposeObject(_list[i].getChildAt(0));
            }
            i++;
         }
      }
      
      public function setStarList(num:int) : void
      {
         var i:int = 0;
         while(i < num)
         {
            _list[i].play();
            i++;
         }
      }
      
      public function updataStarLevel(num:int) : void
      {
         _list[num - 1].play();
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
