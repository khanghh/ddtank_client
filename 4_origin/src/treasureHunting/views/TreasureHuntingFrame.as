package treasureHunting.views
{
   import bagAndInfo.cell.BaseCell;
   import baglocked.BaglockedManager;
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.TweenProxy;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.caddyII.CaddyEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import treasureHunting.TreasureControl;
   import treasureHunting.TreasureManager;
   import treasureHunting.event.TreasureEvent;
   import treasureHunting.items.TreasureItem;
   
   public class TreasureHuntingFrame extends Frame
   {
      
      private static const RESTRICT:String = "0-9";
      
      private static const DEFAULT:String = "1";
      
      private static const LENGTH:int = 16;
      
      private static const NUMBER:int = 4;
       
      
      private var _content:Sprite;
      
      private var _bg:ScaleBitmapImage;
      
      private var _treasureTitle:ScaleBitmapImage;
      
      private var _itemList:SimpleTileList;
      
      private var _itemArr:Vector.<TreasureItem>;
      
      private var _timesTxt:FilterFrameText;
      
      private var _timesInput:FilterFrameText;
      
      private var _timesInputBg:Scale9CornerImage;
      
      private var _showPrizeBtn:BaseButton;
      
      private var _rankPrizeBtn:SimpleBitmapButton;
      
      private var _huntingBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _glint:MovieClip;
      
      private var _myNumberTxt:FilterFrameText;
      
      private var _bagBtn:SimpleBitmapButton;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _recordBtn:SimpleBitmapButton;
      
      private var _exchangeBtn:TextButton;
      
      private var _luckyStoneBG:Bitmap;
      
      private var _pointTxt:FilterFrameText;
      
      private var _bagView:TreasureBagView;
      
      private var _rankView:TreasureRankView;
      
      private var _recordView:TreasureRecordView;
      
      private var _glintTimer:Timer;
      
      private var _rankTimer:Timer;
      
      private var _ran:int;
      
      private var _unitPrice:int;
      
      private var totalScore:int = 0;
      
      private var _btnHelp:BaseButton;
      
      private var moveCell:BaseCell;
      
      private var luckStoneCell:BaseCell;
      
      public function TreasureHuntingFrame()
      {
         super();
         escEnable = true;
         initView();
         initEvent();
         initData();
      }
      
      private function initData() : void
      {
         SocketManager.Instance.out.sendQequestBadLuck();
         SocketManager.Instance.out.sendConvertScore(false);
         TreasureControl.instance.setFrame(this);
         _glintTimer = new Timer(300,10);
         _glintTimer.addEventListener("timer",onTimer);
         _glintTimer.addEventListener("timerComplete",onTimerComplete);
         _rankTimer = new Timer(300000);
         _rankTimer.addEventListener("timer",updateRank);
         _unitPrice = TreasureManager.instance.needMoney;
      }
      
      protected function updateRank(event:TimerEvent) : void
      {
         SocketManager.Instance.out.sendQequestBadLuck();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _content = new Sprite();
         PositionUtils.setPos(_content,"treasureHunting.Treasure.ContentPos2");
         _bg = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.BG");
         _content.addChild(_bg);
         _treasureTitle = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.Titile");
         _content.addChild(_treasureTitle);
         _itemList = ComponentFactory.Instance.creatCustomObject("treasureHunting.Treasure.SimpleTileList",[4]);
         _itemArr = new Vector.<TreasureItem>();
         for(i = 1; i <= 16; )
         {
            item = new TreasureItem();
            item.initView(i);
            _itemList.addChild(item);
            _itemArr.push(item);
            i++;
         }
         _content.addChild(_itemList);
         _itemArr[0].selectedLight.visible = true;
         _timesTxt = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.TimesTxt");
         _timesTxt.text = LanguageMgr.GetTranslation("treasureHunting.timesText");
         _content.addChild(_timesTxt);
         _timesInputBg = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.inputTimesTxtBg");
         _content.addChild(_timesInputBg);
         _timesInput = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.inputTimesTxt");
         _content.addChild(_timesInput);
         _timesInput.maxChars = 2;
         _timesInput.text = "1";
         _timesInput.restrict = "0-9";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.MaxBtn");
         _content.addChild(_maxBtn);
         _huntingBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.HuntBtn");
         _content.addChild(_huntingBtn);
         _showPrizeBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.AwardBtn");
         _content.addChild(_showPrizeBtn);
         _rankPrizeBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.rankPrizeBtn");
         _content.addChild(_rankPrizeBtn);
         _bagView = new TreasureBagView();
         PositionUtils.setPos(_bagView,"treasureHunting.rightViewPos");
         _content.addChild(_bagView);
         _rankView = new TreasureRankView();
         PositionUtils.setPos(_rankView,"treasureHunting.rightViewPos");
         _content.addChild(_rankView);
         _rankView.visible = false;
         _recordView = new TreasureRecordView();
         PositionUtils.setPos(_recordView,"treasureHunting.rightViewPos");
         _content.addChild(_recordView);
         _recordView.visible = false;
         _luckyStoneBG = ComponentFactory.Instance.creat("treasureHunting.luckyStoneBG");
         _content.addChild(_luckyStoneBG);
         _bagBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.bagBtn");
         _content.addChild(_bagBtn);
         _bagBtn.visible = false;
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.rankBtn");
         _content.addChild(_rankBtn);
         _recordBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.recordBtn");
         _content.addChild(_recordBtn);
         _myNumberTxt = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.stoneNumberTxt");
         _content.addChild(_myNumberTxt);
         _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.pointTxt");
         _content.addChild(_pointTxt);
         _pointTxt.text = "36898";
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.exchangeBtn");
         _exchangeBtn.text = LanguageMgr.GetTranslation("ddt.bagandinfo.buffBuf");
         _content.addChild(_exchangeBtn);
         addToContent(_content);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":662,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.treasureHunting.view.help",408,488);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         _showPrizeBtn.addEventListener("click",onShowPrizeBtnClick);
         _rankPrizeBtn.addEventListener("click",onRankPrizeBtnClick);
         _timesInput.addEventListener("change",_change);
         _huntingBtn.addEventListener("click",onHuntingBtnClick);
         _maxBtn.addEventListener("click",onMaxBtnClick);
         _bagBtn.addEventListener("click",onBagBtnClick);
         _rankBtn.addEventListener("click",onRankBtnClick);
         _recordBtn.addEventListener("click",onRecordBtnClick);
         _exchangeBtn.addEventListener("click",onExchangeBtnClick);
         RouletteManager.instance.addEventListener("update_badLuck",__updateLastTime);
         SocketManager.Instance.addEventListener(PkgEvent.format(38),__updateInfo);
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeBadLuckNumber);
         SocketManager.Instance.addEventListener(PkgEvent.format(110,6),__getConverteds);
         SocketManager.Instance.addEventListener(PkgEvent.format(110,5),__getRemainScore);
      }
      
      private function __getConverteds(event:PkgEvent) : void
      {
         var alert:* = null;
         var pkg:PackageIn = event.pkg;
         var isConvert:Boolean = pkg.readBoolean();
         var convertSorce:int = pkg.readInt();
         totalScore = pkg.readInt();
         _pointTxt.text = totalScore.toString();
         if(convertSorce != 0 && !isConvert && TreasureControl.instance.isAlert)
         {
            TreasureControl.instance.isAlert = false;
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.convertedAll",convertSorce),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.mouseEnabled = false;
            alert.addEventListener("response",_responseII);
         }
      }
      
      private function _responseII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendConvertScore(true);
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      protected function onExchangeBtnClick(event:MouseEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(totalScore < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.notEnough"));
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("treasureHunting.exchangeAll",Math.floor(totalScore / 30)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.mouseEnabled = false;
            alert.addEventListener("response",_responseIII);
         }
      }
      
      private function _responseIII(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseIII);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.sendHuntingByScore();
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __getRemainScore(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         totalScore = pkg.readInt();
         _pointTxt.text = totalScore.toString();
      }
      
      protected function onRankBtnClick(event:MouseEvent) : void
      {
         _bagBtn.visible = true;
         _rankBtn.visible = false;
         _recordBtn.visible = true;
         _rankView.visible = true;
         _bagView.visible = false;
         _recordView.visible = false;
      }
      
      protected function onBagBtnClick(event:MouseEvent) : void
      {
         _bagBtn.visible = false;
         _rankBtn.visible = true;
         _rankBtn.x = 588;
         _recordBtn.visible = true;
         _rankView.visible = false;
         _bagView.visible = true;
         _recordView.visible = false;
      }
      
      protected function onRecordBtnClick(event:MouseEvent) : void
      {
         _bagBtn.visible = true;
         _rankBtn.visible = true;
         _rankBtn.x = 571;
         _recordBtn.visible = false;
         _rankView.visible = false;
         _bagView.visible = false;
         _recordView.visible = true;
         SocketManager.Instance.out.sendRequestAwards(15);
      }
      
      private function onShowPrizeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TreasureControl.instance.openShowPrize();
      }
      
      private function onRankPrizeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TreasureControl.instance.openRankPrize();
      }
      
      private function _change(event:Event) : void
      {
         var current:int = _timesInput.text;
         var num:String = _timesInput.text.toString();
         var bagSize:int = 24;
         if(current > bagSize)
         {
            _timesInput.text = bagSize.toString();
         }
         if(num == "0" || num == "")
         {
            _timesInput.text = "1";
         }
      }
      
      private function onHuntingBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_timesInput.text == "" || _timesInput.text == "0")
         {
            return;
         }
         if(TreasureManager.instance.needShowLimted && SharedManager.Instance.isTreasureBind)
         {
            showTransactionFrame();
         }
         else if(SharedManager.Instance.isRemindTreasureBind)
         {
            showTransactionFrame();
         }
         else
         {
            payForHunting(SharedManager.Instance.isTreasureBind);
         }
      }
      
      private function showTransactionFrame() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var count:int = parseInt(_timesInput.text);
         var str:String = LanguageMgr.GetTranslation("treasureHunting.alert.title",_unitPrice * count,count,count);
         var singleAlsert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),str,"",LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         singleAlsert.moveEnable = false;
         singleAlsert.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
         singleAlsert.addEventListener("response",__onResponse);
         singleAlsert.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
      }
      
      protected function __onSelectCheckClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         var singleAlsert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            SharedManager.Instance.isRemindTreasureBind = !singleAlsert.selectedCheckButton.selected;
            payForHunting(false);
         }
         singleAlsert.removeEventListener("response",__onResponse);
         singleAlsert.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         singleAlsert.dispose();
         singleAlsert = null;
      }
      
      private function onMaxBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var max:int = 24 - PlayerManager.Instance.Self.CaddyBag.items.length;
         if(PlayerManager.Instance.Self.Money < max * _unitPrice)
         {
            max = Math.floor(PlayerManager.Instance.Self.Money / _unitPrice) as int;
         }
         if(max == 0)
         {
            max = 1;
         }
         _timesInput.text = String(max);
      }
      
      private function payForHunting(isBind:Boolean) : void
      {
         SharedManager.Instance.isTreasureBind = isBind;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var count:int = parseInt(_timesInput.text);
         if(!isBind && PlayerManager.Instance.Self.Money < _unitPrice * count)
         {
            LeavePageManager.showFillFrame();
            SharedManager.Instance.isRemindTreasureBind = true;
            return;
         }
         if(count == 1)
         {
            _huntingBtn.enable = false;
            TreasureControl.instance.isMovieComplete = false;
            TreasureControl.instance.addMask();
         }
         SocketManager.Instance.out.sendPayForHunting(isBind,count);
      }
      
      private function onTimer(event:TimerEvent) : void
      {
         var tmp:int = 0;
         removeAllItemLight();
         do
         {
            tmp = Math.floor(Math.random() * 16) as int;
         }
         while(tmp == _ran);
         
         _ran = tmp;
         _itemArr[_ran].selectedLight.visible = true;
         SoundManager.instance.play("203");
      }
      
      private function removeAllItemLight() : void
      {
         var i:int = 0;
         if(_itemArr == null)
         {
            return;
         }
         i = 0;
         while(i <= _itemArr.length - 1)
         {
            _itemArr[i].selectedLight.visible = false;
            i++;
         }
      }
      
      private function onTimerComplete(event:TimerEvent) : void
      {
         var indexArr:Array = TreasureControl.instance.lightIndexArr;
         removeAllItemLight();
         _glint = ComponentFactory.Instance.creat("treasureHunting.GlintAsset");
         _glint.addEventListener("enterFrame",onEnterFrame);
         var index:int = indexArr[0];
         _glint.scaleX = 1.3;
         _glint.scaleY = 1.3;
         _glint.x = _itemList.x + _itemArr[index].x + 10;
         _glint.y = _itemList.y + _itemArr[index].y + 10;
         _content.addChild(_glint);
      }
      
      public function creatMoveCell(templateID:int) : void
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,75,75);
         shape.graphics.endFill();
         var item:InventoryItemInfo = new InventoryItemInfo();
         item.TemplateID = templateID;
         item = ItemManager.fill(item);
         if(templateID == 11550)
         {
            luckStoneCell = new BaseCell(shape);
            luckStoneCell.info = item;
         }
         else
         {
            moveCell = new BaseCell(shape);
            moveCell.info = item;
         }
      }
      
      private function onEnterFrame(event:Event) : void
      {
         var indexArr:* = null;
         var index:int = 0;
         if(_glint.currentFrame == _glint.totalFrames)
         {
            _glint.stop();
            _glint.removeEventListener("enterFrame",onEnterFrame);
            _content.removeChild(_glint);
            _glint = null;
            indexArr = TreasureControl.instance.lightIndexArr;
            index = indexArr[0];
            _itemArr[index].selectedLight.visible = true;
            SoundManager.instance.play("204");
            _itemArr[index].addChild(moveCell);
            moveCell.visible = false;
            addMoveEffect(moveCell,582,67);
            if(luckStoneCell)
            {
               _itemArr[index].addChild(luckStoneCell);
               luckStoneCell.visible = false;
               addMoveEffect(luckStoneCell,625,488);
               luckStoneCell = null;
            }
            _huntingBtn.enable = true;
         }
      }
      
      private function addMoveEffect($item:DisplayObject, targetX:int, targetY:int) : void
      {
         var tp:* = null;
         var timeline:* = null;
         var tw:* = null;
         var tw1:* = null;
         if(!$item)
         {
            return;
         }
         var tempBitmapD:BitmapData = new BitmapData($item.width,$item.height,true,0);
         tempBitmapD.draw($item);
         var bitmap:Bitmap = new Bitmap(tempBitmapD,"auto",true);
         addChild(bitmap);
         tp = TweenProxy.create(bitmap);
         tp.registrationX = tp.width / 2;
         tp.registrationY = tp.height / 2;
         var pos:Point = DisplayUtils.localizePoint(this,$item);
         tp.x = pos.x + tp.width / 2;
         tp.y = pos.y + tp.height / 2;
         timeline = new TimelineLite();
         timeline.vars.onComplete = twComplete;
         timeline.vars.onCompleteParams = [timeline,tp,bitmap];
         tw = new TweenLite(tp,0.4,{
            "x":targetX,
            "y":targetY
         });
         tw1 = new TweenLite(tp,0.4,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         timeline.append(tw);
         timeline.append(tw1,-0.2);
      }
      
      private function twComplete(timeline:TimelineLite, tp:TweenProxy, bitmap:Bitmap) : void
      {
         if(timeline)
         {
            timeline.kill();
         }
         if(tp)
         {
            tp.destroy();
         }
         if(bitmap.parent)
         {
            bitmap.parent.removeChild(bitmap);
            bitmap.bitmapData.dispose();
         }
         tp = null;
         bitmap = null;
         timeline = null;
         movieComplete();
      }
      
      private function movieComplete() : void
      {
         if(TreasureControl.instance.msgStr != "")
         {
            MessageTipManager.getInstance().show(TreasureControl.instance.countMsg);
            ChatManager.Instance.sysChatYellow(TreasureControl.instance.msgStr);
            TreasureControl.instance.countMsg = "";
            TreasureControl.instance.msgStr = "";
         }
         TreasureControl.instance.isMovieComplete = true;
         TreasureControl.instance.removeMask();
         TreasureControl.instance.dispatchEvent(new TreasureEvent("movieComplete"));
      }
      
      public function startTimer() : void
      {
         _glintTimer.reset();
         _glintTimer.start();
      }
      
      public function lightUpItemArr() : void
      {
         var i:int = 0;
         var index2:int = 0;
         var indexArr:Array = TreasureControl.instance.lightIndexArr;
         removeAllItemLight();
         for(i = 0; i <= indexArr.length - 1; )
         {
            index2 = indexArr[i];
            _itemArr[index2].selectedLight.visible = true;
            i++;
         }
         MessageTipManager.getInstance().show(TreasureControl.instance.countMsg);
         ChatManager.Instance.sysChatYellow(TreasureControl.instance.msgStr);
         TreasureControl.instance.countMsg = "";
         TreasureControl.instance.msgStr = "";
      }
      
      protected function _response(event:FrameEvent) : void
      {
         var alert:* = null;
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(TreasureControl.instance.checkBag())
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("treasureHunting.alert.ensureGetAll"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alert.mouseEnabled = false;
               alert.addEventListener("response",onAlertResponse);
            }
            else
            {
               dispose();
            }
         }
      }
      
      private function onAlertResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",onAlertResponse);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            SocketManager.Instance.out.getAllTreasure();
            dispose();
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __updateLastTime(event:CaddyEvent) : void
      {
      }
      
      private function __changeBadLuckNumber(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["BadLuckNumber"])
         {
            if(PlayerManager.Instance.Self.badLuckNumber == 0)
            {
               _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
            }
         }
      }
      
      protected function __updateInfo(event:PkgEvent) : void
      {
         _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
      }
      
      private function removeEvents() : void
      {
         if(_showPrizeBtn)
         {
            _showPrizeBtn.removeEventListener("click",onShowPrizeBtnClick);
         }
         if(_timesInput)
         {
            _timesInput.removeEventListener("change",_change);
         }
         if(_huntingBtn)
         {
            _huntingBtn.removeEventListener("click",onHuntingBtnClick);
         }
         if(_maxBtn)
         {
            _maxBtn.removeEventListener("click",onMaxBtnClick);
         }
         if(_bagBtn)
         {
            _bagBtn.removeEventListener("click",onBagBtnClick);
         }
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",onRankBtnClick);
         }
         if(_recordBtn)
         {
            _recordBtn.addEventListener("click",onRecordBtnClick);
         }
         if(_exchangeBtn)
         {
            _exchangeBtn.removeEventListener("click",onExchangeBtnClick);
         }
         RouletteManager.instance.removeEventListener("update_badLuck",__updateLastTime);
         SocketManager.Instance.removeEventListener(PkgEvent.format(38),__updateInfo);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeBadLuckNumber);
         SocketManager.Instance.removeEventListener(PkgEvent.format(110,6),__getConverteds);
         SocketManager.Instance.removeEventListener(PkgEvent.format(110,5),__getRemainScore);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         TreasureControl.instance.dispose();
         if(_glintTimer)
         {
            _glintTimer.removeEventListener("timer",onTimer);
            _glintTimer.removeEventListener("timerComplete",onTimerComplete);
            _glintTimer = null;
         }
         if(_rankTimer)
         {
            _rankTimer.removeEventListener("timer",updateRank);
            _rankTimer = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_treasureTitle)
         {
            ObjectUtils.disposeObject(_treasureTitle);
         }
         _treasureTitle = null;
         if(_timesTxt)
         {
            ObjectUtils.disposeObject(_timesTxt);
         }
         _timesTxt = null;
         if(_timesInput)
         {
            ObjectUtils.disposeObject(_timesInput);
         }
         _timesInput = null;
         if(_timesInputBg)
         {
            ObjectUtils.disposeObject(_timesInputBg);
         }
         _timesInputBg = null;
         if(_itemList)
         {
            ObjectUtils.disposeObject(_itemList);
         }
         _itemList = null;
         if(_showPrizeBtn)
         {
            ObjectUtils.disposeObject(_showPrizeBtn);
         }
         _showPrizeBtn = null;
         if(_huntingBtn)
         {
            ObjectUtils.disposeObject(_huntingBtn);
         }
         _huntingBtn = null;
         if(_maxBtn)
         {
            ObjectUtils.disposeObject(_maxBtn);
         }
         _maxBtn = null;
         if(_rankPrizeBtn)
         {
            ObjectUtils.disposeObject(_rankPrizeBtn);
         }
         _rankPrizeBtn = null;
         if(_bagBtn)
         {
            ObjectUtils.disposeObject(_bagBtn);
         }
         _bagBtn = null;
         if(_rankBtn)
         {
            ObjectUtils.disposeObject(_rankBtn);
         }
         _rankBtn = null;
         if(_recordBtn)
         {
            ObjectUtils.disposeObject(_recordBtn);
         }
         _recordBtn = null;
         if(_luckyStoneBG)
         {
            ObjectUtils.disposeObject(_luckyStoneBG);
         }
         _luckyStoneBG = null;
         if(_bagView)
         {
            ObjectUtils.disposeObject(_bagView);
         }
         _bagView = null;
         if(_rankView)
         {
            ObjectUtils.disposeObject(_rankView);
         }
         _rankView = null;
         if(_recordView)
         {
            ObjectUtils.disposeObject(_recordView);
         }
         _recordView = null;
         if(_myNumberTxt)
         {
            ObjectUtils.disposeObject(_myNumberTxt);
         }
         _myNumberTxt = null;
         if(moveCell)
         {
            ObjectUtils.disposeObject(moveCell);
         }
         moveCell = null;
         if(luckStoneCell)
         {
            ObjectUtils.disposeObject(luckStoneCell);
         }
         luckStoneCell = null;
         if(_exchangeBtn)
         {
            ObjectUtils.disposeObject(_exchangeBtn);
         }
         _exchangeBtn = null;
         if(_pointTxt)
         {
            ObjectUtils.disposeObject(_pointTxt);
         }
         _pointTxt = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         _itemArr = null;
         super.dispose();
      }
      
      public function get huntingBtn() : BaseButton
      {
         return _huntingBtn;
      }
      
      public function get bagView() : TreasureBagView
      {
         return _bagView;
      }
   }
}
