package ddt.view.character{   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.utils.ClassUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PathManager;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;      public class BaseWingLayer extends Sprite implements ILayer   {            public static const SHOW_WING:int = 0;            public static const GAME_WING:int = 1;                   protected var _info:ItemTemplateInfo;            protected var _callBack:Function;            protected var _loader:ModuleLoader;            protected var _showType:int = 0;            protected var _wing:MovieClip;            private var _isComplete:Boolean;            public function BaseWingLayer(info:ItemTemplateInfo, showType:int = 0) { super(); }
            protected function initLoader() : void { }
            protected function __sourceComplete(event:LoaderEvent = null) : void { }
            public function setColor(color:*) : Boolean { return false; }
            public function get info() : ItemTemplateInfo { return null; }
            public function set info(value:ItemTemplateInfo) : void { }
            public function getContent() : DisplayObject { return null; }
            public function dispose() : void { }
            public function load(callBack:Function) : void { }
            private function loadLayerComplete() : void { }
            public function set currentEdit(n:int) : void { }
            public function get currentEdit() : int { return 0; }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            protected function getUrl() : String { return null; }
            public function getshowTypeString() : String { return null; }
            public function get isComplete() : Boolean { return false; }
   }}