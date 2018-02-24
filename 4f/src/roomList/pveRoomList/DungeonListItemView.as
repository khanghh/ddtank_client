package roomList.pveRoomList
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import room.model.RoomInfo;
   
   public class DungeonListItemView extends Sprite implements Disposeable
   {
      
      public static const NAN_MAP:int = 10000;
       
      
      private var _info:RoomInfo;
      
      private var _mode:ScaleFrameImage;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _lock:Bitmap;
      
      private var _nameText:FilterFrameText;
      
      private var _placeCountText:FilterFrameText;
      
      private var _hard:FilterFrameText;
      
      private var _simpMapLoader:DisplayLoader;
      
      private var _loader:DisplayLoader;
      
      private var _mapShowContainer:Sprite;
      
      private var _mapShow:Bitmap;
      
      private var _simpMapShow:Bitmap;
      
      private var _defaultMask:Bitmap;
      
      private var _mask:Sprite;
      
      private var _hardLevel:Array;
      
      public function DungeonListItemView(param1:RoomInfo = null){super();}
      
      private function init() : void{}
      
      public function get info() : RoomInfo{return null;}
      
      public function set info(param1:RoomInfo) : void{}
      
      public function get id() : int{return 0;}
      
      private function update() : void{}
      
      private function loadIcon() : void{}
      
      private function __showMap(param1:LoaderEvent) : void{}
      
      private function __showSimpMap(param1:LoaderEvent) : void{}
      
      public function dispose() : void{}
   }
}
