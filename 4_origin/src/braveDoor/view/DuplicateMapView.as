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
      
      public function initView(param1:BraveDoorControl, param2:BraveDoorDuplicateInfo) : void
      {
         _control = param1;
         _duplicats = param2;
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
      
      private function selectedDulicateHandler(param1:BraveDoorEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = param1.data;
         var _loc6_:int = 0;
         var _loc5_:* = _duplicateList;
         for each(var _loc3_ in _duplicateList)
         {
            _loc3_.enable = true;
            updateDuplicateFilter(_loc3_,false);
         }
         curSelectDupID = _loc4_;
         if(_duplicateList.hasKey(_loc4_))
         {
            _loc2_ = _duplicateList[_loc4_];
            _loc2_.enable = false;
            updateDuplicateFilter(_loc2_,true);
         }
      }
      
      public function set isEnableClick(param1:Boolean) : void
      {
         _mapSpri.mouseChildren = param1;
         _mapSpri.mouseEnabled = param1;
      }
      
      protected function createMap() : void
      {
         var _loc1_:int = BraveDoorManager.instance.currentPage;
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
      
      protected function createDuplicates(param1:BraveDoorDuplicateInfo) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<DuplicateInfo> = param1.duplicateInfo;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _baseBtn = new duplicateIconButton(_loc2_[_loc4_]);
            _baseBtn.beginChanges();
            _baseBtn.x = _loc2_[_loc4_].x;
            _baseBtn.y = _loc2_[_loc4_].y;
            _baseBtn.backStyle = _loc2_[_loc4_].backStyle;
            _baseBtn.addEventListener("click",__duplicateClickHandler);
            _baseBtn.addEventListener("mouseMove",__btnOver);
            _baseBtn.addEventListener("mouseOut",__btnOut);
            _baseBtn.filterString = _loc2_[_loc4_].filterString;
            _baseBtn.commitChanges();
            _duplicateList[_loc2_[_loc4_].id] = _baseBtn;
            _mapSpri.addChild(_baseBtn);
            _loc4_++;
         }
      }
      
      private function __btnOver(param1:MouseEvent) : void
      {
         var _loc2_:duplicateIconButton = param1.target as duplicateIconButton;
         if(isCanFilter(_loc2_.info.id))
         {
            updateDuplicateFilter(_loc2_,true);
         }
      }
      
      private function __btnOut(param1:MouseEvent) : void
      {
         var _loc2_:duplicateIconButton = param1.target as duplicateIconButton;
         if(_loc2_ && _loc2_.info && isCanFilter(_loc2_.info.id))
         {
            updateDuplicateFilter(_loc2_,false);
         }
      }
      
      private function isCanFilter(param1:int) : Boolean
      {
         return curSelectDupID != param1;
      }
      
      private function updateDuplicateFilter(param1:duplicateIconButton, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [new GlowFilter(16776960,1,8,8,2,2)];
         }
         else
         {
            param1.filters = null;
         }
      }
      
      private function __duplicateClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc4_:RoomInfo = RoomManager.Instance.current;
         if(_loc4_ && _loc4_.selfRoomPlayer && !_loc4_.selfRoomPlayer.isHost && _control.currentRoomType != 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.braveDoor.noRoot.selectMap"));
            return;
         }
         var _loc2_:int = duplicateIconButton(param1.target).info.id;
         if(levCheck(_loc2_))
         {
            return;
         }
         var _loc3_:DuplicateSelectView = ComponentFactory.Instance.creat("ddt.braveDoor.duplicateSelectFrame",[_control]);
         if(_loc3_)
         {
            LayerManager.Instance.addToLayer(_loc3_,3,true,1);
            _loc3_.duplicateID = _loc2_;
         }
      }
      
      private function levCheck(param1:int) : Boolean
      {
         var _loc2_:DungeonInfo = MapManager.getBraveDoorDuplicateInfo(param1);
         if(PlayerManager.Instance.Self.Grade < _loc2_.LevelLimits)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomMapSetPanelDuplicate.clew",_loc2_.LevelLimits));
            return true;
         }
         return false;
      }
      
      public function get curSelectDupID() : int
      {
         return _curSelectDupID;
      }
      
      public function set curSelectDupID(param1:int) : void
      {
         _curSelectDupID = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         removeEvent();
         if(_duplicateList)
         {
            while(_duplicateList.list.length > 0)
            {
               _loc1_ = _duplicateList.list.shift();
               _loc1_.removeEventListener("click",__duplicateClickHandler);
               _loc1_.removeEventListener("mouseMove",__btnOver);
               _loc1_.removeEventListener("mouseOut",__btnOut);
               ObjectUtils.disposeObject(_loc1_);
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
