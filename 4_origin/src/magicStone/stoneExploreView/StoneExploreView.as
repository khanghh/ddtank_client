package magicStone.stoneExploreView
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.BagInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import magicStone.MagicStoneControl;
   import room.RoomManager;
   import trainer.view.NewHandContainer;
   
   public class StoneExploreView extends Frame
   {
      
      private static var index:int = 0;
       
      
      private var _BG:ScaleBitmapImage;
      
      private var _ordinaryBG:Bitmap;
      
      private var _eliteBG:Bitmap;
      
      private var _startOrdinaryBtn:BaseButton;
      
      private var _startEliteBtn:BaseButton;
      
      private var _ordinaryTxt:FilterFrameText;
      
      private var _eliteTxt:FilterFrameText;
      
      private var _helpTxt:FilterFrameText;
      
      private var _paopaoOrdinaryBg:Bitmap;
      
      private var _paopaoOrdinaryTxt:FilterFrameText;
      
      private var _scOrdinaryBtn:SelectedCheckButton;
      
      private var _paopaoEliteBg:Bitmap;
      
      private var _paopaoEliteTxt:FilterFrameText;
      
      private var _scEliteBtn:SelectedCheckButton;
      
      private var _clickDate:Number = 0;
      
      private var _selfInfo:SelfInfo;
      
      private var _quick:QuickBuyFrame;
      
      public function StoneExploreView()
      {
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _magicStoneExploreGuilde();
         _titleText = LanguageMgr.GetTranslation("StoneExploreView.titleText");
         _BG = ComponentFactory.Instance.creatComponentByStylename("StoneExploreView.bg1");
         addToContent(_BG);
         _ordinaryBG = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.ordinaryBG");
         addToContent(_ordinaryBG);
         _eliteBG = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.eliteBG");
         addToContent(_eliteBG);
         _startOrdinaryBtn = ComponentFactory.Instance.creat("magicStone.stoneExplore.startOrdinaryBtn");
         addToContent(_startOrdinaryBtn);
         _startEliteBtn = ComponentFactory.Instance.creat("magicStone.stoneExplore.startEliteBtn");
         addToContent(_startEliteBtn);
         _ordinaryTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.stoneExplore.ordinaryTxt");
         _ordinaryTxt.text = LanguageMgr.GetTranslation("magicStone.stoneExplore.ordinaryTxt");
         addToContent(_ordinaryTxt);
         _eliteTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.stoneExplore.eliteTxt");
         _eliteTxt.text = LanguageMgr.GetTranslation("magicStone.stoneExplore.eliteTxt");
         addToContent(_eliteTxt);
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.stoneExplore.helpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("magicStone.stoneExplore.helpTxt");
         addToContent(_helpTxt);
         _paopaoOrdinaryBg = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.paopao");
         PositionUtils.setPos(_paopaoOrdinaryBg,"magicStone.stoneExplore.paopaoOrdinary");
         addToContent(_paopaoOrdinaryBg);
         _paopaoOrdinaryTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.stoneExplore.paopaoOrdinaryTxt");
         _paopaoOrdinaryTxt.text = MagicStoneControl.instance.model.normalFightNum.toString();
         addToContent(_paopaoOrdinaryTxt);
         _scOrdinaryBtn = ComponentFactory.Instance.creat("magicStone.stoneExplore.scOrdinaryBtn");
         _scOrdinaryBtn.selected = true;
         _scOrdinaryBtn.text = LanguageMgr.GetTranslation("magicStone.stoneExplore.scOrdinaryBtnLG");
         addToContent(_scOrdinaryBtn);
         _paopaoEliteBg = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.paopao");
         PositionUtils.setPos(_paopaoEliteBg,"magicStone.stoneExplore.paopaoElite");
         addToContent(_paopaoEliteBg);
         _paopaoEliteTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.stoneExplore.paopaoEliteTxt");
         _paopaoEliteTxt.text = MagicStoneControl.instance.model.hardFightNum.toString();
         addToContent(_paopaoEliteTxt);
         _scEliteBtn = ComponentFactory.Instance.creat("magicStone.stoneExplore.scEliteBtn");
         _scEliteBtn.selected = true;
         _scEliteBtn.text = LanguageMgr.GetTranslation("magicStone.stoneExplore.scOrdinaryBtnLG");
         addToContent(_scEliteBtn);
         setBtnEnable();
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         _startOrdinaryBtn.addEventListener("click",__startOrdinaryBtnClick);
         _startEliteBtn.addEventListener("click",__startEliteBtnClick);
         _scOrdinaryBtn.addEventListener("click",__scOrdinaryCheckBoxClick);
         _scEliteBtn.addEventListener("click",__scEliteCheckBoxClick);
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         _startOrdinaryBtn.removeEventListener("click",__startOrdinaryBtnClick);
         _startEliteBtn.removeEventListener("click",__startEliteBtnClick);
         _scOrdinaryBtn.removeEventListener("click",__scOrdinaryCheckBoxClick);
         _scEliteBtn.removeEventListener("click",__scEliteCheckBoxClick);
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
      }
      
      private function _magicStoneExploreGuilde() : void
      {
         NewHandContainer.Instance.clearArrowByID(207);
         if(!PlayerManager.Instance.Self.isNewOnceFinish(142))
         {
            SocketManager.Instance.out.syncWeakStep(142);
         }
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __gameStart(pEvent:CrazyTankSocketEvent) : void
      {
         if(index == 0)
         {
            GameInSocketOut.sendGameRoomSetUp(10115,56,false,"","",3,0,0,false,10115);
            GameInSocketOut.sendGameStart();
         }
         else
         {
            GameInSocketOut.sendGameRoomSetUp(10116,56,false,"","",3,0,0,false,10116);
            GameInSocketOut.sendGameStart();
         }
      }
      
      private function __startOrdinaryBtnClick(evt:MouseEvent) : void
      {
         if(StateManager.currentStateType != "main")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stoneExploreView.NoStartGame"));
            return;
         }
         SoundManager.instance.play("008");
         if(new Date().time - _clickDate > 1000)
         {
            if(_scOrdinaryBtn.selected)
            {
               if(checkBagStone())
               {
                  if(checkCanStartGame() && MagicStoneControl.instance.model.normalFightNum > 0)
                  {
                     index = 0;
                     GameInSocketOut.sendOrdinaryFB(true,_scOrdinaryBtn.selected);
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.bagLocked)
                  {
                     BaglockedManager.Instance.show();
                     return;
                  }
                  _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
                  _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
                  _quick.itemID = 201581;
                  _quick.setIsStoneExploreView(true);
                  LayerManager.Instance.addToLayer(_quick,2,true,1);
               }
            }
            else if(checkCanStartGame() && MagicStoneControl.instance.model.normalFightNum > 0)
            {
               index = 0;
               GameInSocketOut.sendOrdinaryFB(true,_scOrdinaryBtn.selected);
            }
         }
      }
      
      private function __startEliteBtnClick(evt:MouseEvent) : void
      {
         if(StateManager.currentStateType != "main")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stoneExploreView.NoStartGame"));
            return;
         }
         SoundManager.instance.play("008");
         if(new Date().time - _clickDate > 1000)
         {
            if(_scEliteBtn.selected)
            {
               if(checkBagStone())
               {
                  if(checkCanStartGame() && MagicStoneControl.instance.model.hardFightNum > 0)
                  {
                     index = 1;
                     GameInSocketOut.sendOrdinaryFB(false,_scEliteBtn.selected);
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.bagLocked)
                  {
                     BaglockedManager.Instance.show();
                     return;
                  }
                  _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
                  _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
                  _quick.itemID = 201581;
                  _quick.setIsStoneExploreView(true);
                  LayerManager.Instance.addToLayer(_quick,2,true,1);
               }
            }
            else if(checkCanStartGame() && MagicStoneControl.instance.model.hardFightNum > 0)
            {
               index = 1;
               GameInSocketOut.sendOrdinaryFB(false,_scEliteBtn.selected);
            }
         }
      }
      
      private function checkBagStone() : Boolean
      {
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(201581);
         if(conut >= ServerConfigManager.instance.magicStoneCostItemNum)
         {
            return true;
         }
         return false;
      }
      
      private function setBtnEnable() : void
      {
         if(MagicStoneControl.instance.model.hardFightNum <= 0)
         {
            var _loc1_:* = false;
            _startEliteBtn.mouseEnabled = _loc1_;
            _loc1_ = _loc1_;
            _startEliteBtn.mouseChildren = _loc1_;
            _startEliteBtn.enable = _loc1_;
         }
         if(MagicStoneControl.instance.model.normalFightNum <= 0)
         {
            _loc1_ = false;
            _startOrdinaryBtn.mouseEnabled = _loc1_;
            _loc1_ = _loc1_;
            _startOrdinaryBtn.mouseChildren = _loc1_;
            _startOrdinaryBtn.enable = _loc1_;
         }
      }
      
      private function __scOrdinaryCheckBoxClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __scEliteCheckBoxClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      public function checkCanStartGame() : Boolean
      {
         var result:Boolean = true;
         if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
            result = false;
         }
         return result;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(_quick)
         {
            ObjectUtils.disposeObject(_quick);
         }
         _quick = null;
      }
   }
}
