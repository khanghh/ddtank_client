package roomLoading.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import room.view.RoomViewerItem;
   
   public class RoomLoadingViewerItem extends Sprite implements Disposeable
   {
      
      private static const MAX_VIEWER:int = 2;
       
      
      private var _bg:Image;
      
      private var _viewerTxt:Bitmap;
      
      private var _viewerItems:Vector.<RoomViewerItem>;
      
      public function RoomLoadingViewerItem()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         var viewers:* = undefined;
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var _noViewer:* = null;
         _viewerItems = new Vector.<RoomViewerItem>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("roomloading.ViewerFrameBg");
         _viewerTxt = ComponentFactory.Instance.creatBitmap("asset.roomloading.ViewerTxt");
         PositionUtils.setPos(_viewerTxt,"asset.ddtroom.viewerTxt");
         if(RoomManager.Instance.current.type != 56)
         {
            viewers = findViewers();
            for(i = 0; i < viewers.length; )
            {
               item = new RoomViewerItem(viewers[i].place);
               item.changeBg();
               _viewerItems.push(item);
               _viewerItems[i].loadingMode = true;
               _viewerItems[i].info = viewers[i];
               var _loc6_:Boolean = false;
               _viewerItems[i].mouseChildren = _loc6_;
               _viewerItems[i].mouseEnabled = _loc6_;
               PositionUtils.setPos(_viewerItems[i],"asset.roomLoading.ViewerItemPos_" + String(i));
               addChild(_viewerItems[i]);
               i++;
            }
            for(j = 2; j > viewers.length; )
            {
               _noViewer = ComponentFactory.Instance.creatBitmap("asset.roomloading.noViewer");
               PositionUtils.setPos(_noViewer,"asset.roomLoading.ViewerItemPos_" + (j - 1).toString());
               addChild(_noViewer);
               j--;
            }
         }
         addChildAt(_bg,0);
         addChild(_viewerTxt);
      }
      
      private function findViewers() : Vector.<RoomPlayer>
      {
         var players:Array = GameControl.Instance.Current.roomPlayers;
         var result:Vector.<RoomPlayer> = new Vector.<RoomPlayer>();
         var _loc5_:int = 0;
         var _loc4_:* = players;
         for each(var roomPlayer in players)
         {
            if(roomPlayer.isViewer)
            {
               result.push(roomPlayer);
            }
         }
         return result;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_viewerTxt);
         _viewerTxt = null;
         var _loc3_:int = 0;
         var _loc2_:* = _viewerItems;
         for each(var item in _viewerItems)
         {
            item.dispose();
            item = null;
         }
         _viewerItems = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
