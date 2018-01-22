package times
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderQueue;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import times.data.TimesAnalyzer;
   import times.data.TimesEvent;
   import times.data.TimesModel;
   import times.data.TimesPicInfo;
   import times.utils.TimesUtils;
   import times.view.TimesContentView;
   import times.view.TimesThumbnailView;
   import times.view.TimesView;
   
   public class TimesController extends EventDispatcher
   {
      
      private static var _instance:TimesController;
       
      
      private var _currentPointer:int;
      
      private var _model:TimesModel;
      
      private var _thumbnailLoaders:Array;
      
      private var _extraDisplays:Dictionary;
      
      private var _tipCurrentKey:String;
      
      private var _tipItemMcs:Dictionary;
      
      private var _timesView:TimesView;
      
      private var _thumbnailView:TimesThumbnailView;
      
      private var _contentViews:Vector.<TimesContentView>;
      
      private var _statisticsInstance;
      
      private var _egg:MovieClip;
      
      private var _eggLoc:Point;
      
      private var _updateContenList:Array;
      
      private var _isShowUpdateView:Boolean = false;
      
      public function TimesController(param1:IEventDispatcher = null)
      {
         _eggLoc = new Point(-1,-1);
         super(param1);
         init();
      }
      
      public static function get Instance() : TimesController
      {
         if(_instance == null)
         {
            _instance = new TimesController();
         }
         return _instance;
      }
      
      public function get currentPointer() : int
      {
         return _currentPointer;
      }
      
      public function set currentPointer(param1:int) : void
      {
         _currentPointer = param1;
      }
      
      public function setup(param1:TimesAnalyzer) : void
      {
         _model.smallPicInfos = param1.smallPicInfos;
         _model.bigPicInfos = param1.bigPicInfos;
         _model.contentInfos = param1.contentInfos;
         _model.edition = param1.edition;
         _model.editor = param1.editor;
         _model.nextDate = param1.nextDate;
         loadThumbnail();
      }
      
      public function get model() : TimesModel
      {
         return _model;
      }
      
      private function init() : void
      {
         _model = new TimesModel();
         _tipItemMcs = new Dictionary();
      }
      
      public function initView(param1:TimesView, param2:TimesThumbnailView, param3:Vector.<TimesContentView>) : void
      {
         _timesView = param1;
         _thumbnailView = param2;
         _contentViews = param3;
         var _loc4_:TimesPicInfo = new TimesPicInfo();
         _loc4_.type = "category0";
         _loc4_.targetCategory = 0;
         _loc4_.targetPage = 0;
         __gotoContent(new TimesEvent("gotoContent",_loc4_));
      }
      
      public function initEvent() : void
      {
         TimesController.Instance.addEventListener("pushTipItems",__pushTipItems);
         TimesController.Instance.addEventListener("gotoContent",__gotoContent);
         TimesController.Instance.addEventListener("gotoPreContent",__gotoPreContent);
         TimesController.Instance.addEventListener("gotoNextContent",__gotoNextContent);
         TimesController.Instance.addEventListener("pushTipCells",__pushTipCells);
      }
      
      public function removeEvent() : void
      {
         TimesController.Instance.removeEventListener("pushTipItems",__pushTipItems);
         TimesController.Instance.removeEventListener("gotoContent",__gotoContent);
         TimesController.Instance.removeEventListener("gotoPreContent",__gotoPreContent);
         TimesController.Instance.removeEventListener("gotoNextContent",__gotoNextContent);
         TimesController.Instance.removeEventListener("pushTipCells",__pushTipCells);
      }
      
      private function __pushTipCells(param1:TimesEvent) : void
      {
         addTip(param1.info.category,param1.info.page,param1.params);
      }
      
      private function __gotoContent(param1:TimesEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:TimesPicInfo = param1.info;
         currentPointer = _loc3_.targetCategory;
         _timesView.menuSelected(currentPointer);
         _contentViews[currentPointer].frame = _loc3_.targetPage;
         tryRemoveAllViews();
         _timesView.addChild(_contentViews[currentPointer]);
         tryShowTipDisplay(currentPointer,_loc3_.targetPage);
         tryShowEgg();
         updateGuildViewPoint(currentPointer,_loc3_.targetPage);
         if(_statisticsInstance)
         {
            _statisticsInstance.startTick();
         }
         else
         {
            _loc2_ = getDefinitionByName("times.TimesManager") as Class;
            if(_loc2_)
            {
               _statisticsInstance = _loc2_.Instance.statistics;
               _statisticsInstance.startTick();
            }
         }
      }
      
      private function __gotoNextContent(param1:TimesEvent) : void
      {
         var _loc2_:* = undefined;
         currentPointer = currentPointer < 3?currentPointer + 1:0;
         _timesView.menuSelected(currentPointer);
         tryRemoveAllViews();
         _contentViews[currentPointer].frame = 0;
         _timesView.addChild(_contentViews[currentPointer]);
         tryShowTipDisplay(currentPointer,0);
         tryShowEgg();
         updateGuildViewPoint(currentPointer,0);
         if(_statisticsInstance)
         {
            _statisticsInstance.startTick();
         }
         else
         {
            _loc2_ = getDefinitionByName("times.TimesManager") as Class;
            if(_loc2_)
            {
               _statisticsInstance = _loc2_.Instance.statistics;
               _statisticsInstance.startTick();
            }
         }
      }
      
      private function __gotoPreContent(param1:TimesEvent) : void
      {
         var _loc2_:* = undefined;
         currentPointer = currentPointer > 0?currentPointer - 1:Number(_contentViews.length - 1);
         _timesView.menuSelected(currentPointer);
         tryRemoveAllViews();
         _contentViews[currentPointer].frame = _contentViews[currentPointer].maxIdx - 1;
         _timesView.addChild(_contentViews[currentPointer]);
         tryShowTipDisplay(currentPointer,_contentViews[currentPointer].maxIdx - 1);
         tryShowEgg();
         updateGuildViewPoint(currentPointer,_contentViews[currentPointer].maxIdx - 1);
         if(_statisticsInstance)
         {
            _statisticsInstance.startTick();
         }
         else
         {
            _loc2_ = getDefinitionByName("times.TimesManager") as Class;
            if(_loc2_)
            {
               _statisticsInstance = _loc2_.Instance.statistics;
               _statisticsInstance.startTick();
            }
         }
      }
      
      private function __pushTipItems(param1:TimesEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:TimesPicInfo = param1.info as TimesPicInfo;
         var _loc3_:MovieClip = param1.params[0] as MovieClip;
         var _loc4_:String = String(_loc5_.category) + String(_loc5_.page);
         if(_tipItemMcs[_loc4_])
         {
            _loc2_ = _tipItemMcs[_loc4_];
         }
         else
         {
            _loc2_ = [];
         }
         _loc2_.push(_loc3_);
         _tipItemMcs[_loc4_] = _loc2_;
      }
      
      public function updateGuildViewPoint(param1:int = -1, param2:int = -1) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         if(param1 == -1 && param2 == -1)
         {
            _thumbnailView.pointIdx = _loc3_;
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _model.contentInfos.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _model.contentInfos[_loc6_].length)
            {
               _loc5_ = _model.contentInfos[_loc6_][_loc4_];
               if(param1 == _loc5_.category && param2 == _loc5_.page)
               {
                  _thumbnailView.pointIdx = _loc3_;
                  return;
               }
               _loc3_++;
               _loc4_++;
            }
            _loc6_++;
         }
      }
      
      private function tryRemoveAllViews() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _contentViews.length)
         {
            if(_contentViews[_loc1_] && _timesView.contains(_contentViews[_loc1_]))
            {
               _timesView.removeChild(_contentViews[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      private function addTip(param1:int, param2:int, param3:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:String = String(param1) + String(param2);
         var _loc4_:Sprite = new Sprite();
         TimesUtils.setPos(_loc4_,"times.ContentBigPicPos");
         _loc6_ = 0;
         while(_loc6_ < param3.length)
         {
            _loc4_.addChild(param3[_loc6_]);
            param3[_loc6_].addEventListener("rollOver",__playEffect);
            param3[_loc6_].addEventListener("rollOut",__stopEffect);
            _loc6_++;
         }
         if(_extraDisplays == null)
         {
            _extraDisplays = new Dictionary();
         }
         _extraDisplays[_loc5_] = _loc4_;
      }
      
      private function __stopEffect(param1:MouseEvent) : void
      {
         if(_extraDisplays == null)
         {
            param1.currentTarget.removeEventListener("rollOver",__playEffect);
            param1.currentTarget.removeEventListener("rollOut",__stopEffect);
            return;
         }
         var _loc2_:int = _extraDisplays[_tipCurrentKey].getChildIndex(param1.currentTarget);
         _tipItemMcs[_tipCurrentKey][_loc2_].gotoAndStop(1);
      }
      
      private function __playEffect(param1:MouseEvent) : void
      {
         if(_extraDisplays == null)
         {
            param1.currentTarget.removeEventListener("rollOver",__playEffect);
            param1.currentTarget.removeEventListener("rollOut",__stopEffect);
            return;
         }
         var _loc2_:int = _extraDisplays[_tipCurrentKey].getChildIndex(param1.currentTarget);
         _tipItemMcs[_tipCurrentKey][_loc2_].gotoAndStop(2);
      }
      
      public function clearExtraObjects() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _tipItemMcs;
         for each(var _loc2_ in _tipItemMcs)
         {
            while(_loc2_.length > 0)
            {
               _loc1_ = _loc2_.shift();
               _loc1_ = null;
            }
            _loc2_ = null;
         }
         _tipItemMcs = new Dictionary();
         if(_egg)
         {
            _egg.stop();
            ObjectUtils.disposeObject(_egg);
            _egg = null;
         }
         deleteTipDisplay();
      }
      
      public function tryShowTipDisplay(param1:int, param2:int) : void
      {
         removeTipDisplay();
         _tipCurrentKey = String(param1) + String(param2);
         if(_extraDisplays && _extraDisplays[_tipCurrentKey])
         {
            _timesView.addChild(_extraDisplays[_tipCurrentKey]);
            if(_egg && _timesView.contains(_egg))
            {
               _timesView.addChild(_egg);
            }
         }
      }
      
      private function removeTipDisplay() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _extraDisplays;
         for(var _loc1_ in _extraDisplays)
         {
            if(_extraDisplays[_loc1_].parent)
            {
               _extraDisplays[_loc1_].parent.removeChild(_extraDisplays[_loc1_]);
            }
         }
      }
      
      private function deleteTipDisplay() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         removeTipDisplay();
         var _loc6_:int = 0;
         var _loc5_:* = _extraDisplays;
         for(var _loc3_ in _extraDisplays)
         {
            _loc2_ = _extraDisplays[_loc3_];
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = _extraDisplays[_loc3_].getChildAt(_loc4_);
               if(_loc1_ is InteractiveObject)
               {
                  _loc1_.addEventListener("rollOver",__playEffect);
                  _loc1_.addEventListener("rollOut",__stopEffect);
               }
               _loc4_++;
            }
            delete _extraDisplays[_loc3_];
         }
         _extraDisplays = null;
      }
      
      public function tryShowEgg() : void
      {
         initialize = function():void
         {
            _egg = ComponentFactory.Instance.creat("times.Egg");
            _egg.buttonMode = true;
            _egg.addEventListener("click",__eggClick);
            _eggLoc.x = _currentPointer;
            _eggLoc.y = _contentViews[_currentPointer].frame;
            _timesView.addChild(_egg);
         };
         __eggClick = function(param1:MouseEvent):void
         {
            ComponentSetting.SEND_USELOG_ID(145);
            TimesController.Instance.dispatchEvent(new TimesEvent("gotEgg"));
         };
         bingo = function():Boolean
         {
            var _loc1_:Number = Math.random() * 5;
            return _loc1_ > 4;
         };
         eggDispose = function():void
         {
            if(_egg && _egg.parent)
            {
               _egg.parent.removeChild(_egg);
               _egg.removeEventListener("click",__eggClick);
            }
            _egg = null;
            _eggLoc = null;
         };
         if(!_egg && _model.isShowEgg && bingo())
         {
            initialize();
         }
         if(_egg)
         {
            if(_currentPointer == _eggLoc.x && _contentViews[_currentPointer].frame == _eggLoc.y)
            {
               _timesView.addChild(_egg);
            }
            else
            {
               DisplayUtils.removeDisplay(_egg);
            }
         }
      }
      
      public function get thumbnailLoaders() : Array
      {
         return _thumbnailLoaders;
      }
      
      private function loadThumbnail() : void
      {
         __onQueueComplete = function(param1:Event):void
         {
            _queue.dispose();
            _queue = null;
            TimesController.Instance.dispatchEvent(new TimesEvent("thumbnailLoadComplete"));
         };
         _thumbnailLoaders = [];
         var _queue:LoaderQueue = new LoaderQueue();
         _queue.addEventListener("complete",__onQueueComplete);
         var i:int = 0;
         while(i < _model.contentInfos.length)
         {
            var arr:Array = [];
            var j:int = 0;
            while(j < _model.contentInfos[i].length)
            {
               var info:TimesPicInfo = _model.contentInfos[i][j];
               if(info.thumbnailPath && info.thumbnailPath != "null" && info.thumbnailPath != "")
               {
                  arr.push(LoadResourceManager.Instance.createLoader(_model.webPath + info.thumbnailPath,0));
                  _queue.addLoader(arr[j]);
               }
               j = Number(j) + 1;
            }
            _thumbnailLoaders.push(arr);
            i = Number(i) + 1;
         }
         _queue.start();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _model.dispose();
         _loc1_ = 0;
         while(_loc1_ < _thumbnailLoaders.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _thumbnailLoaders[_loc1_].length)
            {
               ObjectUtils.disposeObject(_thumbnailLoaders[_loc1_][_loc2_]);
               _thumbnailLoaders[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            _loc1_++;
         }
         _thumbnailLoaders = null;
         var _loc6_:int = 0;
         var _loc5_:* = _extraDisplays;
         for each(var _loc3_ in _extraDisplays)
         {
            if(_loc3_)
            {
               ObjectUtils.disposeObject(_loc3_);
               _loc3_ = null;
            }
         }
         _extraDisplays = null;
         _loc4_ = 0;
         while(_loc4_ < _tipItemMcs.length)
         {
            if(_tipItemMcs[_loc4_])
            {
               if(_tipItemMcs[_loc4_].parent)
               {
                  _tipItemMcs[_loc4_].parent.removeChild(_tipItemMcs[_loc4_]);
               }
               MovieClip(_tipItemMcs[_loc4_]).loaderInfo.loader.unloadAndStop();
               _tipItemMcs[_loc4_] = null;
            }
            _loc4_++;
         }
         if(_statisticsInstance)
         {
            _statisticsInstance.dispose();
         }
         _tipItemMcs = null;
         _timesView = null;
         _contentViews = null;
      }
      
      public function get updateContenList() : Array
      {
         return _updateContenList;
      }
      
      public function set updateContenList(param1:Array) : void
      {
         _updateContenList = param1;
      }
      
      public function get isShowUpdateView() : Boolean
      {
         return _isShowUpdateView;
      }
      
      public function set isShowUpdateView(param1:Boolean) : void
      {
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         var _loc5_:* = undefined;
         if(_isShowUpdateView == param1)
         {
            return;
         }
         _isShowUpdateView = param1;
         if(_isShowUpdateView)
         {
            _loc6_ = [null];
            _thumbnailLoaders[0] = _loc6_.concat(_thumbnailLoaders[0] as Array);
            _loc3_ = _model.contentInfos[0];
            var _loc8_:int = 0;
            var _loc7_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               _loc4_.page = Number(_loc4_.page) + 1;
            }
            _loc2_ = new TimesPicInfo();
            _loc2_.category = 0;
            _loc2_.page = 0;
            if(_loc3_[0])
            {
               _loc2_.type = _loc3_[0].type;
            }
            _loc5_ = new Vector.<TimesPicInfo>();
            _loc5_.push(_loc2_);
            _model.contentInfos[0] = _loc5_.concat(_model.contentInfos[0]);
         }
      }
   }
}
