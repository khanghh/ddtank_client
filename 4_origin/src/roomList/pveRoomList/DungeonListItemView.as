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
      
      public function DungeonListItemView(info:RoomInfo = null)
      {
         _hardLevel = ["tank.room.difficulty.simple","tank.room.difficulty.normal","tank.room.difficulty.hard","tank.room.difficulty.hero","tank.room.difficulty.nightmare","tank.room.difficulty.none"];
         _info = info;
         super();
         init();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _mapShowContainer = new Sprite();
         addChild(_mapShowContainer);
         _itemBg = ComponentFactory.Instance.creat("asset.ddtroomList.pve.DungeonListItembg");
         _itemBg.setFrame(1);
         addChild(_itemBg);
         _defaultMask = UICreatShortcut.creatAndAdd("asset.ddtroomlist.pve.itemMask",this);
         _hard = UICreatShortcut.creatTextAndAdd("asset.ddtDungeonList.pve.itemHardTextStyle","XXOO",this);
         _nameText = ComponentFactory.Instance.creat("asset.ddtroomList.DungeonList.nameText");
         addChild(_nameText);
         _placeCountText = ComponentFactory.Instance.creat("asset.ddtroomList.DungeonList.placeCountText");
         addChild(_placeCountText);
         _lock = ComponentFactory.Instance.creatBitmap("asset.ddtroomlist.item.lock");
         PositionUtils.setPos(_lock,"asset.ddtdungeonList.lockPos");
         _lock.visible = false;
         addChild(_lock);
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.ddtdungeonList.maskRectangle");
         _mask = new Sprite();
         _mask.visible = false;
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRoundRect(0,0,rect.width,rect.height,rect.y);
         _mask.graphics.endFill();
         PositionUtils.setPos(_mask,"asset.ddtroomListItem.maskPos");
         addChild(_mask);
         update();
      }
      
      public function get info() : RoomInfo
      {
         return _info;
      }
      
      public function set info(value:RoomInfo) : void
      {
         _info = value;
         update();
      }
      
      public function get id() : int
      {
         return _info.ID;
      }
      
      private function update() : void
      {
         _defaultMask.visible = _info.mapId == 0 || _info.mapId == 10000?true:false;
         _lock.visible = _info.IsLocked;
         _nameText.text = _info.Name;
         if(_info.mapId == 0 || _info.mapId == 10000)
         {
            _hard.visible = false;
         }
         else
         {
            _hard.visible = true;
            _hard.text = "(" + LanguageMgr.GetTranslation(_hardLevel[_info.hardLevel]) + ")";
         }
         var str:String = _info.maxViewerCnt == 0?"-":String(_info.viewerCnt);
         _placeCountText.text = String(_info.totalPlayer) + "/" + String(_info.placeCount) + " (" + str + ")";
         if(_info.isPlaying || _info.isOpenBoss)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _itemBg.setFrame(2);
            _nameText.setFrame(2);
            _hard.setFrame(2);
            _placeCountText.setFrame(2);
         }
         else
         {
            _itemBg.setFrame(1);
            _nameText.setFrame(1);
            _hard.setFrame(1);
            _placeCountText.setFrame(1);
         }
         loadIcon();
      }
      
      private function loadIcon() : void
      {
         var mapId:int = _info.mapId == 0?10000:int(_info.mapId);
         if(_loader)
         {
            _loader.removeEventListener("complete",__showMap);
         }
         _loader = LoadResourceManager.Instance.createLoader(PathManager.solveMapIconPath(mapId,1),0);
         _loader.addEventListener("complete",__showMap);
         LoadResourceManager.Instance.startLoad(_loader);
         if(_simpMapLoader)
         {
            _simpMapLoader.removeEventListener("complete",__showSimpMap);
         }
         _simpMapLoader = LoadResourceManager.Instance.createLoader(PathManager.solveMapIconPath(mapId,0),0);
         _simpMapLoader.addEventListener("complete",__showSimpMap);
         LoadResourceManager.Instance.startLoad(_simpMapLoader);
      }
      
      private function __showMap(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            evt.loader.removeEventListener("complete",__showMap);
            if(_mapShow)
            {
               ObjectUtils.disposeObject(_mapShow);
            }
            _mapShow = null;
            _mapShow = evt.loader.content as Bitmap;
            _mapShow.scaleX = 69 / _mapShow.height;
            _mapShow.scaleY = 69 / _mapShow.height;
            _mapShow.smoothing = true;
            PositionUtils.setPos(_mapShow,"asset.ddtdungeonList.MapShowPos");
            if(!_mapShowContainer)
            {
               _mapShowContainer = new Sprite();
            }
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
            PositionUtils.setPos(_simpMapShow,"asset.ddtdungeonList.simpMapPos");
            addChild(_simpMapShow);
         }
      }
      
      public function dispose() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__showMap);
            _loader = null;
         }
         if(_simpMapLoader)
         {
            _simpMapLoader.removeEventListener("complete",__showSimpMap);
            _simpMapLoader = null;
         }
         if(_simpMapShow)
         {
            ObjectUtils.disposeObject(_simpMapShow);
            _simpMapShow = null;
         }
         if(_defaultMask)
         {
            ObjectUtils.disposeObject(_defaultMask);
            _defaultMask = null;
         }
         if(_mapShowContainer && _mapShowContainer.parent)
         {
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            _mapShowContainer.parent.removeChild(_mapShowContainer);
            _mapShowContainer = null;
         }
         if(_mask && _mask.parent)
         {
            ObjectUtils.disposeAllChildren(_mask);
            _mask.parent.removeChild(_mask);
            _mask = null;
         }
         if(_mapShow)
         {
            ObjectUtils.disposeObject(_mapShow);
            _mapShow = null;
         }
         if(_hard)
         {
            ObjectUtils.disposeObject(_hard);
            _hard = null;
         }
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         _itemBg.dispose();
         _nameText.dispose();
         _placeCountText.dispose();
         _itemBg = null;
         _nameText = null;
         _placeCountText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
