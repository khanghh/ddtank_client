package times.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.utils.getDefinitionByName;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   import times.utils.TimesUtils;
   
   public class TimesPicBase extends Sprite implements Disposeable
   {
      
      public static const SMALL_PIC:uint = 0;
      
      public static const BIG_PIC:uint = 1;
      
      public static const CONTENT_PIC:uint = 2;
      
      public static const JPG:String = ".jpg";
      
      public static const PNG:String = ".png";
      
      public static const SWF:String = ".swf";
       
      
      protected var _info:TimesPicInfo;
      
      protected var _whiteShape:Shape;
      
      protected var _loadingMc:MovieClip;
      
      protected var _loader:Loader;
      
      protected var _glowFilter:GlowFilter;
      
      protected var _glowFilter2:GlowFilter;
      
      protected var _isSuccess:Boolean;
      
      public function TimesPicBase(param1:TimesPicInfo)
      {
         super();
         _info = param1;
         init();
         initEvents();
      }
      
      protected function init() : void
      {
         _loader = new Loader();
         configMouseInteractive();
         createLoadingMc();
      }
      
      public function load() : void
      {
         if(isSuccess)
         {
            return;
         }
         if(_loader == null)
         {
            _loader = new Loader();
         }
         var _loc1_:Object = getDefinitionByName("ddt.manager.PathManager");
         if(_loc1_)
         {
            _loader.load(new URLRequest(_loc1_.SITE_WEEKLY + "weekly/" + _info.path));
         }
         else
         {
            _loader.load(new URLRequest(_info.path));
         }
      }
      
      protected function initEvents() : void
      {
         addEventListener("click",__picClick);
         _loader.contentLoaderInfo.addEventListener("complete",__onLoadCompleted);
         _loader.contentLoaderInfo.addEventListener("ioError",__onLoadError);
      }
      
      public function get pic() : DisplayObject
      {
         return _loader;
      }
      
      protected function __onLoadCompleted(param1:Event) : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__onLoadCompleted);
            _loader.contentLoaderInfo.removeEventListener("ioError",__onLoadError);
            if(_loadingMc && _loadingMc.parent)
            {
               _loadingMc.parent.removeChild(_loadingMc);
            }
            _isSuccess = true;
            addChild(_loader);
            createFilters();
            if(_info.fileType == ".swf")
            {
               TimesUtils.createCell(_loader,_info);
               if(_info.category == 0 && _info.page == 0)
               {
                  TimesController.Instance.tryShowTipDisplay(_info.category,_info.page);
               }
            }
         }
      }
      
      public function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
      
      protected function __onLoadError(param1:IOErrorEvent) : void
      {
      }
      
      protected function __picClick(param1:MouseEvent) : void
      {
         TimesController.Instance.dispatchEvent(new TimesEvent("playSound"));
         var _loc2_:* = _info.type;
         if("small" !== _loc2_)
         {
            if("big" !== _loc2_)
            {
            }
            addr28:
            return;
         }
         TimesController.Instance.dispatchEvent(new TimesEvent("gotoContent",_info));
         §§goto(addr28);
      }
      
      protected function createFilters() : void
      {
         if(_info.type == "small")
         {
            _glowFilter = new GlowFilter(16777011,1,0,0,1,1,true);
            _glowFilter2 = new GlowFilter(16764006,1,0,0,1,1,true);
         }
      }
      
      protected function createLoadingMc() : void
      {
         _loadingMc = ComponentFactory.Instance.creatCustomObject("times.PicLoading");
         switch(int(picMode))
         {
            case 0:
               TimesUtils.setPos(_loadingMc,"times.SmallPicLoadingMcPos");
               break;
            case 1:
               TimesUtils.setPos(_loadingMc,"times.BigPicLoadingMcPos");
               break;
            case 2:
               TimesUtils.setPos(_loadingMc,"times.ContentPicLoadingMcPos");
         }
         addChild(_loadingMc);
      }
      
      protected function createWhiteBg() : void
      {
         if(_whiteShape == null)
         {
            _whiteShape = new Shape();
         }
         _whiteShape.graphics.clear();
         switch(int(picMode))
         {
            case 0:
               _whiteShape.graphics.beginFill(16777215,1);
               _whiteShape.graphics.drawRect(0,0,256,146);
               _whiteShape.graphics.endFill();
               break;
            case 1:
               break;
            case 2:
               _whiteShape.graphics.beginFill(16777215,1);
               _whiteShape.graphics.drawRect(0,0,256,146);
               _whiteShape.graphics.endFill();
         }
         addChildAt(_whiteShape,0);
      }
      
      protected function get picMode() : uint
      {
         if(_info == null)
         {
            return 0;
         }
         var _loc1_:* = _info.type;
         if("small" !== _loc1_)
         {
            if("big" !== _loc1_)
            {
               return 2;
            }
            return 1;
         }
         return 0;
      }
      
      protected function configMouseInteractive() : void
      {
         switch(int(picMode))
         {
            case 0:
            case 1:
               buttonMode = true;
               mouseChildren = false;
               break;
            case 2:
               buttonMode = false;
               if(_info != null && _info.fileType == ".swf")
               {
                  mouseChildren = true;
                  break;
               }
               mouseChildren = false;
               break;
         }
      }
      
      public function set playEffect(param1:Boolean) : void
      {
         value = param1;
         updateFilter = function():void
         {
            filters = [_glowFilter2,_glowFilter];
         };
         if(value && _glowFilter && _glowFilter2)
         {
            y = y - 5;
            TweenMax.to(_glowFilter,0.45,{
               "startAt":{
                  "blurX":0,
                  "blurY":0,
                  "strength":1
               },
               "blurX":8,
               "blurY":8,
               "strength":2.5,
               "yoyo":true,
               "repeat":-1,
               "ease":Sine.easeOut,
               "onUpdate":updateFilter
            });
            TweenMax.to(_glowFilter2,0.45,{
               "startAt":{
                  "blurX":0,
                  "blurY":0,
                  "strength":1
               },
               "blurX":15,
               "blurY":15,
               "strength":2.5,
               "yoyo":true,
               "repeat":-1,
               "ease":Sine.easeOut,
               "onUpdate":updateFilter
            });
            return;
         }
         if(_glowFilter && _glowFilter2)
         {
            y = y + 5;
            TweenMax.killTweensOf(_glowFilter);
            TweenMax.killTweensOf(_glowFilter2);
            filters = null;
            return;
         }
      }
      
      public function dispose() : void
      {
         if(_glowFilter)
         {
            TweenMax.killTweensOf(_glowFilter);
         }
         if(_glowFilter2)
         {
            TweenMax.killTweensOf(_glowFilter2);
         }
         removeEventListener("click",__picClick);
         if(_whiteShape)
         {
            if(_whiteShape.parent)
            {
               _whiteShape.parent.removeChild(_whiteShape);
            }
            _whiteShape.graphics.clear();
            _whiteShape = null;
         }
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__onLoadCompleted);
            _loader.contentLoaderInfo.removeEventListener("ioError",__onLoadError);
            if(_loader.parent)
            {
               _loader.parent.removeChild(_loader);
            }
            _loader.contentLoaderInfo.loader.unloadAndStop();
            _loader = null;
         }
         filters = null;
         _glowFilter = null;
         _glowFilter2 = null;
         if(_loadingMc && _loadingMc.parent)
         {
            if(_loadingMc.parent)
            {
               _loadingMc.parent.removeChild(_loadingMc);
            }
            _loadingMc = null;
         }
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
