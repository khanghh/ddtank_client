package roomLoading.view
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import room.RoomManager;
   
   public class RoomLoadingDungeonMapItem extends Sprite implements Disposeable
   {
       
      
      private var _displayMc:MovieClip;
      
      private var _itemFrame:DisplayObject;
      
      private var _item:Sprite;
      
      private var _mapLoader:DisplayLoader;
      
      public function RoomLoadingDungeonMapItem(){super();}
      
      private function init() : void{}
      
      private function __onLoadComplete(param1:Event) : void{}
      
      private function solveMapPath() : String{return null;}
      
      public function disappear() : void{}
      
      public function dispose() : void{}
   }
}
