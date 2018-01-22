package room.view.smallMapInfoPanel
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import room.model.RoomInfo;
   
   public class BaseSmallMapInfoPanel extends Sprite implements Disposeable
   {
      
      protected static const DEFAULT_MAP_ID:String = "10000";
       
      
      protected var _info:RoomInfo;
      
      private var _bg:MutipleImage;
      
      private var _word:Bitmap;
      
      private var _smallMapIcon:Bitmap;
      
      private var _smallMapContainer:Sprite;
      
      private var _loader:DisplayLoader;
      
      private var _rect:Rectangle;
      
      private var _maskShape:Shape;
      
      public function BaseSmallMapInfoPanel(){super();}
      
      protected function initView() : void{}
      
      protected function solvePath() : String{return null;}
      
      protected function __completeHandler(param1:LoaderEvent) : void{}
      
      public function set info(param1:RoomInfo) : void{}
      
      private function __update(param1:Event) : void{}
      
      protected function updateView() : void{}
      
      public function dispose() : void{}
   }
}
