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
      
      public function TimesPicBase(param1:TimesPicInfo){super();}
      
      protected function init() : void{}
      
      public function load() : void{}
      
      protected function initEvents() : void{}
      
      public function get pic() : DisplayObject{return null;}
      
      protected function __onLoadCompleted(param1:Event) : void{}
      
      public function get isSuccess() : Boolean{return false;}
      
      protected function __onLoadError(param1:IOErrorEvent) : void{}
      
      protected function __picClick(param1:MouseEvent) : void{}
      
      protected function createFilters() : void{}
      
      protected function createLoadingMc() : void{}
      
      protected function createWhiteBg() : void{}
      
      protected function get picMode() : uint{return null;}
      
      protected function configMouseInteractive() : void{}
      
      public function set playEffect(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
