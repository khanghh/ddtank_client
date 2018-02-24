package ddtKingWay.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddtKingWay.DDTKingWayManager;
   import ddtKingWay.analyzer.DDTKingWayData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   
   public class DDTKingWayLevelView extends Sprite implements Disposeable
   {
       
      
      private const COUNT:int = 4;
      
      private var _remainingTimeTextBg:FilterFrameText;
      
      private var _remainingTimeText1:FilterFrameText;
      
      private var _remainingTimeText2:FilterFrameText;
      
      private var _timeUnitText:FilterFrameText;
      
      private var _itemList:Vector.<DDTKingWayLevelTargetItem>;
      
      private var _cellList:Vector.<DDTKingWayRewardCell>;
      
      private var _hBox:HBox;
      
      private var _getRewardBtn:BaseButton;
      
      private var _remainingTime:String;
      
      private var _taskInfo:QuestInfo;
      
      private var _info:DDTKingWayData;
      
      private var _timeUnit:int;
      
      private var _isGardeRange:Boolean;
      
      public function DDTKingWayLevelView(){super();}
      
      public function updataView(param1:DDTKingWayData, param2:Boolean = true) : void{}
      
      private function updataTimeUnit() : void{}
      
      private function updataItem(param1:Boolean = true) : void{}
      
      public function timeOut(param1:QuestInfo, param2:DDTKingWayData) : Boolean{return false;}
      
      public function getTimeDiff(param1:Date, param2:QuestInfo, param3:DDTKingWayData) : String{return null;}
      
      private function fixZero(param1:uint) : String{return null;}
      
      private function updateTime(param1:int) : void{}
      
      private function updateRewardShow() : void{}
      
      protected function __onGetRewardClick(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      protected function __onQuestChange(param1:TaskEvent) : void{}
      
      public function dispose() : void{}
   }
}
