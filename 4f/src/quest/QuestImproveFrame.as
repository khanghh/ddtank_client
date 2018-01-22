package quest
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.display.Sprite;
   
   public class QuestImproveFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _textFieldStyle:String;
      
      protected var _textField:FilterFrameText;
      
      private var _contian:Sprite;
      
      private var _questInfo:QuestInfo;
      
      private var _isOptional:Boolean;
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<QuestRewardCell>;
      
      private var _spand:int;
      
      private var _selectItem:DoubleSelectedItem;
      
      private var _first:Boolean;
      
      public function QuestImproveFrame(){super();}
      
      public function set spand(param1:int) : void{}
      
      public function set isOptional(param1:Boolean) : void{}
      
      private function initView() : void{}
      
      public function set questInfo(param1:QuestInfo) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function addReward(param1:String, param2:int, param3:int, param4:Boolean = false, param5:String = "") : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      override public function dispose() : void{}
   }
}
