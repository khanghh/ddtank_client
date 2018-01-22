package explorerManual.view.page
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import explorerManual.data.model.ManualDebrisInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ManualPiecesItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _info:ManualDebrisInfo;
      
      private var _loaderPic:DisplayLoader;
      
      private var _xOffset:int;
      
      private var _yOffset:int;
      
      public function ManualPiecesItem(param1:int, param2:int, param3:int)
      {
         index = param1;
         super();
      }
      
      public function get yOffset() : int
      {
         return _yOffset;
      }
      
      public function set yOffset(param1:int) : void
      {
         _yOffset = param1;
      }
      
      public function get xOffset() : int
      {
         return _xOffset;
      }
      
      public function set xOffset(param1:int) : void
      {
         _xOffset = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set info(param1:ManualDebrisInfo) : void
      {
         _info = param1;
         clearLoader();
         initView();
      }
      
      public function get info() : ManualDebrisInfo
      {
         return _info;
      }
      
      public function get isRight() : Boolean
      {
         return index + 1 == _info.Sort;
      }
      
      private function initView() : void
      {
         if(_info)
         {
            _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.ManualDebrisIconPath(_info.ImagePath),0);
            _loaderPic.addEventListener("complete",__picComplete);
            LoadResourceManager.Instance.startLoad(_loaderPic);
         }
      }
      
      private function __picComplete(param1:LoaderEvent) : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(param1.loader.isSuccess)
         {
            addChild(param1.loader.content as Bitmap);
         }
         clearLoader();
      }
      
      private function clearLoader() : void
      {
         if(_loaderPic)
         {
            _loaderPic.removeEventListener("complete",__picComplete);
            _loaderPic = null;
         }
      }
      
      public function dispose() : void
      {
         clearLoader();
         ObjectUtils.disposeAllChildren(this);
         _info = null;
      }
   }
}
