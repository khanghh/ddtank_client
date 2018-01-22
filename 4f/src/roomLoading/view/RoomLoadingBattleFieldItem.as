package roomLoading.view
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import room.RoomManager;
   
   public class RoomLoadingBattleFieldItem extends Sprite implements Disposeable
   {
       
      
      private var _mapId:int;
      
      private var _bg:Image;
      
      private var _mapLoader:DisplayLoader;
      
      private var _fieldBg:Bitmap;
      
      private var _fieldNameLoader:DisplayLoader;
      
      private var _map:Bitmap;
      
      private var _fieldName:Bitmap;
      
      public function RoomLoadingBattleFieldItem(param1:int = -1){super();}
      
      private function __onScaleBitmapLoaded(param1:UIModuleEvent) : void{}
      
      private function init() : void{}
      
      private function __onLoadComplete(param1:LoaderEvent) : void{}
      
      private function solveMapPath(param1:int) : String{return null;}
      
      public function dispose() : void{}
   }
}
