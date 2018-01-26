package hall.tasktrack
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   import tryonSystem.TryonSystemController;
   
   public class HallTaskCompleteCommitView extends Sprite implements Disposeable
   {
       
      
      private var _commitBtnTxt:FilterFrameText;
      
      private var _questInfo:QuestInfo;
      
      private var _questId:int;
      
      private var _timeOutId:int;
      
      public function HallTaskCompleteCommitView(param1:int){super();}
      
      protected function onATS(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function textClickHandler(param1:TextEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function finishQuest() : void{}
      
      private function showSelectedAwardFrame(param1:Array) : void{}
      
      private function chooseReward(param1:ItemTemplateInfo) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function getTypeStr(param1:QuestInfo) : String{return null;}
      
      public function dispose() : void{}
   }
}
