package ddt.loader
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
   
   public class MapSmallIcon extends Sprite implements Disposeable
   {
       
      
      protected var _loader:DisplayLoader;
      
      protected var _icon:Bitmap;
      
      protected var _mapID:int = 0;
      
      public function MapSmallIcon(param1:int = 9999999)
      {
         _mapID = param1;
         super();
      }
      
      public function startLoad() : void
      {
         loadIcon();
      }
      
      protected function loadIcon() : void
      {
         if(id == 9999999)
         {
            return;
         }
         _loader = LoadResourceManager.Instance.createLoader(PathManager.solveMapIconPath(_mapID,0),0);
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
            }
         }
         dispatchEvent(new Event("complete"));
      }
      
      public function set id(param1:int) : void
      {
         _mapID = param1;
         loadIcon();
      }
      
      public function get id() : int
      {
         return _mapID;
      }
      
      public function get icon() : Bitmap
      {
         return _icon;
      }
      
      public function dispose() : void
      {
         _loader.removeEventListener("complete",__complete);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _loader = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
