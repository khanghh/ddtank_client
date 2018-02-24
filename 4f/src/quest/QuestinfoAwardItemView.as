package quest
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestImproveInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class QuestinfoAwardItemView extends QuestInfoItemView
   {
       
      
      private const ROW_HEIGHT:int = 24;
      
      private const ROW_X:int = 18;
      
      private const REWARDCELL_HEIGHT:int = 55;
      
      private var _isOptional:Boolean;
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<QuestRewardCell>;
      
      private var cardAsset:ScaleFrameImage;
      
      private var _improveBtn:BaseButton;
      
      private var _isReward:Boolean;
      
      private var _improveFrame:QuestImproveFrame;
      
      private var _multiplemax:Bitmap;
      
      private var _multipleX:Bitmap;
      
      private var _number:NumberImage;
      
      private var _first:Boolean;
      
      public function QuestinfoAwardItemView(param1:Boolean){super();}
      
      public function set isReward(param1:Boolean) : void{}
      
      override public function set info(param1:QuestInfo) : void{}
      
      private function getNeedMoney(param1:QuestInfo) : int{return 0;}
      
      private function newInfo(param1:QuestInfo, param2:int, param3:QuestImproveInfo) : QuestInfo{return null;}
      
      private function _activeimproveBtnClick(param1:MouseEvent) : void{}
      
      private function getImproveInfo(param1:QuestImproveInfo, param2:int) : QuestInfo{return null;}
      
      private function __chooseItemReward(param1:RewardSelectedEvent) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function addReward(param1:String, param2:int, param3:int, param4:Boolean = false, param5:String = "") : void{}
      
      override protected function initView() : void{}
      
      override public function dispose() : void{}
   }
}
