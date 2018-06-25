package luckStar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.AwardsView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import luckStar.cell.LuckStarCell;
   import luckStar.event.LuckStarEvent;
   import luckStar.manager.LuckStarManager;
   import luckStar.manager.LuckStarTurnControl;
   import shop.manager.ShopBuyManager;
   import store.HelpFrame;
   import store.HelpPrompt;
   
   public class LuckStarFrame extends Frame
   {
      
      private static const MAX_CELL:int = 14;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _superLuckyStarBg:Bitmap;
      
      private var _luckyStarCount:int = 10;
      
      private var _cell:Vector.<LuckStarCell>;
      
      private var _startBtn:BaseButton;
      
      private var _stopBtn:BaseButton;
      
      private var _autoCheck:SelectedCheckButton;
      
      private var _numText:FilterFrameText;
      
      private var _coinsView:LuckStarCoinsView;
      
      private var _rankView:LuckStarRankView;
      
      private var _buyBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _explain:FilterFrameText;
      
      private var _coins:FilterFrameText;
      
      private var _coinsAward:FilterFrameText;
      
      private var _awardAction:MovieClip;
      
      private var _turnControl:LuckStarTurnControl;
      
      private var _select:int;
      
      private var _rewardList:Array;
      
      private var _turnComplete:Boolean = true;
      
      private var _helpNumText:FilterFrameText;
      
      private var _helpRewardPrice:FilterFrameText;
      
      private var _getRewardPrice:int;
      
      private var _frame:BaseAlerFrame;
      
      private var _alert:BaseAlerFrame;
      
      public function LuckStarFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.scale9ImageBg");
         _superLuckyStarBg = ComponentFactory.Instance.creatBitmap("luckyStar.view.SuperLuckyStarBg");
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.AutoOpenButton");
         _numText = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.starNumText");
         _startBtn = ComponentFactory.Instance.creat("luckyStar.view.TurnStartBtn");
         _startBtn.tipData = LanguageMgr.GetTranslation("ddt.luckStar.buttonTip");
         _stopBtn = ComponentFactory.Instance.creat("luckyStar.view.TurnStopBtn");
         _stopBtn.tipData = LanguageMgr.GetTranslation("ddt.luckStar.stopBtnTip");
         _coinsView = ComponentFactory.Instance.creatCustomObject("luckyStar.view.luckyStarCoinsView");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.BoxBtn");
         _buyBtn.tipData = LanguageMgr.GetTranslation("ddt.luckStar.buyLuckStar");
         _rankView = new LuckStarRankView();
         PositionUtils.setPos(_rankView,"luckyStar.view.rankViewPos");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.HelpBtn");
         _getRewardPrice = ShopManager.Instance.getMoneyShopItemByTemplateID(201192).getItemPrice(1).bothMoneyValue / 2;
         _explain = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.explainText");
         _explain.text = LanguageMgr.GetTranslation("ddt.luckStar.explain",_getRewardPrice);
         _coins = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.coinsText");
         _coins.text = _getRewardPrice + LanguageMgr.GetTranslation("money");
         _coinsAward = ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.coinsAwardText");
         _coinsAward.text = LanguageMgr.GetTranslation("ddt.luckStar.explainAward");
         _turnControl = new LuckStarTurnControl();
         addToContent(_bg);
         addToContent(_helpBtn);
         addToContent(_superLuckyStarBg);
         addToContent(_startBtn);
         addToContent(_stopBtn);
         addToContent(_coinsView);
         addToContent(_buyBtn);
         addToContent(_numText);
         addToContent(_autoCheck);
         addToContent(_rankView);
         addToContent(_explain);
         addToContent(_coins);
         addToContent(_coinsAward);
         _rewardList = [];
         _cell = new Vector.<LuckStarCell>();
         for(i = 0; i < 14; )
         {
            cell = new LuckStarCell();
            cell.selected = false;
            PositionUtils.setPos(cell,"luckyStar.view.cellPos" + i);
            cell.addEventListener("luckystarevent",__onPlayActionEnd);
            _cell.push(cell);
            addToContent(cell);
            i++;
         }
         _autoCheck.addEventListener("select",__selectedChanged);
         _startBtn.addEventListener("click",__onStartLuckyStar);
         _stopBtn.addEventListener("click",__onStopLuckyStar);
         _buyBtn.addEventListener("click",__onBuyLuckyStar);
         _helpBtn.addEventListener("click",__onHelpClick);
         _turnControl.addEventListener("turn_complete",__onTurnComplete);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onbagUpdate);
         updateCellInfo();
         updateLuckyStarCount();
         updateLuckyStarCoins();
         aotuButton = false;
      }
      
      private function __onHelpClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpPrompt:HelpPrompt = ComponentFactory.Instance.creat("luckyStar.view.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("luckyStar.view.HelpFrame");
         helpPage.setView(helpPrompt);
         helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         if(!_helpNumText)
         {
            _helpNumText = ComponentFactory.Instance.creat("luckyStar.view.HelpNumText");
         }
         if(!_helpRewardPrice)
         {
            _helpRewardPrice = ComponentFactory.Instance.creat("luckyStar.view.HelpNumText");
         }
         PositionUtils.setPos(_helpRewardPrice,"luckyStar.view.helpRewardPricePos");
         _helpNumText.text = LuckStarManager.Instance.model.minUseNum.toString();
         _helpRewardPrice.text = _coins.text;
         helpPage.addChild(_helpRewardPrice);
         helpPage.addChild(_helpNumText);
         LayerManager.Instance.addToLayer(helpPage,1,true,1);
      }
      
      private function __selectedChanged(e:Event) : void
      {
         SoundManager.instance.play("008");
         if(_turnControl.turnContinue == _autoCheck.selected)
         {
            return;
         }
         _turnControl.turnContinue = _autoCheck.selected;
         if(_turnControl.isTurn)
         {
            if(_autoCheck.selected)
            {
               aotuButton = true;
            }
            else
            {
               aotuButton = false;
            }
         }
      }
      
      public function getAwardGoods(goods:InventoryItemInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < _cell.length; )
         {
            if(_cell[i].info.TemplateID == goods.TemplateID)
            {
               _select = i;
            }
            i++;
         }
         _rewardList.push(goods);
         startTurn();
      }
      
      private function __onPlayActionEnd(e:LuckStarEvent) : void
      {
         if(e.code == 4)
         {
            SocketManager.Instance.out.sendLuckyStarTurnComplete();
            if(_cell[_select].isMaxAward)
            {
               LuckStarManager.Instance.model.coins = 1000;
            }
            if(_autoCheck.selected && _luckyStarCount > 0 && LuckStarManager.Instance.isOpen)
            {
               turnLuckyStar();
            }
            else
            {
               showAward();
            }
         }
      }
      
      private function showAward() : void
      {
         if(!LuckStarManager.Instance.isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.luckStar.activityOver"));
         }
         SoundManager.instance.resumeMusic();
         _turnComplete = true;
         aotuButton = false;
         if(_rewardList.length > 1)
         {
            showAwardFrame();
            return;
         }
         _rewardList.splice(0,_rewardList.length);
      }
      
      private function showAwardFrame() : void
      {
         if(_frame)
         {
            return;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.ItemPreviewListFrame");
         var aView:AwardsView = new AwardsView();
         aView.goodsList = _rewardList;
         aView.boxType = 4;
         var title:FilterFrameText = ComponentFactory.Instance.creat("bagandinfo.awardsFFT");
         title.text = LanguageMgr.GetTranslation("roulette.tipTxt4");
         var alterInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("dice.reward.title"));
         alterInfo.showCancel = false;
         alterInfo.moveEnable = false;
         _frame.info = alterInfo;
         _frame.addToContent(aView);
         _frame.addToContent(title);
         _frame.addEventListener("response",__onFrameClose);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function __onFrameClose(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         BaseAlerFrame(e.currentTarget).removeEventListener("response",__onFrameClose);
         ObjectUtils.disposeObject(e.currentTarget);
         _frame = null;
         _rewardList.splice(0,_rewardList.length);
      }
      
      private function __onTurnComplete(e:Event) : void
      {
         _cell[_select].selected = false;
         if(_cell[_select].isMaxAward)
         {
            _autoCheck.selected = false;
         }
         _cell[_select].playAction();
      }
      
      private function __onStartLuckyStar(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(LuckStarManager.Instance.isOpen)
         {
            turnLuckyStar();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.luckStar.activityOver"));
         }
      }
      
      private function __onStopLuckyStar(e:MouseEvent) : void
      {
         aotuButton = false;
      }
      
      private function set aotuButton(value:Boolean) : void
      {
         if(value)
         {
            _startBtn.enable = false;
            if(_autoCheck.selected)
            {
               _stopBtn.visible = true;
               _startBtn.visible = false;
            }
         }
         else
         {
            _startBtn.visible = true;
            if(!_turnControl.isTurn)
            {
               _startBtn.enable = true;
            }
            _autoCheck.selected = false;
            _stopBtn.visible = false;
         }
      }
      
      private function turnLuckyStar() : void
      {
         if(_luckyStarCount <= 0)
         {
            helpBuyAlert();
         }
         else
         {
            aotuButton = true;
            SocketManager.Instance.out.sendLuckyStarTurn();
         }
      }
      
      private function helpBuyAlert() : void
      {
         _alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("church.churchScene.SceneUI.info"),LanguageMgr.GetTranslation("ddt.luckStar.notLuckStar"),"","",true,true,true,1);
         _alert.moveEnable = false;
         _alert.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _alert.removeEventListener("response",__onResponse);
         ObjectUtils.disposeObject(_alert);
         _alert = null;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            buyStar();
         }
      }
      
      private function startTurn() : void
      {
         SoundManager.instance.pauseMusic();
         _turnComplete = false;
         aotuButton = true;
         playCoinsAction();
         _turnControl.turnContinue = _autoCheck.selected;
         _turnControl.turn(_cell,_select - 1);
      }
      
      private function playCoinsAction() : void
      {
         if(_awardAction)
         {
            _awardAction.stop();
            _awardAction.removeEventListener("enterFrame",disposeAwardAction);
         }
         ObjectUtils.disposeObject(_awardAction);
         _awardAction = null;
         _awardAction = ComponentFactory.Instance.creat("luckyStar.view.CoinsAwardAction");
         PositionUtils.setPos(_awardAction,"luckyStar.view.awardActionPos");
         addToContent(_awardAction);
         _awardAction.gotoAndPlay(1);
         _awardAction.addEventListener("enterFrame",disposeAwardAction);
      }
      
      private function disposeAwardAction(e:Event) : void
      {
         if(_awardAction.currentFrame == _awardAction.totalFrames - 1)
         {
            if(_awardAction)
            {
               _awardAction.stop();
               _awardAction.removeEventListener("enterFrame",disposeAwardAction);
            }
            ObjectUtils.disposeObject(_awardAction);
            _awardAction = null;
         }
      }
      
      public function __onBuyLuckyStar(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         buyStar();
      }
      
      private function buyStar() : void
      {
         var _shopItemInfo:ShopItemInfo = ShopManager.Instance.getShopItemByTemplateID(201192,3);
         ShopBuyManager.Instance.buy(_shopItemInfo.GoodsID,_shopItemInfo.isDiscount,_shopItemInfo.getItemPrice(1).PriceType);
      }
      
      public function __onbagUpdate(e:BagEvent) : void
      {
         updateLuckyStarCount();
      }
      
      private function updateLuckyStarCount() : void
      {
         var count:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201192);
         if(_luckyStarCount != count)
         {
            _luckyStarCount = count;
            _numText.text = _luckyStarCount.toString();
         }
      }
      
      public function updateCellInfo() : void
      {
         var i:int = 0;
         var len:int = LuckStarManager.Instance.model.goods.length;
         if(!_cell)
         {
            return;
         }
         i = 0;
         while(i < 14 && i < len)
         {
            _cell[i].info = LuckStarManager.Instance.model.goods[i];
            _cell[i].info.Quality = ItemManager.Instance.getTemplateById(_cell[i].info.TemplateID).Quality;
            _cell[i].count = LuckStarManager.Instance.model.goods[i].Count;
            i++;
         }
      }
      
      public function updateMinUseNum() : void
      {
         _rankView.updateHelpText();
      }
      
      public function updateLuckyStarCoins() : void
      {
         if(LuckStarManager.Instance.model.coins != 0)
         {
            _coinsView.count = LuckStarManager.Instance.model.coins;
         }
      }
      
      public function updateRankInfo() : void
      {
         _rankView.lastUpdateTime();
         _rankView.updateSelfInfo();
         _rankView.updateRankInfo();
         updateActivityDate();
      }
      
      public function updateActivityDate() : void
      {
         _rankView.updateActivityDate();
      }
      
      public function updatePlayActionList() : void
      {
         _rankView.updateNewAwardList();
      }
      
      public function updateNewAwardList(name:String, award:int, count:int) : void
      {
         _rankView.insertNewAwardItem(name,award,count);
      }
      
      public function get isTurn() : Boolean
      {
         return !_turnComplete;
      }
      
      override public function dispose() : void
      {
         var cell:* = null;
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__onbagUpdate);
         _startBtn.removeEventListener("click",__onStartLuckyStar);
         _stopBtn.removeEventListener("click",__onStopLuckyStar);
         _autoCheck.removeEventListener("select",__selectedChanged);
         _helpBtn.removeEventListener("click",__onHelpClick);
         _buyBtn.removeEventListener("click",__onBuyLuckyStar);
         _turnControl.removeEventListener("turn_complete",__onTurnComplete);
         if(_frame)
         {
            _frame.removeEventListener("response",__onFrameClose);
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_superLuckyStarBg);
         _superLuckyStarBg = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_stopBtn);
         _stopBtn = null;
         while(_cell.length)
         {
            cell = _cell.pop();
            cell.removeEventListener("luckystarevent",__onPlayActionEnd);
            ObjectUtils.disposeObject(cell);
         }
         _rewardList = null;
         _cell = null;
         ObjectUtils.disposeObject(_autoCheck);
         _autoCheck = null;
         ObjectUtils.disposeObject(_numText);
         _numText = null;
         ObjectUtils.disposeObject(_coinsView);
         _coinsView = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_explain);
         _explain = null;
         ObjectUtils.disposeObject(_coins);
         _coins = null;
         ObjectUtils.disposeObject(_coinsAward);
         _coinsAward = null;
         ObjectUtils.disposeObject(_helpNumText);
         _helpNumText = null;
         ObjectUtils.disposeObject(_helpRewardPrice);
         _helpRewardPrice = null;
         if(_awardAction)
         {
            _awardAction.stop();
            _awardAction.removeEventListener("enterFrame",disposeAwardAction);
         }
         ObjectUtils.disposeObject(_awardAction);
         _awardAction = null;
         if(_turnControl)
         {
            _turnControl.dispose();
            _turnControl = null;
         }
         super.dispose();
      }
   }
}
