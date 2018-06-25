package cloudBuyLottery.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import store.HelpFrame;
   
   public class CloudBuyLotteryFrame extends Frame
   {
      
      public static const MOVE_SPEED:Number = 0.8;
      
      public static var logFrameFlag:Boolean;
       
      
      private var _bg:Bitmap;
      
      private var showTimes:MovieClip;
      
      private var timeArray:Array;
      
      private var _timer:Timer;
      
      private var _helpBtn:BaseButton;
      
      private var _jubaoBtn:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _finish:Bitmap;
      
      private var _expBar:ExpBar;
      
      private var _luckNumTxt:FilterFrameText;
      
      private var _chanceTxt:FilterFrameText;
      
      private var _showBuyNumTxt:FilterFrameText;
      
      private var _buyNumTxt:FilterFrameText;
      
      private var _buyGoodsMoneyTxt:FilterFrameText;
      
      private var _helpTxt:FilterFrameText;
      
      private var _tipsframe:BaseAlerFrame;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _moneyNumText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _text:FilterFrameText;
      
      private var _cell:BagCell;
      
      private var _logTxt:FilterFrameText;
      
      private var _logSprite:Sprite;
      
      private var winningLogFrame:TheWinningLog;
      
      private var _infoWidth:Number;
      
      private var _numberK:Bitmap;
      
      private var _numberKTxt:FilterFrameText;
      
      private var luckLooteryFrame:IndividualLottery;
      
      private var _buyGoodsSprite:Component;
      
      public function CloudBuyLotteryFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.cloudbuy.bg");
         showTimes = ClassUtils.CreatInstance("asset.cloudbuy.showTime") as MovieClip;
         PositionUtils.setPos(showTimes,"CloudBuyLotteryFrame.showTimesMC");
         _helpBtn = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.helpBtn");
         _jubaoBtn = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.jubaoBtn");
         _buyBtn = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.buyBtn");
         _finish = ComponentFactory.Instance.creatBitmap("asset.cloudbuy.finish");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.expBar");
         _luckNumTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.luckNumTxt");
         _luckNumTxt.text = CloudBuyLotteryManager.Instance.model.luckCount.toString();
         _chanceTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.chanceTxt");
         _chanceTxt.text = CloudBuyLotteryManager.Instance.model.luckCount + "/" + CloudBuyLotteryManager.Instance.model.maxNum;
         _showBuyNumTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.showBuyNumTxt");
         _showBuyNumTxt.text = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.showBuyNum");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.buyNumTxt");
         _buyNumTxt.text = CloudBuyLotteryManager.Instance.model.currentNum.toString();
         _buyGoodsMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.buyGoodsMoneyTxt");
         _buyGoodsMoneyTxt.text = LanguageMgr.GetTranslation("cloudBuyLotteryFrame.buyGoodsMoneyTxt",CloudBuyLotteryManager.Instance.model.buyMoney.toString());
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.helpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.help");
         _logTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.logTxt");
         _logTxt.text = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.log");
         _logSprite = new Sprite();
         _logSprite.addChild(_logTxt);
         _logSprite.buttonMode = true;
         PositionUtils.setPos(_logSprite,"CloudBuyLotteryFrame.logSprite");
         _numberK = ComponentFactory.Instance.creatBitmap("asset.cloudbuy.numberK");
         _numberKTxt = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.numberKTxt");
         _numberKTxt.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
         addToContent(_bg);
         addToContent(showTimes);
         addToContent(_helpBtn);
         addToContent(_jubaoBtn);
         addToContent(_buyBtn);
         addToContent(_finish);
         addToContent(_expBar);
         addToContent(_luckNumTxt);
         addToContent(_chanceTxt);
         addToContent(_showBuyNumTxt);
         addToContent(_buyNumTxt);
         addToContent(_buyGoodsMoneyTxt);
         addToContent(_helpTxt);
         addToContent(_logSprite);
         addToContent(_numberK);
         addToContent(_numberKTxt);
         timesNum();
         luckGoodsCell(CloudBuyLotteryManager.Instance.model.templateId);
         buyGoodsCell(CloudBuyLotteryManager.Instance.model.buyGoodsIDArray);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__updateTimes);
         _timer.start();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         _buyBtn.addEventListener("click",__onBuyClick);
         _jubaoBtn.addEventListener("click",__onJuBaoClick);
         _logSprite.addEventListener("click",__onLogClick);
         CloudBuyLotteryManager.Instance.addEventListener("updateInfo",__updateInfo);
         CloudBuyLotteryManager.Instance.addEventListener("frmeupdate",__frmeUpdateInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
         _buyBtn.removeEventListener("click",__onBuyClick);
         _jubaoBtn.removeEventListener("click",__onJuBaoClick);
         _logSprite.removeEventListener("click",__onLogClick);
         CloudBuyLotteryManager.Instance.removeEventListener("updateInfo",__updateInfo);
         CloudBuyLotteryManager.Instance.removeEventListener("frmeupdate",__frmeUpdateInfo);
      }
      
      override public function set width(w:Number) : void
      {
         .super.width = w;
         _infoWidth = w;
      }
      
      private function __updateInfo(e:Event) : void
      {
         timesNum();
         luckGoodsCell(CloudBuyLotteryManager.Instance.model.templateId);
         buyGoodsCell(CloudBuyLotteryManager.Instance.model.buyGoodsIDArray);
         _buyNumTxt.text = CloudBuyLotteryManager.Instance.model.currentNum.toString();
         _chanceTxt.text = CloudBuyLotteryManager.Instance.model.luckCount + "/" + CloudBuyLotteryManager.Instance.model.maxNum;
         _luckNumTxt.text = CloudBuyLotteryManager.Instance.model.luckCount.toString();
         _numberKTxt.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
         var num:int = CloudBuyLotteryManager.Instance.model.maxNum - CloudBuyLotteryManager.Instance.model.currentNum;
         CloudBuyLotteryManager.Instance.expBar.initBar(num,CloudBuyLotteryManager.Instance.model.maxNum);
      }
      
      private function __frmeUpdateInfo(e:Event) : void
      {
         _numberKTxt.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
      }
      
      private function __onLogClick(evt:MouseEvent) : void
      {
         var totalWidth:int = 0;
         if(!logFrameFlag)
         {
            winningLogFrame = ComponentFactory.Instance.creatComponentByStylename("winningLogFrame.frame");
            winningLogFrame.addEventListener("response",__onclose);
            addChildAt(winningLogFrame,0);
            totalWidth = _infoWidth + winningLogFrame.width;
            TweenLite.to(this,0.8,{"x":(StageReferance.stage.stageWidth - totalWidth) / 2});
            TweenLite.to(winningLogFrame,0.8,{"x":_infoWidth});
            logFrameFlag = true;
         }
         else
         {
            hideFrame();
         }
      }
      
      public function hideFrame() : void
      {
         if(winningLogFrame)
         {
            TweenLite.to(this,0.8,{"x":(StageReferance.stage.stageWidth - _infoWidth) / 2});
            TweenLite.to(winningLogFrame,0.8,{
               "x":winningLogFrame.width,
               "onComplete":releaseRight,
               "onCompleteParams":[winningLogFrame]
            });
            winningLogFrame = null;
         }
      }
      
      private function releaseRight(frame:Frame) : void
      {
         logFrameFlag = false;
         if(frame)
         {
            frame.removeEventListener("response",__onclose);
         }
         ObjectUtils.disposeObject(frame);
      }
      
      protected function __onclose(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               hideFrame();
            default:
               hideFrame();
            default:
            case 4:
               hideFrame();
         }
      }
      
      private function __onBuyClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!CloudBuyLotteryManager.Instance.model.isGame)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("cloudBuyLottery.isGameOver"));
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < CloudBuyLotteryManager.Instance.model.buyMoney)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         _tipsframe = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("CloudBuyLotteryFrame.buy.tips"),"","",LanguageMgr.GetTranslation("cancel"),true,true,false,2,null,"SimpleAlert2");
         _tipsframe.width = 360;
         _tipsframe.height = 200;
         _text = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.tipsframeText");
         _text.text = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.autoOpenCount.text");
         PositionUtils.setPos(_text,"CloudBuyLotteryFrame.autoOpenCount.textPos");
         _inputBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.openBatchView.inputBg");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.inputTxt");
         _inputText.text = "1";
         PositionUtils.setPos(_inputBg,"CloudBuyLotteryFrame.autoOpenCount.textPos1");
         PositionUtils.setPos(_inputText,"CloudBuyLotteryFrame.autoOpenCount.textPos2");
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("cloudbuy.openBatchView.maxBtn");
         PositionUtils.setPos(_maxBtn,"CloudBuyLotteryFrame.autoOpenCount.textPos3");
         _moneyNumText = ComponentFactory.Instance.creatComponentByStylename("CloudBuyLotteryFrame.moneyNumText");
         _tipsframe.addToContent(_text);
         _tipsframe.addToContent(_inputBg);
         _tipsframe.addToContent(_inputText);
         _tipsframe.addToContent(_maxBtn);
         _tipsframe.addToContent(_moneyNumText);
         _tipsframe.addEventListener("response",__onResponse);
         _maxBtn.addEventListener("click",changeMaxHandler,false,0,true);
         _inputText.addEventListener("change",inputTextChangeHandler,false,0,true);
         showMoneyNum();
      }
      
      private function changeMaxHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _inputText.text = _buyNumTxt.text;
         showMoneyNum();
      }
      
      private function inputTextChangeHandler(event:Event) : void
      {
         var maxNum:int = _buyNumTxt.text;
         var num:int = _inputText.text;
         if(num > maxNum)
         {
            _inputText.text = maxNum.toString();
         }
         else if(num < 1)
         {
            _inputText.text = "1";
         }
         showMoneyNum();
      }
      
      private function showMoneyNum() : void
      {
         var money:int = int(_inputText.text) * CloudBuyLotteryManager.Instance.model.buyMoney;
         _moneyNumText.htmlText = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.moneyNumText.LG",money);
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var currentValue:int = _inputText.text;
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            SocketManager.Instance.out.sendYGBuyGoods(currentValue);
         }
         if(_tipsframe)
         {
            _tipsframe.removeEventListener("response",__onResponse);
            ObjectUtils.disposeAllChildren(_tipsframe);
            ObjectUtils.disposeObject(_tipsframe);
            _tipsframe = null;
         }
      }
      
      private function __onJuBaoClick(evt:MouseEvent) : void
      {
         if(luckLooteryFrame != null)
         {
            ObjectUtils.disposeObject(luckLooteryFrame);
            luckLooteryFrame = null;
         }
         if(luckLooteryFrame == null)
         {
            luckLooteryFrame = ComponentFactory.Instance.creatComponentByStylename("individualLottery.frame");
            LayerManager.Instance.addToLayer(luckLooteryFrame,3,true,1);
         }
      }
      
      private function luckGoodsCell(id:int) : void
      {
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(id) as ItemTemplateInfo;
         var tInfo:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,itemInfo);
         tInfo.ValidDate = CloudBuyLotteryManager.Instance.model.validDate;
         tInfo.StrengthenLevel = CloudBuyLotteryManager.Instance.model.property[0];
         tInfo.AttackCompose = CloudBuyLotteryManager.Instance.model.property[1];
         tInfo.DefendCompose = CloudBuyLotteryManager.Instance.model.property[2];
         tInfo.LuckCompose = CloudBuyLotteryManager.Instance.model.property[3];
         tInfo.AgilityCompose = CloudBuyLotteryManager.Instance.model.property[4];
         tInfo.IsBinds = true;
         if(_cell != null)
         {
            ObjectUtils.disposeObject(_cell);
            _cell = null;
         }
         _cell = new BagCell(0,tInfo);
         PositionUtils.setPos(_cell,"CloudBuyLotteryFrame.cellPos");
         _cell.setContentSize(78,78);
         _cell.setCount(CloudBuyLotteryManager.Instance.model.templatedIdCount);
         _cell.setBgVisible(false);
         addToContent(_cell);
      }
      
      private function buyGoodsCell(id:Array) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var tInfo:* = null;
         var count:int = 0;
         var goodsName:String = "";
         for(i = 0; i < id.length; )
         {
            itemInfo = ItemManager.Instance.getTemplateById(id[i]) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            count = CloudBuyLotteryManager.Instance.model.buyGoodsCountArray[i];
            goodsName = goodsName + LanguageMgr.GetTranslation("cloudBuyLotteryFrame.buyGoodsTip",tInfo.Name,count);
            i++;
         }
         _buyGoodsSprite = ComponentFactory.Instance.creatComponentByStylename("cloudBuyLotteryFrame.tipData");
         _buyGoodsSprite.tipData = goodsName.substring(0,goodsName.length - 1);
         _buyGoodsSprite.buttonMode = true;
         var _goodsImg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.goods");
         _buyGoodsSprite.addChild(_goodsImg);
         addToContent(_buyGoodsSprite);
      }
      
      private function __updateTimes(evt:TimerEvent) : void
      {
         timesNum();
      }
      
      private function timesNum() : void
      {
         var hoursTen:int = 0;
         var hoursBit:int = 0;
         var minutesTen:int = 0;
         var minutesBit:int = 0;
         var secondsTen:int = 0;
         var secondsBit:int = 0;
         if(CloudBuyLotteryManager.Instance.model.isGame)
         {
            timeArray = CloudBuyLotteryManager.Instance.refreshTimePlayTxt().split(":");
            hoursTen = CloudBuyLotteryManager.Instance.returnTen(timeArray[0]);
            hoursBit = CloudBuyLotteryManager.Instance.returnABit(timeArray[0]);
            minutesTen = CloudBuyLotteryManager.Instance.returnTen(timeArray[1]);
            minutesBit = CloudBuyLotteryManager.Instance.returnABit(timeArray[1]);
            secondsTen = CloudBuyLotteryManager.Instance.returnTen(timeArray[2]);
            secondsBit = CloudBuyLotteryManager.Instance.returnABit(timeArray[2]);
            showTimes.hourTen.gotoAndStop(hoursTen);
            showTimes.hourBit.gotoAndStop(hoursBit);
            showTimes.minutesTen.gotoAndStop(minutesTen);
            showTimes.minutesBit.gotoAndStop(minutesBit);
            showTimes.secondsTen.gotoAndStop(secondsTen);
            showTimes.secondsBit.gotoAndStop(secondsBit);
         }
         else
         {
            _luckNumTxt.text = "0";
            _chanceTxt.text = "0/0";
            showTimes.hourTen.gotoAndStop(0);
            showTimes.hourBit.gotoAndStop(0);
            showTimes.minutesTen.gotoAndStop(0);
            showTimes.minutesBit.gotoAndStop(0);
            showTimes.secondsTen.gotoAndStop(0);
            showTimes.secondsBit.gotoAndStop(0);
            if(_timer != null)
            {
               _timer.stop();
            }
         }
      }
      
      protected function __onHelpClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(helpPage,1,true,1);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      public function get expBar() : ExpBar
      {
         return _expBar;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateTimes);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(_expBar)
         {
            ObjectUtils.disposeObject(_expBar);
         }
         _expBar = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(luckLooteryFrame)
         {
            ObjectUtils.disposeObject(luckLooteryFrame);
         }
         luckLooteryFrame = null;
         if(winningLogFrame)
         {
            ObjectUtils.disposeObject(winningLogFrame);
         }
         winningLogFrame = null;
         _bg = null;
         showTimes = null;
      }
   }
}
