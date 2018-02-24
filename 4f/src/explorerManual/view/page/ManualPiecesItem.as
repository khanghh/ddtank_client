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
      
      public function ManualPiecesItem(param1:int, param2:int, param3:int){super();}
      
      public function get yOffset() : int{return 0;}
      
      public function set yOffset(param1:int) : void{}
      
      public function get xOffset() : int{return 0;}
      
      public function set xOffset(param1:int) : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function set info(param1:ManualDebrisInfo) : void{}
      
      public function get info() : ManualDebrisInfo{return null;}
      
      public function get isRight() : Boolean{return false;}
      
      private function initView() : void{}
      
      private function __picComplete(param1:LoaderEvent) : void{}
      
      private function clearLoader() : void{}
      
      public function dispose() : void{}
   }
}
