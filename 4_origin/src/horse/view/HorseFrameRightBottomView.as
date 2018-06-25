package horse.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddtDeed.DeedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import horse.HorseControl;
   import horse.HorseManager;
   import road7th.utils.MovieClipWrapper;
   import shop.manager.ShopBuyManager;
   
   public class HorseFrameRightBottomView extends Sprite implements Disposeable
   {
       
      
      private var _levelUpBtn:SimpleBitmapButton;
      
      private var _freeUpBtn:SimpleBitmapButton;
      
      private var _freeUpTxt:FilterFrameText;
      
      private var _scb:SelectedCheckButton;
      
      private var _itemCell:HorseFrameRightBottomItemCell2;
      
      private var _lastUpClickTime:int = 0;
      
      private var _isPlayingFloatCartoon:Boolean;
      
      protected var _toLinkTxt:FilterFrameText;
      
      public function HorseFrameRightBottomView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemCell = new HorseFrameRightBottomItemCell2(11164,1116401);
         PositionUtils.setPos(_itemCell,"horse.frame.itemCellPos");
         _levelUpBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelUpBtn");
         _freeUpBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelUpBtn2");
         _freeUpTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelUpBtn2Txt");
         judgeLevelUpBtn();
         _scb = ComponentFactory.Instance.creatComponentByStylename("horse.frame.rightBottomScb");
         _scb.text = LanguageMgr.GetTranslation("horse.rightBottom.scbTxt");
         _scb.selected = true;
         addChild(_itemCell);
         addChild(_levelUpBtn);
         addChild(_freeUpBtn);
         addChild(_freeUpTxt);
         addChild(_scb);
         _toLinkTxt = ComponentFactory.Instance.creat("petAndHorse.risingStar.toLinkTxt");
         _toLinkTxt.mouseEnabled = true;
         _toLinkTxt.htmlText = LanguageMgr.GetTranslation("petAndHorse.risingStar.toLinkTxtValue");
         PositionUtils.setPos(_toLinkTxt,"petAndHorse.risingStar.toLinkTxtPos3");
         addChild(_toLinkTxt);
         _toLinkTxt.visible = false;
         refreshFreeTipTxt();
      }
      
      private function initEvent() : void
      {
         _levelUpBtn.addEventListener("click",levelUpHandler,false,0,true);
         _freeUpBtn.addEventListener("click",levelUpHandler,false,0,true);
         HorseManager.instance.addEventListener("horseUpHorseStep1",upSuccessHandler);
         _toLinkTxt.addEventListener("link",__toLinkTxtHandler);
         DeedManager.instance.addEventListener("update_buff_data_event",refreshFreeTipTxt);
         DeedManager.instance.addEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      private function refreshFreeTipTxt(event:Event = null) : void
      {
         var freeCount1:int = DeedManager.instance.getOneBuffData(12);
         if(freeCount1 > 0)
         {
            _freeUpBtn.visible = true;
            _freeUpTxt.visible = true;
            _freeUpTxt.text = "(" + freeCount1 + ")";
            _levelUpBtn.visible = false;
         }
         else
         {
            _freeUpTxt.text = "(" + freeCount1 + ")";
            _freeUpBtn.visible = false;
            _freeUpTxt.visible = false;
            _levelUpBtn.visible = true;
         }
      }
      
      private function upSuccessHandler(event:Event) : void
      {
         _isPlayingFloatCartoon = true;
         var mc:MovieClip = ComponentFactory.Instance.creat("asset.horse.upHorse.flowCartoon");
         PositionUtils.setPos(mc,"horse.frame.upHorseFlowCartoonPos");
         addChild(mc);
         var mcw:MovieClipWrapper = new MovieClipWrapper(mc,true,true);
         mcw.addEventListener("complete",playCompleteHandler);
         SoundManager.instance.play("171");
         judgeLevelUpBtn();
      }
      
      private function judgeLevelUpBtn() : void
      {
         if(HorseManager.instance.curLevel >= 89)
         {
            _levelUpBtn.enable = false;
            _freeUpBtn.enable = false;
         }
         else
         {
            _levelUpBtn.enable = true;
            _freeUpBtn.enable = true;
         }
      }
      
      private function playCompleteHandler(event:Event) : void
      {
         var mcw:MovieClipWrapper = event.currentTarget as MovieClipWrapper;
         mcw.removeEventListener("complete",playCompleteHandler);
         HorseControl.instance.upFloatCartoonPlayComplete();
         _isPlayingFloatCartoon = false;
      }
      
      private function levelUpHandler(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
         var nextNeedTotal:int = 0;
         var curHasExp:int = 0;
         var upExp:int = 0;
         var tmp:int = 0;
         SoundManager.instance.play("008");
         if(HorseManager.instance.curLevel >= 90)
         {
            return;
         }
         if(_isPlayingFloatCartoon)
         {
            return;
         }
         if(getTimer() - _lastUpClickTime <= 1000)
         {
            return;
         }
         _lastUpClickTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var freeCount1:int = DeedManager.instance.getOneBuffData(12);
         if(freeCount1 > 0)
         {
            SocketManager.Instance.out.sendHorseUpHorse(1);
            return;
         }
         var itemCount:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11164);
         if(itemCount <= 0)
         {
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("horse.itemConfirmBuyPrompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",buyConfirm,false,0,true);
            return;
         }
         var useCount:int = 1;
         if(_scb.selected)
         {
            nextNeedTotal = HorseManager.instance.nextHorseTemplateInfo.Experience;
            curHasExp = HorseManager.instance.curExp;
            upExp = ItemManager.Instance.getTemplateById(11164).Property2;
            tmp = Math.ceil((nextNeedTotal - curHasExp) / upExp);
            useCount = Math.min(itemCount,tmp);
         }
         SocketManager.Instance.out.sendHorseUpHorse(useCount);
      }
      
      private function buyConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",buyConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            ShopBuyManager.Instance.buy(1116401,1,-1);
         }
      }
      
      private function __toLinkTxtHandler(evt:TextEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StateManager.setState("dungeon");
      }
      
      private function removeEvent() : void
      {
         _levelUpBtn.removeEventListener("click",levelUpHandler);
         _freeUpBtn.removeEventListener("click",levelUpHandler);
         HorseManager.instance.removeEventListener("horseUpHorseStep1",upSuccessHandler);
         _toLinkTxt.removeEventListener("link",__toLinkTxtHandler);
         DeedManager.instance.removeEventListener("update_buff_data_event",refreshFreeTipTxt);
         DeedManager.instance.removeEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_freeUpBtn);
         _freeUpBtn = null;
         ObjectUtils.disposeObject(_freeUpTxt);
         _freeUpTxt = null;
         ObjectUtils.disposeAllChildren(this);
         _levelUpBtn = null;
         _scb = null;
         _itemCell = null;
         ObjectUtils.disposeObject(_toLinkTxt);
         _toLinkTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
