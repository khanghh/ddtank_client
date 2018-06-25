package times{   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderQueue;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import flash.utils.getDefinitionByName;   import times.data.TimesAnalyzer;   import times.data.TimesEvent;   import times.data.TimesModel;   import times.data.TimesPicInfo;   import times.utils.TimesUtils;   import times.view.TimesContentView;   import times.view.TimesThumbnailView;   import times.view.TimesView;      public class TimesController extends EventDispatcher   {            private static var _instance:TimesController;                   private var _currentPointer:int;            private var _model:TimesModel;            private var _thumbnailLoaders:Array;            private var _extraDisplays:Dictionary;            private var _tipCurrentKey:String;            private var _tipItemMcs:Dictionary;            private var _timesView:TimesView;            private var _thumbnailView:TimesThumbnailView;            private var _contentViews:Vector.<TimesContentView>;            private var _statisticsInstance;            private var _egg:MovieClip;            private var _eggLoc:Point;            private var _updateContenList:Array;            private var _isShowUpdateView:Boolean = false;            public function TimesController(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : TimesController { return null; }
            public function get currentPointer() : int { return 0; }
            public function set currentPointer(value:int) : void { }
            public function setup(analyzer:TimesAnalyzer) : void { }
            public function get model() : TimesModel { return null; }
            private function init() : void { }
            public function initView(timesView:TimesView, thumbnailViews:TimesThumbnailView, contentViews:Vector.<TimesContentView>) : void { }
            public function initEvent() : void { }
            public function removeEvent() : void { }
            private function __pushTipCells(event:TimesEvent) : void { }
            private function __gotoContent(event:TimesEvent) : void { }
            private function __gotoNextContent(event:TimesEvent) : void { }
            private function __gotoPreContent(event:TimesEvent) : void { }
            private function __pushTipItems(event:TimesEvent) : void { }
            public function updateGuildViewPoint(posX:int = -1, posY:int = -1) : void { }
            private function tryRemoveAllViews() : void { }
            private function addTip(category:int, page:int, tipDisplayObjs:Array) : void { }
            private function __stopEffect(event:MouseEvent) : void { }
            private function __playEffect(event:MouseEvent) : void { }
            public function clearExtraObjects() : void { }
            public function tryShowTipDisplay(category:int, page:int) : void { }
            private function removeTipDisplay() : void { }
            private function deleteTipDisplay() : void { }
            public function tryShowEgg() : void { }
            public function get thumbnailLoaders() : Array { return null; }
            private function loadThumbnail() : void { }
            public function dispose() : void { }
            public function get updateContenList() : Array { return null; }
            public function set updateContenList(value:Array) : void { }
            public function get isShowUpdateView() : Boolean { return false; }
            public function set isShowUpdateView(value:Boolean) : void { }
   }}