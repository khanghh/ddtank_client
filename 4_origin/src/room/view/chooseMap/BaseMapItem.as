package room.view.chooseMap
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   
   public class BaseMapItem extends Sprite implements Disposeable
   {
       
      
      protected var _mapId:int = -1;
      
      protected var _selected:Boolean;
      
      protected var _bg:Bitmap;
      
      protected var _mapIconContaioner:Sprite;
      
      protected var _limitLevel:Sprite;
      
      protected var _limitBg:Bitmap;
      
      protected var _limitLevelText:FilterFrameText;
      
      protected var _selectedBg:Bitmap;
      
      protected var _loader:DisplayLoader;
      
      public function BaseMapItem()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function get height() : Number
      {
         return Math.max(_bg.height,_selectedBg.height);
      }
      
      override public function get width() : Number
      {
         return Math.max(_bg.width,_selectedBg.width);
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.room.mapItemBgAsset");
         addChild(_bg);
         _mapIconContaioner = new Sprite();
         addChild(_mapIconContaioner);
         createLitmitSprite();
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.room.mapItemSelectedAsset");
         addChild(_selectedBg);
         _selectedBg.visible = false;
      }
      
      private function createLitmitSprite() : void
      {
         _limitLevel = new Sprite();
         PositionUtils.setPos(_limitLevel,"asset.room.mapItem.limitLevelPos");
         addChild(_limitLevel);
         _limitLevel.visible = false;
         _limitBg = ComponentFactory.Instance.creatBitmap("asset.room.mapItem.limitLevelBg");
         _limitLevel.addChild(_limitBg);
         _limitLevelText = ComponentFactory.Instance.creatComponentByStylename("room.mapItem.limitLevel.text");
         _limitLevel.addChild(_limitLevelText);
         _limitLevelText.visible = false;
      }
      
      public function setLimitLevel(min:int, max:int) : void
      {
         _limitLevelText.text = LanguageMgr.GetTranslation("room.mapItem.limitLevel.Text",min,max);
      }
      
      protected function initEvents() : void
      {
         addEventListener("click",__onClick);
      }
      
      protected function removeEvents() : void
      {
         removeEventListener("click",__onClick);
      }
      
      protected function updateMapIcon() : void
      {
         if(_loader != null)
         {
            _loader.removeEventListener("complete",__onComplete);
         }
         _loader = LoadResourceManager.Instance.createLoader(solvePath(),0);
         _loader.addEventListener("complete",__onComplete);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      protected function solvePath() : String
      {
         return PathManager.SITE_MAIN + "image/map/" + _mapId.toString() + "/samll_map_s.jpg";
      }
      
      protected function __onComplete(evt:LoaderEvent) : void
      {
         var bm:* = null;
         ObjectUtils.disposeAllChildren(_mapIconContaioner);
         _loader.removeEventListener("complete",__onComplete);
         _loader = null;
         if(BaseLoader(evt.loader).isSuccess)
         {
            bm = Bitmap(evt.loader.content);
            bm.width = _bg.width;
            bm.height = _bg.height;
            _mapIconContaioner.addChild(bm);
            _limitLevel.visible = true;
         }
      }
      
      protected function updateSelectState() : void
      {
         _selectedBg.visible = _selected;
      }
      
      private function __onClick(evt:MouseEvent) : void
      {
         var dungeon:* = null;
         var currentRoom:* = null;
         var bool:Boolean = false;
         var i:int = 0;
         var rp:* = null;
         if(_mapId > -1)
         {
            SoundManager.instance.play("045");
            dungeon = MapManager.getDungeonInfo(_mapId) as DungeonInfo;
            if(dungeon && dungeon.LevelLimits > PlayerManager.Instance.Self.Grade)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.clew",dungeon.LevelLimits));
               return;
            }
            currentRoom = RoomManager.Instance.current;
            if(dungeon && currentRoom && currentRoom.currentPlayers)
            {
               bool = true;
               for(i = 0; i < currentRoom.currentPlayers.length; )
               {
                  rp = currentRoom.currentPlayers[i];
                  if(dungeon.LevelLimits > rp.playerInfo.Grade)
                  {
                     bool = false;
                     break;
                  }
                  i++;
               }
               if(!bool)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.clew2",dungeon.LevelLimits));
                  return;
               }
            }
            selected = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         ObjectUtils.disposeAllChildren(_mapIconContaioner);
         removeChild(_mapIconContaioner);
         _mapIconContaioner = null;
         if(_selectedBg)
         {
            if(_selectedBg.parent != null)
            {
               _selectedBg.parent.removeChild(_selectedBg);
            }
            _selectedBg.bitmapData.dispose();
         }
         _selectedBg = null;
         if(_loader != null)
         {
            _loader.removeEventListener("complete",__onComplete);
         }
         _loader = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         updateSelectState();
         if(_selected)
         {
            dispatchEvent(new Event("select"));
         }
      }
      
      public function get mapId() : int
      {
         return _mapId;
      }
      
      public function set mapId(value:int) : void
      {
         _mapId = value;
         updateMapIcon();
         buttonMode = mapId != 10000;
      }
   }
}
