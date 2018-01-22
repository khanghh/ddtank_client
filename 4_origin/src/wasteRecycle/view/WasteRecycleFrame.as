package wasteRecycle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.LookTrophy;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import wasteRecycle.WasteRecycleController;
   import wasteRecycle.WasteRecycleManager;
   
   public class WasteRecycleFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _frameBg:ScaleBitmapImage;
      
      private var _recycleBtn:SimpleBitmapButton;
      
      private var _recycleCell:WasteRecycleGoodsCell;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _awardShowBtn:SimpleBitmapButton;
      
      private var _recycleTips:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _bagView:WasteRecycleBagView;
      
      private var _turnView:WasteRecycleTurnView;
      
      private var _lookTrophy:LookTrophy;
      
      private var _limitText:FilterFrameText;
      
      private var _currentScore:int;
      
      private var _currentCount:int;
      
      private var _continuousOpenBtn:SelectedCheckButton;
      
      private var _btnHelp:BaseButton;
      
      public function WasteRecycleFrame()
      {
         super();
      }
      
      public function show() : void
      {
         SocketManager.Instance.out.sendWasteRecycleEnter();
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function init() : void
      {
         BagStore.instance.isInBagStoreFrame = false;
         InviteManager.Instance.enabled = false;
         _bg = ComponentFactory.Instance.creatBitmap("asset.wasteRecycle.bg");
         _lookTrophy = ComponentFactory.Instance.creatCustomObject("wasteRecycle.lookTrophy");
         _frameBg = ComponentFactory.Instance.creatComponentByStylename("asset.wasteRecycle.frameBg");
         _recycleBtn = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.recycleBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.startBtn");
         _awardShowBtn = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.awardBtn");
         _limitText = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.limitText");
         _recycleTips = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.recycleTips");
         _recycleTips.text = LanguageMgr.GetTranslation("ddt.wasteRecycle.tips",WasteRecycleController.instance.model.lotteryScore);
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.scoreText");
         _continuousOpenBtn = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.continuousOpenBtn");
         _continuousOpenBtn.text = LanguageMgr.GetTranslation("ddt.wasteRecycle.continuousLottery");
         updateLottery(0,0);
         _bagView = new WasteRecycleBagView();
         _bagView.isNeedCard(false);
         _bagView.cardbtnVible = false;
         _bagView.tableEnable = true;
         _bagView.info = PlayerManager.Instance.Self;
         _bagView.initBeadButton();
         _bagView.switchButtomVisible(true);
         PositionUtils.setPos(_bagView,"wasteRecycle.bagViewPos");
         _recycleCell = new WasteRecycleGoodsCell(cellBg());
         _recycleCell.refreshTbxPos();
         _recycleCell.tbxCount.y = 50;
         PositionUtils.setPos(_recycleCell,"wasteRecycle.recycleCellPos");
         _turnView = new WasteRecycleTurnView();
         PositionUtils.setPos(_turnView,"wasteRecycle.turnViewPos");
         _btnHelp = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helperFrame.helpBtn");
         super.init();
         initEvent();
         titleText = LanguageMgr.GetTranslation("ddt.wasteRecycle.title");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_frameBg)
         {
            addToContent(_frameBg);
         }
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_recycleBtn)
         {
            addToContent(_recycleBtn);
         }
         if(_startBtn)
         {
            addToContent(_startBtn);
         }
         if(_awardShowBtn)
         {
            addToContent(_awardShowBtn);
         }
         if(_recycleTips)
         {
            addToContent(_recycleTips);
         }
         if(_scoreText)
         {
            addToContent(_scoreText);
         }
         if(_bagView)
         {
            addToContent(_bagView);
         }
         if(_recycleCell)
         {
            addToContent(_recycleCell);
         }
         if(_turnView)
         {
            addToContent(_turnView);
         }
         if(_limitText)
         {
            addToContent(_limitText);
         }
         if(_continuousOpenBtn)
         {
            addToContent(_continuousOpenBtn);
         }
         if(_btnHelp)
         {
            addToContent(_btnHelp);
         }
      }
      
      private function __onRecycleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(WasteRecycleController.instance.isPlay)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.turning"));
            return;
         }
         if(!WasteRecycleManager.Instance.isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.activityEnd"));
            return;
         }
         if(_recycleCell.info)
         {
            SocketManager.Instance.out.sendWasteRecycleGoods(_recycleCell.itemInfo.Count);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notRecycleGoods"));
         }
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         WasteRecycleController.instance.openHelpFram();
      }
      
      private function __onComplete(param1:Event) : void
      {
         if(_continuousOpenBtn.selected)
         {
            __onStartClick(null);
         }
      }
      
      private function __onStartClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(WasteRecycleController.instance.isPlay)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.turning"));
            return;
         }
         if(WasteRecycleController.instance.model.lotteryScore > _currentScore)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.lotterySocreTips"));
            return;
         }
         if(TimeManager.Instance.Now().time > WasteRecycleManager.Instance.endDate.time)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.activityEnd"));
            return;
         }
         WasteRecycleController.instance.isPlay = true;
         SocketManager.Instance.out.sendWasteRecycleStartTurn();
      }
      
      private function __onAwardClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(WasteRecycleController.instance.isPlay)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.turning"));
            return;
         }
         _lookTrophy.show(WasteRecycleController.instance.model.trophyList);
      }
      
      private function updateLottery(param1:int, param2:int) : void
      {
         _currentScore = param1;
         WasteRecycleController.instance.model.lotteryDonateScore = param2;
         _scoreText.text = LanguageMgr.GetTranslation("ddt.wasteRecycle.lotteryScore",param1);
         var _loc3_:int = WasteRecycleController.instance.model.lotteryLimitScore;
         _limitText.text = LanguageMgr.GetTranslation("ddt.wasteRecycle.lotteryLimit",param2,_loc3_);
      }
      
      override protected function onResponse(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(WasteRecycleController.instance.isPlay)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.turning"));
            return;
         }
         super.onResponse(param1);
      }
      
      override protected function onFrameClose() : void
      {
         this.dispose();
      }
      
      private function __onStartTurn(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         var _loc8_:int = param1.pkg.readInt();
         var _loc7_:int = param1.pkg.readInt();
         var _loc9_:String = "";
         _loc10_ = 0;
         while(_loc10_ < _loc7_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _loc6_ = ItemManager.Instance.getTemplateById(_loc2_).Name + " x " + _loc4_ + " ";
            _loc9_ = _loc9_ + _loc6_;
            _loc10_++;
         }
         _turnView.playAction(_loc8_,_loc9_);
         updateLottery(_loc3_,_loc5_);
      }
      
      private function __onUpdateScore(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         updateLottery(_loc2_,_loc3_);
      }
      
      private function __updateGoods(param1:BagEvent) : void
      {
         _recycleCell.info = PlayerManager.Instance.Self.StoreBag.items[0];
      }
      
      private function initEvent() : void
      {
         WasteRecycleController.instance.addEventListener("complete",__onComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(346,1),__onUpdateScore);
         SocketManager.Instance.addEventListener(PkgEvent.format(346,3),__onStartTurn);
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateGoods);
         _recycleBtn.addEventListener("click",__onRecycleClick);
         _startBtn.addEventListener("click",__onStartClick);
         _awardShowBtn.addEventListener("click",__onAwardClick);
         _btnHelp.addEventListener("click",__onHelpClick);
      }
      
      private function removeEvent() : void
      {
         WasteRecycleController.instance.removeEventListener("complete",__onComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(346,1),__onUpdateScore);
         SocketManager.Instance.removeEventListener(PkgEvent.format(346,3),__onStartTurn);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateGoods);
         _recycleBtn.removeEventListener("click",__onRecycleClick);
         _startBtn.removeEventListener("click",__onStartClick);
         _awardShowBtn.removeEventListener("click",__onAwardClick);
         _btnHelp.removeEventListener("click",__onHelpClick);
      }
      
      private function cellBg() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,70,70);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         BagStore.instance.isInBagStoreFrame = true;
         InviteManager.Instance.enabled = true;
         removeEvent();
         ObjectUtils.disposeObject(_lookTrophy);
         super.dispose();
         _frameBg = null;
         _bg = null;
         _recycleBtn = null;
         _startBtn = null;
         _awardShowBtn = null;
         _recycleTips = null;
         _scoreText = null;
         _bagView = null;
         _turnView = null;
         _recycleCell = null;
         _lookTrophy = null;
         _limitText = null;
         _continuousOpenBtn = null;
         _btnHelp = null;
      }
   }
}
