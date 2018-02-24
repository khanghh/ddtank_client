package ddt.view.chat
{
   import AvatarCollection.AvatarCollectionManager;
   import DDPlay.DDPlayManaer;
   import bagAndInfo.BagAndInfoManager;
   import beadSystem.beadSystemManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ChatManager;
   import ddt.manager.EffortManager;
   import ddt.manager.IMManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.CardBoxTipPanel;
   import ddt.view.tips.CardsTipPanel;
   import ddt.view.tips.EquipmentCardsTips;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import ddtmatch.manager.DDTMatchManager;
   import farm.FarmModelController;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import growthPackage.GrowthPackageManager;
   import hall.event.NewHallEvent;
   import hall.tasktrack.HallTaskTrackManager;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import magicStone.MagicStoneManager;
   import quest.TaskManager;
   import quest.cmd.CmdThreeAndPowerPickUpAndEnable;
   import redEnvelope.RedEnvelopeManager;
   import redPackage.RedPackageManager;
   import room.RoomManager;
   import tryonSystem.TryonSystemController;
   import witchBlessing.WitchBlessingManager;
   import wonderfulActivity.WonderfulActivityManager;
   import worldBossHelper.WorldBossHelperManager;
   
   use namespace chat_system;
   
   public class ChatOutputField extends Sprite
   {
      
      public static const GAME_STYLE:String = "GAME_STYLE";
      
      public static const GAME_WIDTH:int = 288;
      
      public static const GAME_HEIGHT:int = 106;
      
      public static const NORMAL_WIDTH:int = 440;
      
      public static const NORMAL_HEIGHT:int = 118;
      
      public static const NORMAL_STYLE:String = "NORMAL_STYLE";
      
      private static var _style:String = "";
       
      
      private var _contentField:TextField;
      
      private var _nameTip:ChatNamePanel;
      
      private var _transregionalNameTip:ChatTransregionalNamePanel;
      
      private var _goodTip:GoodTip;
      
      private var _cardboxTip:CardBoxTipPanel;
      
      private var _cardTip:EquipmentCardsTips;
      
      private var _grooveTip:CardsTipPanel;
      
      private var _cardInfotTips:EquipmentCardsTips;
      
      private var _goodTipPos:Sprite;
      
      private var _srcollRect:Rectangle;
      
      private var _tipStageClickCount:int = 0;
      
      private var isStyleChange:Boolean = false;
      
      private var t_text:String;
      
      private var _functionEnabled:Boolean;
      
      private var _clickNum:Number = 0;
      
      private var curQuestId:int = 0;
      
      private var _lastClickTime:Number;
      
      public function ChatOutputField(){super();}
      
      public function set functionEnabled(param1:Boolean) : void{}
      
      public function set contentWidth(param1:Number) : void{}
      
      public function set contentHeight(param1:Number) : void{}
      
      public function isBottom() : Boolean{return false;}
      
      public function get scrollOffset() : int{return 0;}
      
      public function set scrollOffset(param1:int) : void{}
      
      public function setChats(param1:Array) : void{}
      
      public function toBottom() : void{}
      
      chat_system function get goodTipPos() : Point{return null;}
      
      chat_system function showLinkGoodsInfo(param1:ItemTemplateInfo, param2:uint = 0) : void{}
      
      chat_system function showBeadTip(param1:ItemTemplateInfo, param2:int, param3:int) : void{}
      
      chat_system function showCardGrooveLinkGoodsInfo(param1:GrooveInfo, param2:uint = 0) : void{}
      
      chat_system function showCardInfoLinkGoodsInfo(param1:CardInfo, param2:uint = 0) : void{}
      
      private function setTipPos(param1:Object) : void{}
      
      private function setTipPos2(param1:Object) : void{}
      
      chat_system function set style(param1:String) : void{}
      
      private function __delayCall() : void{}
      
      private function __onScrollChanged(param1:Event) : void{}
      
      private function __onTextClicked(param1:TextEvent) : void{}
      
      private function finishQuest(param1:int) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function showSelectedAwardFrame(param1:Array) : void{}
      
      private function chooseReward(param1:ItemTemplateInfo) : void{}
      
      private function getPos(param1:Object, param2:ChatTransregionalNamePanel) : Point{return null;}
      
      private function __stageClickHandler(param1:MouseEvent = null) : void{}
      
      private function disposeView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onMouseClick(param1:MouseEvent) : void{}
      
      protected function __onFieldOut(param1:MouseEvent) : void{}
      
      protected function __onFieldOver(param1:MouseEvent) : void{}
      
      private function initView() : void{}
      
      private function onScrollChanged() : void{}
      
      private function updateScrollRect(param1:Number, param2:Number) : void{}
   }
}
