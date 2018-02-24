package sevenday.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   import sevenday.SevendayManager;
   
   public class SevendayTaskLeftView extends Sprite implements Disposeable
   {
       
      
      private var _vBox:VBox;
      
      private var _tastArr:Array;
      
      private var _info:QuestInfo;
      
      private var _hBox:HBox;
      
      private var _giftArr:Vector.<SevendayTaskCell>;
      
      private var _getRewardBtn:SimpleBitmapButton;
      
      public function SevendayTaskLeftView(){super();}
      
      private function init() : void{}
      
      public function update(param1:QuestInfo) : void{}
      
      private function __onQuestChange(param1:TaskEvent) : void{}
      
      private function updateState() : void{}
      
      private function isGetReward(param1:Boolean) : void{}
      
      private function _getGift(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function finishQuest(param1:QuestInfo) : void{}
      
      public function dispose() : void{}
   }
}
