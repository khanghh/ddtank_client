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
      
      public function DuplicateMapView(){super();}
      
      public function initView(param1:BraveDoorControl, param2:BraveDoorDuplicateInfo) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function selectedDulicateHandler(param1:BraveDoorEvent) : void{}
      
      public function set isEnableClick(param1:Boolean) : void{}
      
      protected function createMap() : void{}
      
      protected function createDuplicates(param1:BraveDoorDuplicateInfo) : void{}
      
      private function __btnOver(param1:MouseEvent) : void{}
      
      private function __btnOut(param1:MouseEvent) : void{}
      
      private function isCanFilter(param1:int) : Boolean{return false;}
      
      private function updateDuplicateFilter(param1:duplicateIconButton, param2:Boolean) : void{}
      
      private function __duplicateClickHandler(param1:MouseEvent) : void{}
      
      private function levCheck(param1:int) : Boolean{return false;}
      
      public function get curSelectDupID() : int{return 0;}
      
      public function set curSelectDupID(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
