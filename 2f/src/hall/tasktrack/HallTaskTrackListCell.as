package hall.tasktrack
{
   import bagAndInfo.BagAndInfoManager;
   import collectionTask.CollectionTaskManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtBuried.BuriedManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.Dictionary;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   import tryonSystem.TryonSystemController;
   
   public class HallTaskTrackListCell extends Sprite implements Disposeable, IListCell
   {
      
      public static var IsStore:Boolean = false;
       
      
      private var _titleTxt:FilterFrameText;
      
      private var _conditionTxtList:Vector.<FilterFrameText>;
      
      private var _conditionTxtVBox:VBox;
      
      private var _info:QuestInfo;
      
      private var _typeMc:MovieClip;
      
      private var hasOptionalAward:Boolean;
      
      private var _extendUnMc:MovieClip;
      
      public function HallTaskTrackListCell(){super();}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function updateViewData() : void{}
      
      private function onFinishHandler(param1:TextEvent) : void{}
      
      private function finishQuest(param1:QuestInfo) : void{}
      
      private function showSelectedAwardFrame(param1:Array) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function chooseReward(param1:ItemTemplateInfo) : void{}
      
      private function textClickHandler(param1:TextEvent) : void{}
      
      private function refreshType() : void{}
      
      private function isCanTrack(param1:int, param2:int, param3:int) : Boolean{return false;}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
      
      public function get typeMc() : MovieClip{return null;}
   }
}
