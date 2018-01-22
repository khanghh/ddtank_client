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
      
      public function setLimitLevel(param1:int, param2:int) : void
      {
         _limitLevelText.text = LanguageMgr.GetTranslation("room.mapItem.limitLevel.Text",param1,param2);
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
      
      protected function __onComplete(param1:LoaderEvent) : void
      {
         var _loc2_:* = null;
         ObjectUtils.disposeAllChildren(_mapIconContaioner);
         _loader.removeEventListener("complete",__onComplete);
         _loader = null;
         if(BaseLoader(param1.loader).isSuccess)
         {
            _loc2_ = Bitmap(param1.loader.content);
            _loc2_.width = _bg.width;
            _loc2_.height = _bg.height;
            _mapIconContaioner.addChild(_loc2_);
            _limitLevel.visible = true;
         }
      }
      
      protected function updateSelectState() : void
      {
         _selectedBg.visible = _selected;
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         if(_mapId > -1)
         {
            SoundManager.instance.play("045");
            _loc4_ = MapManager.getDungeonInfo(_mapId) as DungeonInfo;
            if(_loc4_ && _loc4_.LevelLimits > PlayerManager.Instance.Self.Grade)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.clew",_loc4_.LevelLimits));
               return;
            }
            _loc3_ = RoomManager.Instance.current;
            if(_loc4_ && _loc3_ && _loc3_.currentPlayers)
            {
               _loc5_ = true;
               _loc6_ = 0;
               while(_loc6_ < _loc3_.currentPlayers.length)
               {
                  _loc2_ = _loc3_.currentPlayers[_loc6_];
                  if(_loc4_.LevelLimits > _loc2_.playerInfo.Grade)
                  {
                     _loc5_ = false;
                     break;
                  }
                  _loc6_++;
               }
               if(!_loc5_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.clew2",_loc4_.LevelLimits));
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
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
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
      
      public function set mapId(param1:int) : void
      {
         _mapId = param1;
         updateMapIcon();
         buttonMode = mapId != 10000;
      }
   }
}
