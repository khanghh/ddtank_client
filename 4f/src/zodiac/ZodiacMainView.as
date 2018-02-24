package zodiac
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.ConsortionBankBagView;
   import cryptBoss.CryptBossManager;
   import dayActivity.DayActivityManager;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import horse.HorseManager;
   import quest.TaskManager;
   
   public class ZodiacMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _title:MovieClip;
      
      private var _details:FilterFrameText;
      
      private var _quest:FilterFrameText;
      
      private var _lastCount:FilterFrameText;
      
      private var _awards:Array;
      
      private var _boxBtnBitmap:Bitmap;
      
      private var _boxBtnBitmapDark:Bitmap;
      
      private var _boxMask:MovieClip;
      
      private var _boxAwardBtn:MovieClip;
      
      private var _boxComponent:Component;
      
      private var _addBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _gotofinishBtn:SimpleBitmapButton;
      
      private var _getAwardBtn:SimpleBitmapButton;
      
      private var _helpframe:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _index:int;
      
      private var _last:int;
      
      private var _indexType:int;
      
      public function ZodiacMainView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addCounts(param1:MouseEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function onCompleteHandler() : void{}
      
      private function __gotoFinish(param1:MouseEvent) : void{}
      
      private function __getAward(param1:MouseEvent) : void{}
      
      private function __getAwardAll(param1:MouseEvent) : void{}
      
      private function __showHelpFrame(param1:MouseEvent) : void{}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      public function setViewIndex(param1:int) : void{}
      
      public function updateView() : void{}
      
      private function setQuestInfo() : void{}
      
      private function refreshQuestBtn(param1:int, param2:QuestInfo) : void{}
      
      public function dispose() : void{}
   }
}
