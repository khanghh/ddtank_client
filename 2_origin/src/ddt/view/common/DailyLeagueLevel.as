package ddt.view.common
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.DailyLeagueManager;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class DailyLeagueLevel extends Sprite implements ITipedDisplay, Disposeable
   {
      
      public static const SIZE_BIG:int = 0;
      
      public static const SIZE_SMALL:int = 1;
       
      
      private var _rankIcon:Bitmap;
      
      private var _level:int;
      
      private var _score:int = -1;
      
      private var _leagueFirst:Boolean;
      
      private var _loader:DisplayLoader;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _tipData:Object;
      
      private var _size:int;
      
      public function DailyLeagueLevel()
      {
         super();
      }
      
      public function set leagueFirst(param1:Boolean) : void
      {
         if(_leagueFirst == param1)
         {
            return;
         }
         _leagueFirst = param1;
      }
      
      public function set score(param1:int) : void
      {
         if(param1 == _score)
         {
            return;
         }
         _score = param1;
         _level = DailyLeagueManager.Instance.getLeagueLevelByScore(_score,_leagueFirst).Level;
         updateView();
         updateSize();
      }
      
      private function updateView() : void
      {
         if(_rankIcon)
         {
            if(_rankIcon.parent)
            {
               _rankIcon.parent.removeChild(_rankIcon);
            }
            _rankIcon.bitmapData.dispose();
            _rankIcon = null;
         }
         _loader = LoadResourceManager.Instance.createLoader(PathManager.solveLeagueRankPath(_level),0);
         _loader.addEventListener("complete",__onLoadComplete);
         _loader.addEventListener("loadError",__onLoadError);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      public function set size(param1:int) : void
      {
         _size = param1;
         updateSize();
      }
      
      private function updateSize() : void
      {
         if(_size == 1)
         {
            scaleY = 0.875;
            scaleX = 0.875;
         }
         else if(_size == 0)
         {
            scaleY = 1;
            scaleX = 1;
         }
      }
      
      private function __onLoadComplete(param1:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__onLoadComplete);
         _loader.removeEventListener("loadError",__onLoadError);
         if(_loader.isSuccess)
         {
            _rankIcon = _loader.content as Bitmap;
            addChild(_rankIcon);
         }
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__onLoadComplete);
         _loader.removeEventListener("loadError",__onLoadError);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_rankIcon)
         {
            ObjectUtils.disposeObject(_rankIcon);
         }
         _rankIcon = null;
         if(_loader)
         {
            _loader.removeEventListener("complete",__onLoadComplete);
            _loader.removeEventListener("loadError",__onLoadError);
         }
         _loader = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
