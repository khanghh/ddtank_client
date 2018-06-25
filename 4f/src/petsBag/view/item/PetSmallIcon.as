package petsBag.view.item{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PathManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;      public class PetSmallIcon extends Sprite implements Disposeable   {                   protected var _loader:DisplayLoader;            protected var _icon:Bitmap;            protected var _petPic:String;            public function PetSmallIcon(petPic:String = "") { super(); }
            public function startLoad() : void { }
            protected function loadIcon() : void { }
            private function __complete(event:LoaderEvent) : void { }
            public function get icon() : Bitmap { return null; }
            public function dispose() : void { }
   }}