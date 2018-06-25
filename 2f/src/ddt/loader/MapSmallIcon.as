package ddt.loader{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PathManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;      public class MapSmallIcon extends Sprite implements Disposeable   {                   protected var _loader:DisplayLoader;            protected var _icon:Bitmap;            protected var _mapID:int = 0;            public function MapSmallIcon(mapID:int = 9999999) { super(); }
            public function startLoad() : void { }
            protected function loadIcon() : void { }
            private function __complete(event:LoaderEvent) : void { }
            public function set id(i:int) : void { }
            public function get id() : int { return 0; }
            public function get icon() : Bitmap { return null; }
            public function dispose() : void { }
   }}