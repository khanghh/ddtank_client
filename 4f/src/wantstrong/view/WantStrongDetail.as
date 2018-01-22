package wantstrong.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import calendar.CalendarManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.CheckMoneyUtils;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import labyrinth.LabyrinthControl;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import roomList.pveRoomList.DungeonListController;
   import roomList.pvpRoomList.RoomListController;
   import wantstrong.WantStrongControl;
   import wantstrong.data.WantStrongMenuData;
   
   public class WantStrongDetail extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _item:WantStrongMenuData;
      
      private var _titleFrameText:FilterFrameText;
      
      private var _contentFrameText:FilterFrameText;
      
      private var _freeBackContentFrameText:FilterFrameText;
      
      private var _freeNumFrameText:FilterFrameText;
      
      private var _freeHonorFrameText:FilterFrameText;
      
      private var _allBackContentFrameText:FilterFrameText;
      
      private var _allNumFrameText:FilterFrameText;
      
      private var _allHonorFrameText:FilterFrameText;
      
      private var _goBtn:SimpleBitmapButton;
      
      private var _freeBackBtn:SimpleBitmapButton;
      
      private var _allBackBtn:SimpleBitmapButton;
      
      private var _icon:Bitmap;
      
      private var _bagInfoItems:DictionaryData;
      
      private var _cell:BagCell;
      
      public function WantStrongDetail(param1:WantStrongMenuData){super();}
      
      private function initView() : void{}
      
      private function freeBackBtnHandler(param1:MouseEvent) : void{}
      
      private function __alertFreeBack(param1:FrameEvent) : void{}
      
      private function allBackBtnHandler(param1:MouseEvent) : void{}
      
      private function __alertAllBack(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function goBtnHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
