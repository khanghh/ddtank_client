package roomList.pvpRoomList
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
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Rectangle;
   import room.model.RoomInfo;
   
   public class RoomListItemView extends Sprite implements Disposeable
   {
       
      
      private var _info:RoomInfo;
      
      private var _mode:ScaleFrameImage;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _lock:Bitmap;
      
      private var _nameText:FilterFrameText;
      
      private var _placeCountText:FilterFrameText;
      
      private var _watchPlaceCountText:FilterFrameText;
      
      private var _mapShowLoader:DisplayLoader;
      
      private var _simpMapLoader:DisplayLoader;
      
      private var _mapShowContainer:Sprite;
      
      private var _simpMapShow:Bitmap;
      
      private var _mapShow:Bitmap;
      
      private var _mask:Sprite;
      
      private var _myMatrixFilter:ColorMatrixFilter;
      
      public function RoomListItemView(param1:RoomInfo){super();}
      
      private function init() : void{}
      
      private function upadte() : void{}
      
      private function loadIcon() : void{}
      
      private function __showMap(param1:LoaderEvent) : void{}
      
      private function __showSimpMap(param1:LoaderEvent) : void{}
      
      public function get info() : RoomInfo{return null;}
      
      public function get id() : int{return 0;}
      
      public function dispose() : void{}
   }
}
