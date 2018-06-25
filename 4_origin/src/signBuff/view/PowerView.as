package signBuff.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import signBuff.SignBuffManager;
   
   public class PowerView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _sp:Sprite;
      
      public function PowerView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.hall.signBuff.bg2");
         addChild(_bg);
         _sp = new Sprite();
         addChild(_sp);
         _sp.x = 91;
         _sp.y = 96;
         for(i = 0; i < SignBuffManager.instance.itemInfoList.length; )
         {
            item = new PowerItem(SignBuffManager.instance.itemInfoList[i],i);
            item.x = 0;
            item.y = 56 * i;
            _sp.addChild(item);
            i++;
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_sp)
         {
            ObjectUtils.disposeObject(_sp);
            _sp = null;
         }
      }
   }
}
