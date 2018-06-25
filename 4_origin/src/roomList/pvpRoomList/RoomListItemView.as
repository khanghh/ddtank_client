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
      
      public function RoomListItemView(info:RoomInfo)
      {
         _myMatrixFilter = new ColorMatrixFilter([0.58516,0.36563,0.0492,0,0,0.18516,0.76564,0.0492,0,0,0.18516,0.36563,0.4492,0,0,0,0,0,1,0]);
         _info = info;
         super();
         init();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _mapShowContainer = new Sprite();
         addChild(_mapShowContainer);
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itembg");
         _itemBg.setFrame(1);
         addChild(_itemBg);
         _mode = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroomList.pvp.itemMode");
         _mode.setFrame(1);
         addChild(_mode);
         _nameText = ComponentFactory.Instance.creat("asset.ddtroomList.pvp.nameText");
         addChild(_nameText);
         _placeCountText = ComponentFactory.Instance.creat("asset.ddtroomList.pvp.placeCountText");
         addChild(_placeCountText);
         _lock = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.item.lock");
         addChild(_lock);
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.item.maskRectangle");
         _mask = new Sprite();
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRoundRect(0,0,rect.width,rect.height,rect.y);
         _mask.graphics.endFill();
         PositionUtils.setPos(_mask,"asset.ddtroomList.item.maskPos");
         addChild(_mask);
         _watchPlaceCountText = UICreatShortcut.creatAndAdd("asset.ddtroomList.pvp.watchPlaceCountText",this);
         upadte();
      }
      
      private function upadte() : void
      {
         if(_info.isPlaying)
         {
            _mode.filters = [_myMatrixFilter];
            _itemBg.setFrame(2);
            _nameText.setFrame(2);
            _placeCountText.setFrame(2);
            _watchPlaceCountText.setFrame(2);
         }
         else
         {
            _mode.filters = null;
            _itemBg.setFrame(1);
            _nameText.setFrame(1);
            _placeCountText.setFrame(1);
            _watchPlaceCountText.setFrame(1);
         }
         _mode.setFrame(_info.type + 1);
         _nameText.text = _info.Name;
         _lock.visible = _info.IsLocked;
         var str:String = _info.maxViewerCnt == 0?"-":String(_info.viewerCnt);
         _placeCountText.text = String(_info.totalPlayer) + "/" + String(_info.placeCount);
         _watchPlaceCountText.text = "(" + str + ")";
         loadIcon();
      }
      
      private function loadIcon() : void
      {
         if(_mapShowLoader)
         {
            _mapShowLoader.removeEventListener("complete",__showMap);
         }
         _mapShowLoader = LoadResourceManager.Instance.createLoader(PathManager.solveMapIconPath(_info.mapId,1),0);
         _mapShowLoader.addEventListener("complete",__showMap);
         LoadResourceManager.Instance.startLoad(_mapShowLoader);
         if(_simpMapLoader)
         {
            _simpMapLoader.removeEventListener("complete",__showSimpMap);
         }
         _simpMapLoader = LoadResourceManager.Instance.createLoader(PathManager.solveMapIconPath(_info.mapId,0),0);
         _simpMapLoader.addEventListener("complete",__showSimpMap);
         LoadResourceManager.Instance.startLoad(_simpMapLoader);
      }
      
      private function __showMap(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            if(_mapShow)
            {
               ObjectUtils.disposeObject(_mapShow);
            }
            evt.loader.removeEventListener("complete",__showMap);
            _mapShow = evt.loader.content as Bitmap;
            _mapShow.scaleX = 69 / _mapShow.height;
            _mapShow.scaleY = 69 / _mapShow.height;
            _mapShow.smoothing = true;
            PositionUtils.setPos(_mapShow,"asset.ddtroomList.MapShowPos");
            _mapShowContainer.addChild(_mapShow);
            _mapShowContainer.mask = _mask;
         }
      }
      
      private function __showSimpMap(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            evt.loader.removeEventListener("complete",__showSimpMap);
            if(_simpMapShow)
            {
               ObjectUtils.disposeObject(_simpMapShow);
               _simpMapShow = null;
            }
            _simpMapShow = evt.loader.content as Bitmap;
            PositionUtils.setPos(_simpMapShow,"asset.ddtroomList.simpMapPos");
            addChild(_simpMapShow);
         }
      }
      
      public function get info() : RoomInfo
      {
         return _info;
      }
      
      public function get id() : int
      {
         return _info.ID;
      }
      
      public function dispose() : void
      {
         _info = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_mode);
         _mode = null;
         ObjectUtils.disposeObject(_mapShow);
         _mapShow = null;
         _nameText.dispose();
         _nameText = null;
         _placeCountText.dispose();
         _placeCountText = null;
         ObjectUtils.disposeObject(_lock);
         ObjectUtils.disposeObject(_simpMapShow);
         _simpMapShow = null;
         _lock = null;
         ObjectUtils.disposeObject(_watchPlaceCountText);
         _watchPlaceCountText = null;
         if(_mapShowContainer)
         {
            if(_mapShowContainer.parent)
            {
               _mapShowContainer.parent.removeChild(_mapShowContainer);
            }
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            _mapShowContainer = null;
         }
         if(_mapShowLoader != null)
         {
            _mapShowLoader.removeEventListener("complete",__showMap);
            _mapShowLoader = null;
         }
         if(_simpMapLoader)
         {
            _simpMapLoader.addEventListener("complete",__showSimpMap);
            _simpMapLoader = null;
         }
         if(_mask && _mask.parent)
         {
            ObjectUtils.disposeAllChildren(_mask);
            _mask.parent.removeChild(_mask);
            _mask = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
