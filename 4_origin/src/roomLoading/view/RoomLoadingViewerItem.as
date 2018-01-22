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
         var _loc1_:* = undefined;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _viewerItems = new Vector.<RoomViewerItem>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("roomloading.ViewerFrameBg");
         _viewerTxt = ComponentFactory.Instance.creatBitmap("asset.roomloading.ViewerTxt");
         PositionUtils.setPos(_viewerTxt,"asset.ddtroom.viewerTxt");
         if(RoomManager.Instance.current.type != 56)
         {
            _loc1_ = findViewers();
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc3_ = new RoomViewerItem(_loc1_[_loc5_].place);
               _loc3_.changeBg();
               _viewerItems.push(_loc3_);
               _viewerItems[_loc5_].loadingMode = true;
               _viewerItems[_loc5_].info = _loc1_[_loc5_];
               var _loc6_:Boolean = false;
               _viewerItems[_loc5_].mouseChildren = _loc6_;
               _viewerItems[_loc5_].mouseEnabled = _loc6_;
               PositionUtils.setPos(_viewerItems[_loc5_],"asset.roomLoading.ViewerItemPos_" + String(_loc5_));
               addChild(_viewerItems[_loc5_]);
               _loc5_++;
            }
            _loc4_ = 2;
            while(_loc4_ > _loc1_.length)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.roomloading.noViewer");
               PositionUtils.setPos(_loc2_,"asset.roomLoading.ViewerItemPos_" + (_loc4_ - 1).toString());
               addChild(_loc2_);
               _loc4_--;
            }
         }
         addChildAt(_bg,0);
         addChild(_viewerTxt);
      }
      
      private function findViewers() : Vector.<RoomPlayer>
      {
         var _loc3_:Array = GameControl.Instance.Current.roomPlayers;
         var _loc1_:Vector.<RoomPlayer> = new Vector.<RoomPlayer>();
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.isViewer)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_viewerTxt);
         _viewerTxt = null;
         var _loc3_:int = 0;
         var _loc2_:* = _viewerItems;
         for each(var _loc1_ in _viewerItems)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _viewerItems = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
