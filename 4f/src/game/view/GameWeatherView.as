package game.view
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   
   public class GameWeatherView extends Sprite implements Disposeable
   {
       
      
      private var _movie:MovieClip;
      
      private var _maxScale:int;
      
      private var _frame:int = 24;
      
      private var _wind:Number = 0;
      
      private var _mapIndex:int = 0;
      
      public function GameWeatherView(){super();}
      
      private function startLoader() : void{}
      
      private function __onLoadComplete(param1:LoaderEvent) : void{}
      
      private function createMovie() : void{}
      
      public function update(param1:int, param2:Number) : void{}
      
      public function get movie() : MovieClip{return null;}
      
      public function dispose() : void{}
   }
}
