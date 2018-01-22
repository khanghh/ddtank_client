package petsBag.view.item
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PetSmallIcon extends Sprite implements Disposeable
   {
       
      
      protected var _loader:DisplayLoader;
      
      protected var _icon:Bitmap;
      
      protected var _petPic:String;
      
      public function PetSmallIcon(param1:String = "")
      {
         super();
         _petPic = !param1 || param1.length == 0?"1":param1;
      }
      
      public function startLoad() : void
      {
         loadIcon();
      }
      
      protected function loadIcon() : void
      {
         if(_petPic.length == 0)
         {
            return;
         }
         _loader = LoadResourceManager.Instance.createLoader(PathManager.solvePetIconUrl(_petPic),0);
         _loader.addEventListener("complete",__complete);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      private function __complete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__complete);
         if(param1.loader.isSuccess)
         {
            _icon = param1.loader.content;
            if(_icon)
            {
               addChild(_icon);
               _icon.smoothing = true;
            }
         }
         dispatchEvent(new Event("complete"));
      }
      
      public function get icon() : Bitmap
      {
         return _icon;
      }
      
      public function dispose() : void
      {
         _loader.removeEventListener("complete",__complete);
         ObjectUtils.disposeObject(_loader);
         _loader = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
