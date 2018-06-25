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
      
      public function TimesController(target:IEventDispatcher = null)
      {
         _eggLoc = new Point(-1,-1);
         super(target);
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
      
      public function set currentPointer(value:int) : void
      {
         _currentPointer = value;
      }
      
      public function setup(analyzer:TimesAnalyzer) : void
      {
         _model.smallPicInfos = analyzer.smallPicInfos;
         _model.bigPicInfos = analyzer.bigPicInfos;
         _model.contentInfos = analyzer.contentInfos;
         _model.edition = analyzer.edition;
         _model.editor = analyzer.editor;
         _model.nextDate = analyzer.nextDate;
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
      
      public function initView(timesView:TimesView, thumbnailViews:TimesThumbnailView, contentViews:Vector.<TimesContentView>) : void
      {
         _timesView = timesView;
         _thumbnailView = thumbnailViews;
         _contentViews = contentViews;
         var info:TimesPicInfo = new TimesPicInfo();
         info.type = "category0";
         info.targetCategory = 0;
         info.targetPage = 0;
         __gotoContent(new TimesEvent("gotoContent",info));
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
      
      private function __pushTipCells(event:TimesEvent) : void
      {
         addTip(event.info.category,event.info.page,event.params);
      }
      
      private function __gotoContent(event:TimesEvent) : void
      {
         var managerReference:* = undefined;
         var info:TimesPicInfo = event.info;
         currentPointer = info.targetCategory;
         _timesView.menuSelected(currentPointer);
         _contentViews[currentPointer].frame = info.targetPage;
         tryRemoveAllViews();
         _timesView.addChild(_contentViews[currentPointer]);
         tryShowTipDisplay(currentPointer,info.targetPage);
         tryShowEgg();
         updateGuildViewPoint(currentPointer,info.targetPage);
         if(_statisticsInstance)
         {
            _statisticsInstance.startTick();
         }
         else
         {
            managerReference = getDefinitionByName("times.TimesManager") as Class;
            if(managerReference)
            {
               _statisticsInstance = managerReference.Instance.statistics;
               _statisticsInstance.startTick();
            }
         }
      }
      
      private function __gotoNextContent(event:TimesEvent) : void
      {
         var managerReference:* = undefined;
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
            managerReference = getDefinitionByName("times.TimesManager") as Class;
            if(managerReference)
            {
               _statisticsInstance = managerReference.Instance.statistics;
               _statisticsInstance.startTick();
            }
         }
      }
      
      private function __gotoPreContent(event:TimesEvent) : void
      {
         var managerReference:* = undefined;
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
            managerReference = getDefinitionByName("times.TimesManager") as Class;
            if(managerReference)
            {
               _statisticsInstance = managerReference.Instance.statistics;
               _statisticsInstance.startTick();
            }
         }
      }
      
      private function __pushTipItems(event:TimesEvent) : void
      {
         var arr:* = null;
         var info:TimesPicInfo = event.info as TimesPicInfo;
         var item:MovieClip = event.params[0] as MovieClip;
         var key:String = String(info.category) + String(info.page);
         if(_tipItemMcs[key])
         {
            arr = _tipItemMcs[key];
         }
         else
         {
            arr = [];
         }
         arr.push(item);
         _tipItemMcs[key] = arr;
      }
      
      public function updateGuildViewPoint(posX:int = -1, posY:int = -1) : void
      {
         var i:int = 0;
         var j:int = 0;
         var info:* = null;
         var idx:int = 0;
         if(posX == -1 && posY == -1)
         {
            _thumbnailView.pointIdx = idx;
            return;
         }
         i = 0;
         while(i < _model.contentInfos.length)
         {
            for(j = 0; j < _model.contentInfos[i].length; )
            {
               info = _model.contentInfos[i][j];
               if(posX == info.category && posY == info.page)
               {
                  _thumbnailView.pointIdx = idx;
                  return;
               }
               idx++;
               j++;
            }
            i++;
         }
      }
      
      private function tryRemoveAllViews() : void
      {
         var i:int = 0;
         for(i = 0; i < _contentViews.length; )
         {
            if(_contentViews[i] && _timesView.contains(_contentViews[i]))
            {
               _timesView.removeChild(_contentViews[i]);
            }
            i++;
         }
      }
      
      private function addTip(category:int, page:int, tipDisplayObjs:Array) : void
      {
         var i:int = 0;
         var key:String = String(category) + String(page);
         var container:Sprite = new Sprite();
         TimesUtils.setPos(container,"times.ContentBigPicPos");
         for(i = 0; i < tipDisplayObjs.length; )
         {
            container.addChild(tipDisplayObjs[i]);
            tipDisplayObjs[i].addEventListener("rollOver",__playEffect);
            tipDisplayObjs[i].addEventListener("rollOut",__stopEffect);
            i++;
         }
         if(_extraDisplays == null)
         {
            _extraDisplays = new Dictionary();
         }
         _extraDisplays[key] = container;
      }
      
      private function __stopEffect(event:MouseEvent) : void
      {
         if(_extraDisplays == null)
         {
            event.currentTarget.removeEventListener("rollOver",__playEffect);
            event.currentTarget.removeEventListener("rollOut",__stopEffect);
            return;
         }
         var idx:int = _extraDisplays[_tipCurrentKey].getChildIndex(event.currentTarget);
         _tipItemMcs[_tipCurrentKey][idx].gotoAndStop(1);
      }
      
      private function __playEffect(event:MouseEvent) : void
      {
         if(_extraDisplays == null)
         {
            event.currentTarget.removeEventListener("rollOver",__playEffect);
            event.currentTarget.removeEventListener("rollOut",__stopEffect);
            return;
         }
         var idx:int = _extraDisplays[_tipCurrentKey].getChildIndex(event.currentTarget);
         _tipItemMcs[_tipCurrentKey][idx].gotoAndStop(2);
      }
      
      public function clearExtraObjects() : void
      {
         var mc:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _tipItemMcs;
         for each(var arr in _tipItemMcs)
         {
            while(arr.length > 0)
            {
               mc = arr.shift();
               mc = null;
            }
            arr = null;
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
      
      public function tryShowTipDisplay(category:int, page:int) : void
      {
         removeTipDisplay();
         _tipCurrentKey = String(category) + String(page);
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
         for(var key in _extraDisplays)
         {
            if(_extraDisplays[key].parent)
            {
               _extraDisplays[key].parent.removeChild(_extraDisplays[key]);
            }
         }
      }
      
      private function deleteTipDisplay() : void
      {
         var len:int = 0;
         var i:int = 0;
         var disp:* = null;
         removeTipDisplay();
         var _loc6_:int = 0;
         var _loc5_:* = _extraDisplays;
         for(var key in _extraDisplays)
         {
            len = _extraDisplays[key];
            for(i = 0; i < len; )
            {
               disp = _extraDisplays[key].getChildAt(i);
               if(disp is InteractiveObject)
               {
                  disp.addEventListener("rollOver",__playEffect);
                  disp.addEventListener("rollOut",__stopEffect);
               }
               i++;
            }
            delete _extraDisplays[key];
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
         __eggClick = function(event:MouseEvent):void
         {
            ComponentSetting.SEND_USELOG_ID(145);
            TimesController.Instance.dispatchEvent(new TimesEvent("gotEgg"));
         };
         bingo = function():Boolean
         {
            var num:Number = Math.random() * 5;
            return num > 4;
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
         __onQueueComplete = function(e:Event):void
         {
            _queue.dispose();
            _queue = null;
            TimesController.Instance.dispatchEvent(new TimesEvent("thumbnailLoadComplete"));
         };
         _thumbnailLoaders = [];
         var _queue:LoaderQueue = new LoaderQueue();
         _queue.addEventListener("complete",__onQueueComplete);
         for(var i:int = 0; i < _model.contentInfos.length; )
         {
            var arr:Array = [];
            for(var j:int = 0; j < _model.contentInfos[i].length; )
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
         var t:int = 0;
         var p:int = 0;
         var i:int = 0;
         _model.dispose();
         for(t = 0; t < _thumbnailLoaders.length; )
         {
            for(p = 0; p < _thumbnailLoaders[t].length; )
            {
               ObjectUtils.disposeObject(_thumbnailLoaders[t][p]);
               _thumbnailLoaders[t][p] = null;
               p++;
            }
            t++;
         }
         _thumbnailLoaders = null;
         var _loc6_:int = 0;
         var _loc5_:* = _extraDisplays;
         for each(var display in _extraDisplays)
         {
            if(display)
            {
               ObjectUtils.disposeObject(display);
               display = null;
            }
         }
         _extraDisplays = null;
         for(i = 0; i < _tipItemMcs.length; )
         {
            if(_tipItemMcs[i])
            {
               if(_tipItemMcs[i].parent)
               {
                  _tipItemMcs[i].parent.removeChild(_tipItemMcs[i]);
               }
               MovieClip(_tipItemMcs[i]).loaderInfo.loader.unloadAndStop();
               _tipItemMcs[i] = null;
            }
            i++;
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
      
      public function set updateContenList(value:Array) : void
      {
         _updateContenList = value;
      }
      
      public function get isShowUpdateView() : Boolean
      {
         return _isShowUpdateView;
      }
      
      public function set isShowUpdateView(value:Boolean) : void
      {
         var tmpArray:* = null;
         var tmpInfoList:* = undefined;
         var tmpInfo2:* = null;
         var tmpInfoList2:* = undefined;
         if(_isShowUpdateView == value)
         {
            return;
         }
         _isShowUpdateView = value;
         if(_isShowUpdateView)
         {
            tmpArray = [null];
            _thumbnailLoaders[0] = tmpArray.concat(_thumbnailLoaders[0] as Array);
            tmpInfoList = _model.contentInfos[0];
            var _loc8_:int = 0;
            var _loc7_:* = tmpInfoList;
            for each(var tmpInfo in tmpInfoList)
            {
               tmpInfo.page = Number(tmpInfo.page) + 1;
            }
            tmpInfo2 = new TimesPicInfo();
            tmpInfo2.category = 0;
            tmpInfo2.page = 0;
            if(tmpInfoList[0])
            {
               tmpInfo2.type = tmpInfoList[0].type;
            }
            tmpInfoList2 = new Vector.<TimesPicInfo>();
            tmpInfoList2.push(tmpInfo2);
            _model.contentInfos[0] = tmpInfoList2.concat(_model.contentInfos[0]);
         }
      }
   }
}
