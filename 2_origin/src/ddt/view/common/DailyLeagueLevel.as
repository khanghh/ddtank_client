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
      
      public function set leagueFirst(value:Boolean) : void
      {
         if(_leagueFirst == value)
         {
            return;
         }
         _leagueFirst = value;
      }
      
      public function set score(value:int) : void
      {
         if(value == _score)
         {
            return;
         }
         _score = value;
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
      
      public function set size(size:int) : void
      {
         _size = size;
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
      
      private function __onLoadComplete(evt:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__onLoadComplete);
         _loader.removeEventListener("loadError",__onLoadError);
         if(_loader.isSuccess)
         {
            _rankIcon = _loader.content as Bitmap;
            addChild(_rankIcon);
         }
      }
      
      private function __onLoadError(evt:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",__onLoadComplete);
         _loader.removeEventListener("loadError",__onLoadError);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
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
