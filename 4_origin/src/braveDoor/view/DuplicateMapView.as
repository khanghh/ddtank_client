package braveDoor.view
{
   import BraveDoor.BraveDoorManager;
   import BraveDoor.data.BraveDoorDuplicateInfo;
   import BraveDoor.data.DuplicateInfo;
   import BraveDoor.event.BraveDoorEvent;
   import braveDoor.BraveDoorControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class DuplicateMapView extends Sprite implements Disposeable
   {
       
      
      private var _title:Bitmap = null;
      
      private var _duplicateList:DictionaryData;
      
      private var _duplicats:BraveDoorDuplicateInfo;
      
      private var _mapSpri:Sprite;
      
      private var _control:BraveDoorControl;
      
      private var _curSelectDupID:int = -1;
      
      private var _mapBg:Bitmap = null;
      
      private var _baseBtn:duplicateIconButton;
      
      public function DuplicateMapView()
      {
         _duplicateList = new DictionaryData();
         _mapSpri = new Sprite();
         super();
      }
      
      public function initView($ctr:BraveDoorControl, $info:BraveDoorDuplicateInfo) : void
      {
         _control = $ctr;
         _duplicats = $info;
         _mapSpri.removeChildren();
         addChild(_mapSpri);
         createMap();
         _title = ComponentFactory.Instance.creatBitmap("asset.braveDoor.titleIcon");
         addChild(_title);
         initEvent();
      }
      
      private function initEvent() : void
      {
         if(_control)
         {
            _control.addEventListener("selectedDuplicate",selectedDulicateHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_control)
         {
            _control.removeEventListener("selectedDuplicate",selectedDulicateHandler);
         }
      }
      
      private function selectedDulicateHandler(evt:BraveDoorEvent) : void
      {
         var dupBtn:* = null;
         var dupID:int = evt.data;
         var _loc6_:int = 0;
         var _loc5_:* = _duplicateList;
         for each(var btn in _duplicateList)
         {
            btn.enable = true;
            updateDuplicateFilter(btn,false);
         }
         curSelectDupID = dupID;
         if(_duplicateList.hasKey(dupID))
         {
            dupBtn = _duplicateList[dupID];
            dupBtn.enable = false;
            updateDuplicateFilter(dupBtn,true);
         }
      }
      
      public function set isEnableClick(value:Boolean) : void
      {
         _mapSpri.mouseChildren = value;
         _mapSpri.mouseEnabled = value;
      }
      
      protected function createMap() : void
      {
         var page:int = BraveDoorManager.instance.currentPage;
         _mapBg = null;
         if(_duplicats != null)
         {
            _mapBg = ComponentFactory.Instance.creatBitmap(_duplicats.mapUrl);
            _mapBg.height = _duplicats.mapHeight;
            _mapBg.width = _duplicats.mapWidth;
            _mapBg.x = _duplicats.mapX;
            _mapBg.y = _duplicats.mapY;
            _mapSpri.addChild(_mapBg);
         }
         createDuplicates(_duplicats);
      }
      
      protected function createDuplicates(info:BraveDoorDuplicateInfo) : void
      {
         var i:int = 0;
         var duplicates:Vector.<DuplicateInfo> = info.duplicateInfo;
         var len:int = duplicates.length;
         for(i = 0; i < len; )
         {
            _baseBtn = new duplicateIconButton(duplicates[i]);
            _baseBtn.beginChanges();
            _baseBtn.x = duplicates[i].x;
            _baseBtn.y = duplicates[i].y;
            _baseBtn.backStyle = duplicates[i].backStyle;
            _baseBtn.addEventListener("click",__duplicateClickHandler);
            _baseBtn.addEventListener("mouseMove",__btnOver);
            _baseBtn.addEventListener("mouseOut",__btnOut);
            _baseBtn.filterString = duplicates[i].filterString;
            _baseBtn.commitChanges();
            _duplicateList[duplicates[i].id] = _baseBtn;
            _mapSpri.addChild(_baseBtn);
            i++;
         }
      }
      
      private function __btnOver(evt:MouseEvent) : void
      {
         var btn:duplicateIconButton = evt.target as duplicateIconButton;
         if(isCanFilter(btn.info.id))
         {
            updateDuplicateFilter(btn,true);
         }
      }
      
      private function __btnOut(evt:MouseEvent) : void
      {
         var btn:duplicateIconButton = evt.target as duplicateIconButton;
         if(btn && btn.info && isCanFilter(btn.info.id))
         {
            updateDuplicateFilter(btn,false);
         }
      }
      
      private function isCanFilter(dupId:int) : Boolean
      {
         return curSelectDupID != dupId;
      }
      
      private function updateDuplicateFilter(btn:duplicateIconButton, isAdd:Boolean) : void
      {
         if(isAdd)
         {
            btn.filters = [new GlowFilter(16776960,1,8,8,2,2)];
         }
         else
         {
            btn.filters = null;
         }
      }
      
      private function __duplicateClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var info:RoomInfo = RoomManager.Instance.current;
         if(info && info.selfRoomPlayer && !info.selfRoomPlayer.isHost && _control.currentRoomType != 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.braveDoor.noRoot.selectMap"));
            return;
         }
         var dupId:int = duplicateIconButton(evt.target).info.id;
         if(levCheck(dupId))
         {
            return;
         }
         var _frame:DuplicateSelectView = ComponentFactory.Instance.creat("ddt.braveDoor.duplicateSelectFrame",[_control]);
         if(_frame)
         {
            LayerManager.Instance.addToLayer(_frame,3,true,1);
            _frame.duplicateID = dupId;
         }
      }
      
      private function levCheck(dupId:int) : Boolean
      {
         var info:DungeonInfo = MapManager.getBraveDoorDuplicateInfo(dupId);
         if(PlayerManager.Instance.Self.Grade < info.LevelLimits)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.clew",info.LevelLimits));
            return true;
         }
         return false;
      }
      
      public function get curSelectDupID() : int
      {
         return _curSelectDupID;
      }
      
      public function set curSelectDupID(value:int) : void
      {
         _curSelectDupID = value;
      }
      
      public function dispose() : void
      {
         var btn:* = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         removeEvent();
         if(_duplicateList)
         {
            while(_duplicateList.list.length > 0)
            {
               btn = _duplicateList.list.shift();
               btn.removeEventListener("click",__duplicateClickHandler);
               btn.removeEventListener("mouseMove",__btnOver);
               btn.removeEventListener("mouseOut",__btnOut);
               ObjectUtils.disposeObject(btn);
            }
         }
         if(_mapSpri)
         {
            ObjectUtils.disposeAllChildren(_mapSpri);
         }
         if(_mapBg)
         {
            ObjectUtils.disposeObject(_mapBg);
         }
         _mapSpri = null;
         _duplicateList = null;
         _duplicats = null;
         _title = null;
         _baseBtn = null;
         _mapBg = null;
         _control = null;
      }
   }
}
