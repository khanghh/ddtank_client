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
      
      protected function updateRank(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.sendQequestBadLuck();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _content = new Sprite();
         PositionUtils.setPos(_content,"treasureHunting.Treasure.ContentPos2");
         _bg = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.BG");
         _content.addChild(_bg);
         _treasureTitle = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.Treasure.Titile");
         _content.addChild(_treasureTitle);
         _itemList = ComponentFactory.Instance.creatCustomObject("treasureHunting.Treasure.SimpleTileList",[4]);
         _itemArr = new Vector.<TreasureItem>();
         _loc2_ = 1;
         while(_loc2_ <= 16)
         {
            _loc1_ = new TreasureItem();
            _loc1_.initView(_loc2_);
            _itemList.addChild(_loc1_);
            _itemArr.push(_loc1_);
            _loc2_++;
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
      
      private function __getConverteds(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:Boolean = _loc4_.readBoolean();
         var _loc3_:int = _loc4_.readInt();
         totalScore = _loc4_.readInt();
         _pointTxt.text = totalScore.toString();
         if(_loc3_ != 0 && !_loc5_ && TreasureControl.instance.isAlert)
         {
            TreasureControl.instance.isAlert = false;
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.caddy.convertedAll",_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.mouseEnabled = false;
            _loc2_.addEventListener("response",_responseII);
         }
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseII);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendConvertScore(true);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function onExchangeBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(totalScore < 30)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.notEnough"));
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("treasureHunting.exchangeAll",Math.floor(totalScore / 30)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.mouseEnabled = false;
            _loc2_.addEventListener("response",_responseIII);
         }
      }
      
      private function _responseIII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseIII);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendHuntingByScore();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __getRemainScore(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         totalScore = _loc2_.readInt();
         _pointTxt.text = totalScore.toString();
      }
      
      protected function onRankBtnClick(param1:MouseEvent) : void
      {
         _bagBtn.visible = true;
         _rankBtn.visible = false;
         _recordBtn.visible = true;
         _rankView.visible = true;
         _bagView.visible = false;
         _recordView.visible = false;
      }
      
      protected function onBagBtnClick(param1:MouseEvent) : void
      {
         _bagBtn.visible = false;
         _rankBtn.visible = true;
         _rankBtn.x = 588;
         _recordBtn.visible = true;
         _rankView.visible = false;
         _bagView.visible = true;
         _recordView.visible = false;
      }
      
      protected function onRecordBtnClick(param1:MouseEvent) : void
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
      
      private function onShowPrizeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TreasureControl.instance.openShowPrize();
      }
      
      private function onRankPrizeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TreasureControl.instance.openRankPrize();
      }
      
      private function _change(param1:Event) : void
      {
         var _loc3_:int = _timesInput.text;
         var _loc2_:String = _timesInput.text.toString();
         var _loc4_:int = 24;
         if(_loc3_ > _loc4_)
         {
            _timesInput.text = _loc4_.toString();
         }
         if(_loc2_ == "0" || _loc2_ == "")
         {
            _timesInput.text = "1";
         }
      }
      
      private function onHuntingBtnClick(param1:MouseEvent) : void
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
         var _loc2_:int = parseInt(_timesInput.text);
         var _loc1_:String = LanguageMgr.GetTranslation("treasureHunting.alert.title",_unitPrice * _loc2_,_loc2_,_loc2_);
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc1_,"",LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc3_.moveEnable = false;
         _loc3_.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
         _loc3_.addEventListener("response",__onResponse);
         _loc3_.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
      }
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SharedManager.Instance.isRemindTreasureBind = !_loc2_.selectedCheckButton.selected;
            payForHunting(false);
         }
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function onMaxBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = 24 - PlayerManager.Instance.Self.CaddyBag.items.length;
         if(PlayerManager.Instance.Self.Money < _loc2_ * _unitPrice)
         {
            _loc2_ = Math.floor(PlayerManager.Instance.Self.Money / _unitPrice) as int;
         }
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         _timesInput.text = String(_loc2_);
      }
      
      private function payForHunting(param1:Boolean) : void
      {
         SharedManager.Instance.isTreasureBind = param1;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = parseInt(_timesInput.text);
         if(!param1 && PlayerManager.Instance.Self.Money < _unitPrice * _loc2_)
         {
            LeavePageManager.showFillFrame();
            SharedManager.Instance.isRemindTreasureBind = true;
            return;
         }
         if(_loc2_ == 1)
         {
            _huntingBtn.enable = false;
            TreasureControl.instance.isMovieComplete = false;
            TreasureControl.instance.addMask();
         }
         SocketManager.Instance.out.sendPayForHunting(param1,_loc2_);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         removeAllItemLight();
         do
         {
            _loc2_ = Math.floor(Math.random() * 16) as int;
         }
         while(_loc2_ == _ran);
         
         _ran = _loc2_;
         _itemArr[_ran].selectedLight.visible = true;
         SoundManager.instance.play("203");
      }
      
      private function removeAllItemLight() : void
      {
         var _loc1_:int = 0;
         if(_itemArr == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ <= _itemArr.length - 1)
         {
            _itemArr[_loc1_].selectedLight.visible = false;
            _loc1_++;
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         var _loc3_:Array = TreasureControl.instance.lightIndexArr;
         removeAllItemLight();
         _glint = ComponentFactory.Instance.creat("treasureHunting.GlintAsset");
         _glint.addEventListener("enterFrame",onEnterFrame);
         var _loc2_:int = _loc3_[0];
         _glint.scaleX = 1.3;
         _glint.scaleY = 1.3;
         _glint.x = _itemList.x + _itemArr[_loc2_].x + 10;
         _glint.y = _itemList.y + _itemArr[_loc2_].y + 10;
         _content.addChild(_glint);
      }
      
      public function creatMoveCell(param1:int) : void
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(0,0,75,75);
         _loc3_.graphics.endFill();
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         _loc2_ = ItemManager.fill(_loc2_);
         if(param1 == 11550)
         {
            luckStoneCell = new BaseCell(_loc3_);
            luckStoneCell.info = _loc2_;
         }
         else
         {
            moveCell = new BaseCell(_loc3_);
            moveCell.info = _loc2_;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(_glint.currentFrame == _glint.totalFrames)
         {
            _glint.stop();
            _glint.removeEventListener("enterFrame",onEnterFrame);
            _content.removeChild(_glint);
            _glint = null;
            _loc3_ = TreasureControl.instance.lightIndexArr;
            _loc2_ = _loc3_[0];
            _itemArr[_loc2_].selectedLight.visible = true;
            SoundManager.instance.play("204");
            _itemArr[_loc2_].addChild(moveCell);
            moveCell.visible = false;
            addMoveEffect(moveCell,582,67);
            if(luckStoneCell)
            {
               _itemArr[_loc2_].addChild(luckStoneCell);
               luckStoneCell.visible = false;
               addMoveEffect(luckStoneCell,625,488);
               luckStoneCell = null;
            }
            _huntingBtn.enable = true;
         }
      }
      
      private function addMoveEffect(param1:DisplayObject, param2:int, param3:int) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(!param1)
         {
            return;
         }
         var _loc9_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc9_.draw(param1);
         var _loc4_:Bitmap = new Bitmap(_loc9_,"auto",true);
         addChild(_loc4_);
         _loc7_ = TweenProxy.create(_loc4_);
         _loc7_.registrationX = _loc7_.width / 2;
         _loc7_.registrationY = _loc7_.height / 2;
         var _loc10_:Point = DisplayUtils.localizePoint(this,param1);
         _loc7_.x = _loc10_.x + _loc7_.width / 2;
         _loc7_.y = _loc10_.y + _loc7_.height / 2;
         _loc8_ = new TimelineLite();
         _loc8_.vars.onComplete = twComplete;
         _loc8_.vars.onCompleteParams = [_loc8_,_loc7_,_loc4_];
         _loc5_ = new TweenLite(_loc7_,0.4,{
            "x":param2,
            "y":param3
         });
         _loc6_ = new TweenLite(_loc7_,0.4,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         _loc8_.append(_loc5_);
         _loc8_.append(_loc6_,-0.2);
      }
      
      private function twComplete(param1:TimelineLite, param2:TweenProxy, param3:Bitmap) : void
      {
         if(param1)
         {
            param1.kill();
         }
         if(param2)
         {
            param2.destroy();
         }
         if(param3.parent)
         {
            param3.parent.removeChild(param3);
            param3.bitmapData.dispose();
         }
         param2 = null;
         param3 = null;
         param1 = null;
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
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Array = TreasureControl.instance.lightIndexArr;
         removeAllItemLight();
         _loc3_ = 0;
         while(_loc3_ <= _loc1_.length - 1)
         {
            _loc2_ = _loc1_[_loc3_];
            _itemArr[_loc2_].selectedLight.visible = true;
            _loc3_++;
         }
         MessageTipManager.getInstance().show(TreasureControl.instance.countMsg);
         ChatManager.Instance.sysChatYellow(TreasureControl.instance.msgStr);
         TreasureControl.instance.countMsg = "";
         TreasureControl.instance.msgStr = "";
      }
      
      protected function _response(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(TreasureControl.instance.checkBag())
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("treasureHunting.alert.ensureGetAll"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.mouseEnabled = false;
               _loc2_.addEventListener("response",onAlertResponse);
            }
            else
            {
               dispose();
            }
         }
      }
      
      private function onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onAlertResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.getAllTreasure();
            dispose();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __updateLastTime(param1:CaddyEvent) : void
      {
      }
      
      private function __changeBadLuckNumber(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["BadLuckNumber"])
         {
            if(PlayerManager.Instance.Self.badLuckNumber == 0)
            {
               _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
            }
         }
      }
      
      protected function __updateInfo(param1:PkgEvent) : void
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
