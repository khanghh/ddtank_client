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
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
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
         var _loc7_:Image = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerProgressUp");
         addToContent(_loc7_);
         _showGetBtn = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.showGetBtn");
         addToContent(_showGetBtn);
         _hasGetGoodsList = ComponentFactory.Instance.creatCustomObject("ddQiYuan.HasGetGoodsList");
         addToContent(_hasGetGoodsList);
         _offerProgressTf = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerProgressTf");
         addToContent(_offerProgressTf);
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.offerInfoTf");
         addToContent(_loc5_);
         _loc5_.text = LanguageMgr.GetTranslation("ddQiYuan.frame.offerInfoTfMsg");
         var _loc9_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.openTreasureBoxInfoTf");
         addToContent(_loc9_);
         _loc9_.text = LanguageMgr.GetTranslation("ddQiYuan.frame.openTreasureBoxInfoTfMsg");
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
         var _loc6_:HBox = new HBox();
         _loc6_.spacing = 5;
         var _loc14_:int = 0;
         var _loc13_:* = _model.offer1Or10TimesRewardBoxGoodArr;
         for each(_loc8_ in _model.offer1Or10TimesRewardBoxGoodArr)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
            _loc2_ = new BagCell(1,ItemManager.Instance.getTemplateById(_loc8_),true,_loc3_,false);
            _loc2_.setCountNotVisible();
            _loc2_.PicPos = new Point(2,2);
            _loc2_.setContentSize(38,38);
            _loc6_.addChild(_loc2_);
         }
         _offerRewardGoodsScrollPanel.setView(_loc6_);
         _offerRewardGoodsScrollPanel.invalidateViewport();
         addToContent(_offerRewardGoodsScrollPanel);
         _treasureBoxGoodsScrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.treasureBoxGoodsScrollPanel");
         var _loc12_:HBox = new HBox();
         _loc12_.spacing = 5;
         var _loc16_:int = 0;
         var _loc15_:* = _model.openTreasureBoxGoodArr;
         for each(_loc8_ in _model.openTreasureBoxGoodArr)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
            _loc2_ = new BagCell(1,ItemManager.Instance.getTemplateById(_loc8_),true,_loc3_,false);
            _loc2_.setCountNotVisible();
            _loc2_.PicPos = new Point(2,2);
            _loc2_.setContentSize(38,38);
            _loc12_.addChild(_loc2_);
         }
         _treasureBoxGoodsScrollPanel.setView(_loc12_);
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
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.joinRewardInfoTf");
         _loc4_.text = LanguageMgr.GetTranslation("ddQiYuan.frame.joinRewardInfoTfMsg",_model.joinRewardLeastOfferTimes);
         addToContent(_loc4_);
         _joinBagCellSp = new JoinBagCellSp();
         PositionUtils.setPos(_joinBagCellSp,"ddQiYuan.joinBagCell1Pos");
         addToContent(_joinBagCellSp);
         _loc3_ = ComponentFactory.Instance.creatBitmap("DDQiYuan.Pic27");
         var _loc1_:InventoryItemInfo = DDQiYuanManager.instance.getInventoryItemInfo(_model.joinRewardProbabilityGainGood);
         var _loc10_:BagCell = new BagCell(1,_loc1_,true,_loc3_,false);
         _loc10_.PicPos = new Point(2,2);
         _loc10_.setContentSize(38,38);
         _loc10_.setCount(_loc1_.Count);
         PositionUtils.setPos(_loc10_,"ddQiYuan.joinBagCell2Pos");
         addToContent(_loc10_);
         var _loc11_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.probabilityGainTf");
         _loc11_.text = LanguageMgr.GetTranslation("ddQiYuan.frame.probabilityGainTfMsg");
         addToContent(_loc11_);
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
         var _loc1_:int = Math.min(7,int(_model.myAreaOfferDegree / _model.offerTimesPerBaoZhu));
         _activedBaoZhuNumTf.text = LanguageMgr.GetTranslation("ddQiYuan.frame.activedBaoZhuNum",_loc1_);
         _boGuAni.update(_loc1_);
         var _loc3_:int = _container.getChildIndex(_progressMc);
         _container.removeChildAt(_loc3_);
         var _loc2_:int = Math.min(7,_loc1_ + 1);
         _progressMc = ComponentFactory.Instance.creat("DDQiYuan.mc.Progress" + _loc2_);
         if(_loc1_ == 7)
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
         _container.addChildAt(_progressMc,_loc3_);
         ObjectUtils.disposeObject(_progressBgMc);
         if(_loc2_ > 1)
         {
            _progressBgMc = ComponentFactory.Instance.creat("DDQiYuan.mc.Progress" + (_loc2_ - 1));
            _progressBgMc.x = 109;
            _progressBgMc.y = 318;
            _container.addChildAt(_progressBgMc,_loc3_ - 1);
         }
         _hasGetGoodsList.update();
         _beliefRewardSp.update();
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc3_:* = param1.target;
         if(_loc3_ == _towerEnterBtn)
         {
            SocketManager.Instance.out.queryDDQiYuanTowerTask();
         }
         else if(_loc3_ == _showGetBtn)
         {
            _hasGetGoodsList.visible = !_hasGetGoodsList.visible;
         }
         else if(_loc3_ == _offerRewardGoodsScrollPanelLeftBtn)
         {
            _offerRewardGoodsScrollPanel.hScrollbar.scrollValue = _offerRewardGoodsScrollPanel.hScrollbar.scrollValue - 45;
         }
         else if(_loc3_ == _offerRewardGoodsScrollPanelRightBtn)
         {
            _offerRewardGoodsScrollPanel.hScrollbar.scrollValue = _offerRewardGoodsScrollPanel.hScrollbar.scrollValue + 45;
         }
         else if(_loc3_ == _treasureBoxGoodsScrollPanelLeftBtn)
         {
            _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue = _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue - 45;
         }
         else if(_loc3_ == _treasureBoxGoodsScrollPanelRightBtn)
         {
            _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue = _treasureBoxGoodsScrollPanel.hScrollbar.scrollValue + 45;
         }
         else if(_loc3_ == _offer1TimeBtn)
         {
            DDQiYuanManager.instance.useType = 0;
            _loc2_ = getButtonCurrentFrame(_offer1TimeBtn);
            if(_loc2_ == 1)
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
         else if(_loc3_ == _offer10TimeBtn)
         {
            DDQiYuanManager.instance.useType = 0;
            _loc4_ = getButtonCurrentFrame(_offer10TimeBtn);
            if(_loc4_ == 1)
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
         else if(_loc3_ == _openTreasureBoxBtn)
         {
            DDQiYuanManager.instance.sendDDQiYuanOpenTreasureBox();
         }
      }
      
      private function onChangeTpye(param1:Event) : void
      {
         setButtonFrame(_offer1TimeBtn,1);
         setButtonFrame(_offer10TimeBtn,1);
         DDQiYuanManager.instance.continueOpen = 0;
         lockBtns(false);
      }
      
      private function lockBtns(param1:Boolean) : void
      {
         var _loc2_:* = !param1;
         _offer10TimeBtn.enable = _loc2_;
         _offer1TimeBtn.enable = _loc2_;
         if(param1)
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
      
      private function onOpStart(param1:Event) : void
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
      
      private function onOpBack(param1:CEvent) : void
      {
         evt = param1;
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
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DDQiYuanController.instance.disposeFrame();
         }
      }
      
      private function __onselectedCheckButtoClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function setButtonFrame(param1:BaseButton, param2:int) : void
      {
         var _loc3_:ScaleFrameImage = param1.backgound as ScaleFrameImage;
         _loc3_.setFrame(param2);
      }
      
      private function getButtonCurrentFrame(param1:BaseButton) : int
      {
         var _loc2_:ScaleFrameImage = param1.backgound as ScaleFrameImage;
         return _loc2_.getFrame;
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
