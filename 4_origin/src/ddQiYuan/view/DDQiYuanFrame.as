package ddQiYuan.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanController;
   import ddQiYuan.DDQiYuanManager;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class DDQiYuanFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _btnHelp:BaseButton;
      
      private var _towerEnterBtn:MovieClip;
      
      private var _gouYuNumTf:FilterFrameText;
      
      private var _treasureKeyNumTf:FilterFrameText;
      
      private var _treasureBoxNumTf:FilterFrameText;
      
      private var _progressMc:MovieClip;
      
      private var _progressBgMc:MovieClip;
      
      private var _activedBaoZhuNumTf:FilterFrameText;
      
      private var _showGetBtn:SimpleBitmapButton;
      
      private var _hasGetGoodsList:HasGetGoodsList;
      
      private var _offerProgressTf:FilterFrameText;
      
      private var _offer1TimeBtn:BaseButton;
      
      private var _offer10TimeBtn:BaseButton;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      private var _openTreasureBoxBtn:SimpleBitmapButton;
      
      private var _offerRewardGoodsScrollPanel:ScrollPanel;
      
      private var _treasureBoxGoodsScrollPanel:ScrollPanel;
      
      private var _offerRewardGoodsScrollPanelLeftBtn:SimpleBitmapButton;
      
      private var _offerRewardGoodsScrollPanelRightBtn:SimpleBitmapButton;
      
      private var _treasureBoxGoodsScrollPanelLeftBtn:SimpleBitmapButton;
      
      private var _treasureBoxGoodsScrollPanelRightBtn:SimpleBitmapButton;
      
      private var _rankSp:AreaRankSp;
      
      private var _beliefRewardSp:BeliefRewardSp;
      
      private var _model:DDQiYuanModel;
      
      private var _boGuAni:BoGuAni;
      
      private var _joinBagCellSp:JoinBagCellSp;
      
      public function DDQiYuanFrame()
      {
         super();
         initView();
         initEvent();
         update();
      }
      
      private function initView() : void
      {
         var goodId:int = 0;
         var bagCell:* = null;
         var bagCellBg:* = null;
         _model = DDQiYuanManager.instance.model;
         titleText = LanguageMgr.GetTranslation("ddQiYuan.frame.titleText");
         _bg = ComponentFactory.Instance.creat("ddQiYuan.bg");
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":798,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"DDQiYuan.DDQiYuan.help",438,520);
         addToContent(_bg);
         _boGuAni = new BoGuAni();
         PositionUtils.setPos(_boGuAni,"ddQiYuan.boGuAniPos");
         addToContent(_boGuAni);
         _towerEnterBtn = ComponentFactory.Instance.creat("DDQiYuan.TowerIcon");
         PositionUtils.setPos(_towerEnterBtn,"ddQiYuan.towerEnterBtn");
         _towerEnterBtn.buttonMode = true;
         _towerEnterBtn.mouseChildren = false;
         addToContent(_towerEnterBtn);
         _gouYuNumTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.gouYuNumTf");
         addToContent(_gouYuNumTf);
         _treasureKeyNumTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.treasureKeyNumTf");
         addToContent(_treasureKeyNumTf);
         _treasureBoxNumTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.treasureBoxNumTf");
         addToContent(_treasureBoxNumTf);
         _activedBaoZhuNumTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.activedBaoZhuNumTf");
         addToContent(_activedBaoZhuNumTf);
         _progressMc = ComponentFactory.Instance.creat("DDQiYuan.mc.Progress1");
         addToContent(_progressMc);
         var offerProgressUp:Image = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerProgressUp");
         addToContent(offerProgressUp);
         _showGetBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.showGetBtn");
         addToContent(_showGetBtn);
         _hasGetGoodsList = ComponentFactory.Instance.creatCustomObject("ddQiYuan.HasGetGoodsList");
         addToContent(_hasGetGoodsList);
         _offerProgressTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerProgressTf");
         addToContent(_offerProgressTf);
         var offerInfoTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerInfoTf");
         addToContent(offerInfoTf);
         offerInfoTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.offerInfoTfMsg");
         var openTreasureBoxInfoTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.openTreasureBoxInfoTf");
         addToContent(openTreasureBoxInfoTf);
         openTreasureBoxInfoTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxInfoTfMsg");
         _offer1TimeBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offer1TimeBtn");
         _offer1TimeBtn.tipData = LanguageMgr.GetTranslation("ddQiYuan.frame.offer1TimeBtnTip");
         addToContent(_offer1TimeBtn);
         setButtonFrame(_offer1TimeBtn,1);
         _offer10TimeBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offer10TimeBtn");
         _offer10TimeBtn.tipData = LanguageMgr.GetTranslation("ddQiYuan.frame.offer1TimeBtnTip");
         addToContent(_offer10TimeBtn);
         setButtonFrame(_offer10TimeBtn,1);
         _selectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.continuousSelectedCheckButton");
         _selectedCheckButton.text = LanguageMgr.GetTranslation("ddQiYuan.frame.continuousSelectedCheckButtonMsg");
         addToContent(_selectedCheckButton);
         _openTreasureBoxBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.openTreasureBoxBtn");
         _openTreasureBoxBtn.tipData = LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxBtnTip");
         addToContent(_openTreasureBoxBtn);
         _offerRewardGoodsScrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerRewardGoodsScrollPanel");
         var offerRewardGoodsHBox:HBox = new HBox();
         offerRewardGoodsHBox.spacing = 5;
         var _loc14_:int = 0;
         var _loc13_:* = _model.offer1Or10TimesRewardBoxGoodArr;
         for each(goodId in _model.offer1Or10TimesRewardBoxGoodArr)
         {
            bagCellBg = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
            bagCell = new BagCell(1,ItemManager.Instance.getTemplateById(goodId),true,bagCellBg,false);
            bagCell.setCountNotVisible();
            bagCell.PicPos = new Point(2,2);
            bagCell.setContentSize(38,38);
            offerRewardGoodsHBox.addChild(bagCell);
         }
         _offerRewardGoodsScrollPanel.setView(offerRewardGoodsHBox);
         _offerRewardGoodsScrollPanel.invalidateViewport();
         addToContent(_offerRewardGoodsScrollPanel);
         _treasureBoxGoodsScrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.treasureBoxGoodsScrollPanel");
         var treasureBoxGoodsHBox:HBox = new HBox();
         treasureBoxGoodsHBox.spacing = 5;
         var _loc16_:int = 0;
         var _loc15_:* = _model.openTreasureBoxGoodArr;
         for each(goodId in _model.openTreasureBoxGoodArr)
         {
            bagCellBg = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
            bagCell = new BagCell(1,ItemManager.Instance.getTemplateById(goodId),true,bagCellBg,false);
            bagCell.setCountNotVisible();
            bagCell.PicPos = new Point(2,2);
            bagCell.setContentSize(38,38);
            treasureBoxGoodsHBox.addChild(bagCell);
         }
         _treasureBoxGoodsScrollPanel.setView(treasureBoxGoodsHBox);
         _treasureBoxGoodsScrollPanel.invalidateViewport();
         addToContent(_treasureBoxGoodsScrollPanel);
         _offerRewardGoodsScrollPanelLeftBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerRewardGoodsScrollPanelLeftBtn");
         addToContent(_offerRewardGoodsScrollPanelLeftBtn);
         _offerRewardGoodsScrollPanelRightBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerRewardGoodsScrollPanelRightBtn");
         addToContent(_offerRewardGoodsScrollPanelRightBtn);
         _treasureBoxGoodsScrollPanelLeftBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.treasureBoxGoodsScrollPanelLeftBtn");
         addToContent(_treasureBoxGoodsScrollPanelLeftBtn);
         _treasureBoxGoodsScrollPanelRightBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.treasureBoxGoodsScrollPanelRightBtn");
         addToContent(_treasureBoxGoodsScrollPanelRightBtn);
         _rankSp = new AreaRankSp();
         addToContent(_rankSp);
         _beliefRewardSp = new BeliefRewardSp();
         addToContent(_beliefRewardSp);
         var joinRewardInfoTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.joinRewardInfoTf");
         joinRewardInfoTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.joinRewardInfoTfMsg",_model.joinRewardLeastOfferTimes);
         addToContent(joinRewardInfoTf);
         _joinBagCellSp = new JoinBagCellSp();
         PositionUtils.setPos(_joinBagCellSp,"ddQiYuan.joinBagCell1Pos");
         addToContent(_joinBagCellSp);
         bagCellBg = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
         var joinBagCell2Info:InventoryItemInfo = DDQiYuanManager.instance.getInventoryItemInfo(_model.joinRewardProbabilityGainGood);
         var joinBagCell2:BagCell = new BagCell(1,joinBagCell2Info,true,bagCellBg,false);
         joinBagCell2.PicPos = new Point(2,2);
         joinBagCell2.setContentSize(38,38);
         joinBagCell2.setCount(joinBagCell2Info.Count);
         PositionUtils.setPos(joinBagCell2,"ddQiYuan.joinBagCell2Pos");
         addToContent(joinBagCell2);
         var probabilityGainTf:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.probabilityGainTf");
         probabilityGainTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.probabilityGainTfMsg");
         addToContent(probabilityGainTf);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler);
         _towerEnterBtn.addEventListener("click",onBtnClick);
         _showGetBtn.addEventListener("click",onBtnClick);
         _offerRewardGoodsScrollPanelLeftBtn.addEventListener("click",onBtnClick);
         _offerRewardGoodsScrollPanelRightBtn.addEventListener("click",onBtnClick);
         _treasureBoxGoodsScrollPanelLeftBtn.addEventListener("click",onBtnClick);
         _treasureBoxGoodsScrollPanelRightBtn.addEventListener("click",onBtnClick);
         _offer1TimeBtn.addEventListener("click",onBtnClick);
         _offer10TimeBtn.addEventListener("click",onBtnClick);
         _openTreasureBoxBtn.addEventListener("click",onBtnClick);
         DDQiYuanManager.instance.addEventListener("event_op_back",onOpBack);
         DDQiYuanManager.instance.addEventListener("event_op_start",onOpStart);
         DDQiYuanManager.instance.addEventListener("event_change_type",onChangeTpye);
         _selectedCheckButton.addEventListener("click",__onselectedCheckButtoClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _showGetBtn.removeEventListener("click",onBtnClick);
         _offerRewardGoodsScrollPanelLeftBtn.removeEventListener("click",onBtnClick);
         _offerRewardGoodsScrollPanelRightBtn.removeEventListener("click",onBtnClick);
         _treasureBoxGoodsScrollPanelLeftBtn.removeEventListener("click",onBtnClick);
         _treasureBoxGoodsScrollPanelRightBtn.removeEventListener("click",onBtnClick);
         _offer1TimeBtn.removeEventListener("click",onBtnClick);
         _offer10TimeBtn.removeEventListener("click",onBtnClick);
         _openTreasureBoxBtn.removeEventListener("click",onBtnClick);
         DDQiYuanManager.instance.removeEventListener("event_op_back",onOpBack);
         DDQiYuanManager.instance.removeEventListener("event_op_start",onOpStart);
         DDQiYuanManager.instance.removeEventListener("event_change_type",onChangeTpye);
         _selectedCheckButton.removeEventListener("click",__onselectedCheckButtoClick);
      }
      
      private function update() : void
      {
         _gouYuNumTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.gouYuNum",PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12543));
         _treasureKeyNumTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.treasureKeyNum",PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(12544));
         _treasureBoxNumTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.treasureBoxNum",int(_model.myAreaOfferTimes / _model.offerTimesPerTreasureBox) - _model.hasGainTreasureBoxNum);
         var activedBaoZhuNum:int = Math.min(7,int(_model.myAreaOfferDegree / _model.offerTimesPerBaoZhu));
         _activedBaoZhuNumTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.activedBaoZhuNum",activedBaoZhuNum);
         _boGuAni.update(activedBaoZhuNum);
         var childIndex:int = _container.getChildIndex(_progressMc);
         _container.removeChildAt(childIndex);
         var progressMcIndex:int = Math.min(7,activedBaoZhuNum + 1);
         _progressMc = ComponentFactory.Instance.creat("DDQiYuan.mc.Progress" + progressMcIndex);
         if(activedBaoZhuNum == 7)
         {
            _progressMc.width = 360;
            _offerProgressTf.text = _model.offerTimesPerBaoZhu + "/" + _model.offerTimesPerBaoZhu;
         }
         else
         {
            _progressMc.width = _model.myAreaOfferDegree % _model.offerTimesPerBaoZhu / _model.offerTimesPerBaoZhu * 360;
            _offerProgressTf.text = _model.myAreaOfferDegree % _model.offerTimesPerBaoZhu + "/" + _model.offerTimesPerBaoZhu;
         }
         _progressMc.x = 109;
         _progressMc.y = 318;
         _container.addChildAt(_progressMc,childIndex);
         ObjectUtils.disposeObject(_progressBgMc);
         if(progressMcIndex > 1)
         {
            _progressBgMc = ComponentFactory.Instance.creat("DDQiYuan.mc.Progress" + (progressMcIndex - 1));
            _progressBgMc.x = 109;
            _progressBgMc.y = 318;
            _container.addChildAt(_progressBgMc,childIndex - 1);
         }
         _hasGetGoodsList.update();
         _beliefRewardSp.update();
      }
      
      private function onBtnClick(evt:MouseEvent) : void
      {
         var currentFrameIndex:int = 0;
         var currentFrameIndex2:int = 0;
         SoundManager.instance.playButtonSound();
         var target:* = evt.target;
         if(target == _towerEnterBtn)
         {
            SocketManager.Instance.out.queryDDQiYuanTowerTask();
         }
         else if(target == _showGetBtn)
         {
            _hasGetGoodsList.visible = !_hasGetGoodsList.visible;
         }
         else if(target == _offerRewardGoodsScrollPanelLeftBtn)
         {
            _offerRewardGoodsScrollPanel.hScrollbar.scrollValue = _offerRewardGoodsScrollPanel.hScrollbar.scrollValue - 45;
         }
         else if(target == _offerRewardGoodsScrollPanelRightBtn)
         {
            _offerRewardGoodsScrollPanel.hScrollbar.scrollValue = _offerRewardGoodsScrollPanel.hScrollbar.scrollValue + 45;
         }
         else if(target == _treasureBoxGoodsScrollPanelLeftBtn)
         {
            _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue = _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue - 45;
         }
         else if(target == _treasureBoxGoodsScrollPanelRightBtn)
         {
            _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue = _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue + 45;
         }
         else if(target == _offer1TimeBtn)
         {
            DDQiYuanManager.instance.useType = 0;
            currentFrameIndex = getButtonCurrentFrame(_offer1TimeBtn);
            if(currentFrameIndex == 1)
            {
               DDQiYuanManager.instance.sendOfferTimes(1);
            }
            else
            {
               setButtonFrame(_offer1TimeBtn,1);
               DDQiYuanManager.instance.continueOpen = 0;
               lockBtns(false);
            }
         }
         else if(target == _offer10TimeBtn)
         {
            DDQiYuanManager.instance.useType = 0;
            currentFrameIndex2 = getButtonCurrentFrame(_offer10TimeBtn);
            if(currentFrameIndex2 == 1)
            {
               DDQiYuanManager.instance.sendOfferTimes(10);
            }
            else
            {
               setButtonFrame(_offer10TimeBtn,1);
               DDQiYuanManager.instance.continueOpen = 0;
               lockBtns(false);
            }
         }
         else if(target == _openTreasureBoxBtn)
         {
            DDQiYuanManager.instance.sendDDQiYuanOpenTreasureBox();
         }
      }
      
      private function onChangeTpye(evt:Event) : void
      {
         setButtonFrame(_offer1TimeBtn,1);
         setButtonFrame(_offer10TimeBtn,1);
         DDQiYuanManager.instance.continueOpen = 0;
         lockBtns(false);
      }
      
      private function lockBtns(lock:Boolean) : void
      {
         var _loc2_:* = !lock;
         _offer10TimeBtn.enable = _loc2_;
         _offer1TimeBtn.enable = _loc2_;
         if(lock)
         {
            if(DDQiYuanManager.instance.continueOpen == 1)
            {
               _offer1TimeBtn.enable = true;
               setButtonFrame(_offer1TimeBtn,2);
            }
            else if(DDQiYuanManager.instance.continueOpen == 10)
            {
               _offer10TimeBtn.enable = true;
               setButtonFrame(_offer10TimeBtn,2);
            }
            _openTreasureBoxBtn.enable = false;
         }
         else
         {
            setButtonFrame(_offer1TimeBtn,1);
            setButtonFrame(_offer10TimeBtn,1);
            _openTreasureBoxBtn.enable = true;
         }
      }
      
      private function onOpStart(evt:Event) : void
      {
         if(_selectedCheckButton.selected)
         {
            if(DDQiYuanManager.instance.lastOpType == 1)
            {
               DDQiYuanManager.instance.continueOpen = 1;
            }
            else if(DDQiYuanManager.instance.lastOpType == 2)
            {
               DDQiYuanManager.instance.continueOpen = 10;
            }
            else
            {
               DDQiYuanManager.instance.continueOpen = 0;
            }
         }
         else
         {
            DDQiYuanManager.instance.continueOpen = 0;
         }
         lockBtns(true);
      }
      
      private function onOpBack(evt:CEvent) : void
      {
         evt = evt;
         update();
         if(DDQiYuanManager.instance.continueOpen == 0)
         {
            lockBtns(false);
         }
         if(DDQiYuanManager.instance.continueOpen > 0)
         {
            setTimeout(function():void
            {
               DDQiYuanManager.instance.dispatchEvent(new CEvent("event_op_framedispose"));
            },1000);
         }
      }
      
      private function responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DDQiYuanController.instance.disposeFrame();
         }
      }
      
      private function __onselectedCheckButtoClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function setButtonFrame($btn:BaseButton, $frameIndex:int) : void
      {
         var bg:ScaleFrameImage = $btn.backgound as ScaleFrameImage;
         bg.setFrame($frameIndex);
      }
      
      private function getButtonCurrentFrame($btn:BaseButton) : int
      {
         var bg:ScaleFrameImage = $btn.backgound as ScaleFrameImage;
         return bg.getFrame;
      }
      
      override public function dispose() : void
      {
         DDQiYuanManager.instance.continueOpen = 0;
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _btnHelp = null;
         _towerEnterBtn = null;
         _gouYuNumTf = null;
         _treasureKeyNumTf = null;
         _treasureBoxNumTf = null;
         _progressMc = null;
         _progressBgMc = null;
         _activedBaoZhuNumTf = null;
         _showGetBtn = null;
         _hasGetGoodsList = null;
         _offerProgressTf = null;
         _offer1TimeBtn = null;
         _offer10TimeBtn = null;
         _openTreasureBoxBtn = null;
         _offerRewardGoodsScrollPanel = null;
         _treasureBoxGoodsScrollPanel = null;
         _offerRewardGoodsScrollPanelLeftBtn = null;
         _offerRewardGoodsScrollPanelRightBtn = null;
         _treasureBoxGoodsScrollPanelLeftBtn = null;
         _treasureBoxGoodsScrollPanelRightBtn = null;
         _rankSp = null;
         _beliefRewardSp = null;
         _model = null;
         _boGuAni = null;
         _joinBagCellSp = null;
         _selectedCheckButton = null;
      }
   }
}
