package ddt.loader
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.MapInfo;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class MapLoader extends EventDispatcher
   {
       
      
      private var _info:MapInfo;
      
      private var _back:Bitmap;
      
      private var _fore:Bitmap;
      
      private var _dead:Bitmap;
      
      private var _middle:DisplayObject;
      
      private var _real:Bitmap;
      
      private var _loaderBack:DisplayLoader;
      
      private var _loaderFore:DisplayLoader;
      
      private var _loaderDead:DisplayLoader;
      
      private var _loaderMiddle:DisplayLoader;
      
      private var _loaderReal:DisplayLoader;
      
      private var _count:int;
      
      private var _total:int;
      
      private var _loadCompleted:Boolean;
      
      public function MapLoader(param1:MapInfo)
      {
         super();
         _info = param1;
      }
      
      public function get info() : MapInfo
      {
         return _info;
      }
      
      public function get backBmp() : Bitmap
      {
         return _back;
      }
      
      public function get foreBmp() : Bitmap
      {
         return _fore;
      }
      
      public function get deadBmp() : Bitmap
      {
         return _dead;
      }
      
      public function get middle() : DisplayObject
      {
         return _middle;
      }
      
      public function get realBmp() : Bitmap
      {
         return _real;
      }
      
      public function get completed() : Boolean
      {
         return _loadCompleted;
      }
      
      public function load() : void
      {
         _count = 0;
         _total = 0;
         _loadCompleted = false;
         if(_info.DeadPic != "")
         {
            _total = Number(_total) + 1;
            _loaderDead = LoadResourceManager.Instance.createLoader(PathManager.solveMapPath(_info.ID,_info.DeadPic,"png"),0);
            _loaderDead.addEventListener("complete",__deadComplete);
            LoadResourceManager.Instance.startLoad(_loaderDead);
         }
         if(_info.ForePic != "")
         {
            _total = Number(_total) + 1;
            _loaderFore = LoadResourceManager.Instance.createLoader(PathManager.solveMapPath(_info.ID,_info.ForePic,"png"),0);
            _loaderFore.addEventListener("complete",__foreComplete);
            LoadResourceManager.Instance.startLoad(_loaderFore);
         }
         if(_info.RealPic != "")
         {
            _total = Number(_total) + 1;
            _loaderReal = LoadResourceManager.Instance.createLoader(PathManager.solveMapPath(_info.ID,_info.RealPic,"png"),0);
            _loaderReal.addEventListener("complete",__realComplete);
            LoadResourceManager.Instance.startLoad(_loaderReal);
         }
         _total = Number(_total) + 1;
         _loaderBack = LoadResourceManager.Instance.createLoader(PathManager.solveMapPath(_info.ID,_info.BackPic,"jpg"),0);
         _loaderBack.addEventListener("complete",__backComplete);
         LoadResourceManager.Instance.startLoad(_loaderBack);
      }
      
      private function __backComplete(param1:LoaderEvent) : void
      {
         var _loc2_:DisplayLoader = param1.target as DisplayLoader;
         if(_loc2_.isSuccess)
         {
            _back = _loc2_.content as Bitmap;
            if(_back != null)
            {
               count();
            }
         }
      }
      
      private function __middleComplete(param1:LoaderEvent) : void
      {
         var _loc2_:DisplayLoader = param1.target as DisplayLoader;
         if(_loc2_.isSuccess)
         {
            _middle = _loc2_.content;
         }
         count();
      }
      
      private function __foreComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__foreComplete);
         if(param1.loader.isSuccess)
         {
            _fore = param1.loader.content as Bitmap;
            if(_fore != null)
            {
               count();
            }
         }
      }
      
      private function __realComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__realComplete);
         if(param1.loader.isSuccess)
         {
            _real = param1.loader.content as Bitmap;
            if(_real != null)
            {
               count();
            }
         }
      }
      
      private function __deadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__deadComplete);
         if(param1.loader.isSuccess)
         {
            _dead = param1.loader.content as Bitmap;
            if(_dead != null)
            {
               count();
            }
         }
      }
      
      private function count() : void
      {
         _count = Number(_count) + 1;
         if(_count == _total)
         {
            _loadCompleted = true;
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function dispose() : void
      {
         _info = null;
         ObjectUtils.disposeObject(_back);
         if(_back)
         {
            _back = null;
         }
         ObjectUtils.disposeObject(_dead);
         if(_dead)
         {
            _dead = null;
         }
         ObjectUtils.disposeObject(_fore);
         if(_fore)
         {
            _fore = null;
         }
         ObjectUtils.disposeObject(_real);
         if(_real)
         {
            _real = null;
         }
         if(_loaderBack)
         {
            _loaderBack.removeEventListener("complete",__backComplete);
         }
         if(_loaderDead)
         {
            _loaderDead.removeEventListener("complete",__deadComplete);
         }
         if(_loaderFore)
         {
            _loaderFore.removeEventListener("complete",__foreComplete);
         }
         if(_loaderMiddle)
         {
            _loaderMiddle.removeEventListener("complete",__middleComplete);
         }
         if(_loaderReal)
         {
            _loaderReal.removeEventListener("complete",__realComplete);
         }
         _loaderBack = null;
         _loaderDead = null;
         _loaderFore = null;
         _loaderMiddle = null;
         _loaderReal = null;
      }
   }
}
