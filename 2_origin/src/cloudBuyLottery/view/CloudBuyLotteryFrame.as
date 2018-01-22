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
      
      override public function set width(param1:Number) : void
      {
         .super.width = param1;
         _infoWidth = param1;
      }
      
      private function __updateInfo(param1:Event) : void
      {
         timesNum();
         luckGoodsCell(CloudBuyLotteryManager.Instance.model.templateId);
         buyGoodsCell(CloudBuyLotteryManager.Instance.model.buyGoodsIDArray);
         _buyNumTxt.text = CloudBuyLotteryManager.Instance.model.currentNum.toString();
         _chanceTxt.text = CloudBuyLotteryManager.Instance.model.luckCount + "/" + CloudBuyLotteryManager.Instance.model.maxNum;
         _luckNumTxt.text = CloudBuyLotteryManager.Instance.model.luckCount.toString();
         _numberKTxt.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
         var _loc2_:int = CloudBuyLotteryManager.Instance.model.maxNum - CloudBuyLotteryManager.Instance.model.currentNum;
         CloudBuyLotteryManager.Instance.expBar.initBar(_loc2_,CloudBuyLotteryManager.Instance.model.maxNum);
      }
      
      private function __frmeUpdateInfo(param1:Event) : void
      {
         _numberKTxt.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
      }
      
      private function __onLogClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!logFrameFlag)
         {
            winningLogFrame = ComponentFactory.Instance.creatComponentByStylename("winningLogFrame.frame");
            winningLogFrame.addEventListener("response",__onclose);
            addChildAt(winningLogFrame,0);
            _loc2_ = _infoWidth + winningLogFrame.width;
            TweenLite.to(this,0.8,{"x":(StageReferance.stage.stageWidth - _loc2_) / 2});
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
      
      private function releaseRight(param1:Frame) : void
      {
         logFrameFlag = false;
         if(param1)
         {
            param1.removeEventListener("response",__onclose);
         }
         ObjectUtils.disposeObject(param1);
      }
      
      protected function __onclose(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
      
      private function __onBuyClick(param1:MouseEvent) : void
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
      
      private function changeMaxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _inputText.text = _buyNumTxt.text;
         showMoneyNum();
      }
      
      private function inputTextChangeHandler(param1:Event) : void
      {
         var _loc3_:int = _buyNumTxt.text;
         var _loc2_:int = _inputText.text;
         if(_loc2_ > _loc3_)
         {
            _inputText.text = _loc3_.toString();
         }
         else if(_loc2_ < 1)
         {
            _inputText.text = "1";
         }
         showMoneyNum();
      }
      
      private function showMoneyNum() : void
      {
         var _loc1_:int = int(_inputText.text) * CloudBuyLotteryManager.Instance.model.buyMoney;
         _moneyNumText.htmlText = LanguageMgr.GetTranslation("CloudBuyLotteryFrame.moneyNumText.LG",_loc1_);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = _inputText.text;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendYGBuyGoods(_loc2_);
         }
         if(_tipsframe)
         {
            _tipsframe.removeEventListener("response",__onResponse);
            ObjectUtils.disposeAllChildren(_tipsframe);
            ObjectUtils.disposeObject(_tipsframe);
            _tipsframe = null;
         }
      }
      
      private function __onJuBaoClick(param1:MouseEvent) : void
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
      
      private function luckGoodsCell(param1:int) : void
      {
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1) as ItemTemplateInfo;
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc2_.ValidDate = CloudBuyLotteryManager.Instance.model.validDate;
         _loc2_.StrengthenLevel = CloudBuyLotteryManager.Instance.model.property[0];
         _loc2_.AttackCompose = CloudBuyLotteryManager.Instance.model.property[1];
         _loc2_.DefendCompose = CloudBuyLotteryManager.Instance.model.property[2];
         _loc2_.LuckCompose = CloudBuyLotteryManager.Instance.model.property[3];
         _loc2_.AgilityCompose = CloudBuyLotteryManager.Instance.model.property[4];
         _loc2_.IsBinds = true;
         if(_cell != null)
         {
            ObjectUtils.disposeObject(_cell);
            _cell = null;
         }
         _cell = new BagCell(0,_loc2_);
         PositionUtils.setPos(_cell,"CloudBuyLotteryFrame.cellPos");
         _cell.setContentSize(78,78);
         _cell.setCount(CloudBuyLotteryManager.Instance.model.templatedIdCount);
         _cell.setBgVisible(false);
         addToContent(_cell);
      }
      
      private function buyGoodsCell(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc6_:String = "";
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc5_ = ItemManager.Instance.getTemplateById(param1[_loc7_]) as ItemTemplateInfo;
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc5_);
            _loc2_ = CloudBuyLotteryManager.Instance.model.buyGoodsCountArray[_loc7_];
            _loc6_ = _loc6_ + LanguageMgr.GetTranslation("cloudBuyLotteryFrame.buyGoodsTip",_loc3_.Name,_loc2_);
            _loc7_++;
         }
         _buyGoodsSprite = ComponentFactory.Instance.creatComponentByStylename("cloudBuyLotteryFrame.tipData");
         _buyGoodsSprite.tipData = _loc6_.substring(0,_loc6_.length - 1);
         _buyGoodsSprite.buttonMode = true;
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.goods");
         _buyGoodsSprite.addChild(_loc4_);
         addToContent(_buyGoodsSprite);
      }
      
      private function __updateTimes(param1:TimerEvent) : void
      {
         timesNum();
      }
      
      private function timesNum() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         if(CloudBuyLotteryManager.Instance.model.isGame)
         {
            timeArray = CloudBuyLotteryManager.Instance.refreshTimePlayTxt().split(":");
            _loc3_ = CloudBuyLotteryManager.Instance.returnTen(timeArray[0]);
            _loc5_ = CloudBuyLotteryManager.Instance.returnABit(timeArray[0]);
            _loc4_ = CloudBuyLotteryManager.Instance.returnTen(timeArray[1]);
            _loc1_ = CloudBuyLotteryManager.Instance.returnABit(timeArray[1]);
            _loc6_ = CloudBuyLotteryManager.Instance.returnTen(timeArray[2]);
            _loc2_ = CloudBuyLotteryManager.Instance.returnABit(timeArray[2]);
            showTimes.hourTen.gotoAndStop(_loc3_);
            showTimes.hourBit.gotoAndStop(_loc5_);
            showTimes.minutesTen.gotoAndStop(_loc4_);
            showTimes.minutesBit.gotoAndStop(_loc1_);
            showTimes.secondsTen.gotoAndStop(_loc6_);
            showTimes.secondsBit.gotoAndStop(_loc2_);
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
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("CloudBuyLotteryFrame.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
