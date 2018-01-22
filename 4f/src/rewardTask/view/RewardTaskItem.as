package rewardTask.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.QuestDescTextAnalyz;
   import quest.TaskManager;
   import rewardTask.RewardTaskControl;
   
   public class RewardTaskItem extends Sprite implements Disposeable
   {
       
      
      private const ROW_X:int = 59;
      
      private var _cardAsset:ScaleFrameImage;
      
      private var _taskDescriptionText:FilterFrameText;
      
      private var _taskTargetText:FilterFrameText;
      
      private var _taskTargetStatusText:FilterFrameText;
      
      private var _getTaskBtn:SimpleBitmapButton;
      
      private var _taskingBtn:SimpleBitmapButton;
      
      private var _gotoRewardBtn:BaseButton;
      
      private var _completeBtn:SimpleBitmapButton;
      
      private var _taskInfo:QuestInfo;
      
      private var _goodBox:HBox;
      
      private var _bagCell:BagCell;
      
      private var _goodIdBg:Bitmap;
      
      private var _quicklyComplete:Boolean;
      
      private var recordX:int = 0;
      
      private var _cellList:Vector.<BagCell>;
      
      public function RewardTaskItem(){super();}
      
      private function init() : void{}
      
      private function rewardItem() : void{}
      
      private function addReward(param1:String, param2:int, param3:int, param4:Boolean = false, param5:String = "") : void{}
      
      private function __onTaskStatusClick(param1:MouseEvent) : void{}
      
      private function __onGotoRewardClick(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function finishQuest(param1:QuestInfo) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function __onClickcomplete(param1:MouseEvent) : void{}
      
      private function __onComplete(param1:FrameEvent) : void{}
      
      private function updataTaskTargetStatusText() : void{}
      
      public function taskBtnStatus(param1:int = 0) : void{}
      
      public function updateInfo() : void{}
      
      private function updataItem() : void{}
      
      private function createCell(param1:InventoryItemInfo) : BagCell{return null;}
      
      public function dispose() : void{}
   }
}
