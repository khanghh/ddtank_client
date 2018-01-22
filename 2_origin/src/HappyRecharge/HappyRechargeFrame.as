package HappyRecharge
{
   import bagAndInfo.cell.BagCell;
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.roulette.TurnSoundControl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import invite.InviteManager;
   
   public class HappyRechargeFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:FilterFrameText;
      
      private var _btnOk:TextButton;
      
      private var _prizeArr:Array;
      
      private var _lotteryCountArr:Array;
      
      private var _prizeCountArr:Array;
      
      private var _prizeCell:BagCell;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _startAllBtn:SimpleBitmapButton;
      
      private var _stopAutoBtn:SimpleBitmapButton;
      
      private var _haloMc:MovieClip;
      
      private var _pointerMc:MovieClip;
      
      private var _bottomBack:MovieClip;
      
      private var _cellShine:MovieClip;
      
      private var _shineObject:Component;
      
      private var _bigYellowCircle:Bitmap;
      
      private var _smallCircleBack:Bitmap;
      
      private var _recordContents:VBox;
      
      private var _recordPanel:ScrollPanel;
      
      private var _exchangeContents:VBox;
      
      private var _exchangePanel:ScrollPanel;
      
      private var _activityData:FilterFrameText;
      
      private var _rotationArr:Array;
      
      private var _currentRotation:int;
      
      private var _frameIndex:int;
      
      private var _cellShineIndex:int;
      
      private var _sound:TurnSoundControl;
      
      public function HappyRechargeFrame()
      {
         _rotationArr = [15,45,75,105,135,165,-165,-135,-107,-77,-47,-17];
         super();
         _initView();
         _initEvent();
      }
      
      public function updateView(param1:HappyRechargeRecordItem = null) : void
      {
         var _loc2_:* = null;
         refreshLotteryCount();
         refreshPrizeCount();
         if(param1 != null)
         {
            _loc2_ = new HappyRechargeRecordView(param1.prizeType);
            _loc2_.setText(param1.nickName,_prizeCell.info.Name,param1.count);
            _recordContents.addChild(_loc2_);
            _recordContents.arrange();
            _recordPanel.invalidateViewport();
         }
      }
      
      public function startTurn(param1:int = 6) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         !_sound && new TurnSoundControl();
         InviteManager.Instance.enabled = false;
         _loc3_ = 0;
         while(_loc3_ < _prizeArr.length)
         {
            if(_prizeArr[_loc3_] is HappyRechargeTurnItemInfo)
            {
               _loc2_ = _prizeArr[_loc3_] as HappyRechargeTurnItemInfo;
               if(_loc2_.indexId == param1)
               {
                  _currentRotation = _loc3_;
                  break;
               }
            }
            else if(_prizeArr[_loc3_] == param1)
            {
               _currentRotation = _loc3_;
               break;
            }
            _loc3_++;
         }
         addEventListener("enterFrame",__startroll);
         _showHaloMc();
      }
      
      private function __startroll(param1:Event) : void
      {
         _sound.playThreeStep(3);
         if(_frameIndex < 8)
         {
            _pointerMc.rotation = _pointerMc.rotation + 20;
         }
         else if(_frameIndex < 23)
         {
            _pointerMc.rotation = _pointerMc.rotation + 45;
         }
         else if(_frameIndex < 30)
         {
            _pointerMc.rotation = _pointerMc.rotation + 10;
         }
         else if(Math.abs(_pointerMc.rotation - _rotationArr[_currentRotation]) > 10)
         {
            _pointerMc.rotation = _pointerMc.rotation + 10;
         }
         else
         {
            _pointerMc.rotation = _rotationArr[_currentRotation];
            _stopRoll();
         }
         _frameIndex = Number(_frameIndex) + 1;
         _pointerMc.rotation = _pointerMc.rotation == 360?0:Number(_pointerMc.rotation);
         _pointerMc.rotation = _pointerMc.rotation > 360?10:Number(_pointerMc.rotation);
      }
      
      public function autoStartTuren(param1:int) : void
      {
         index = param1;
         var i:int = 0;
         while(i < _prizeArr.length)
         {
            if(_prizeArr[i] is HappyRechargeTurnItemInfo)
            {
               var info:HappyRechargeTurnItemInfo = _prizeArr[i] as HappyRechargeTurnItemInfo;
               if(info.indexId == index)
               {
                  _currentRotation = i;
                  break;
               }
            }
            else if(_prizeArr[i] == index)
            {
               _currentRotation = i;
               break;
            }
            i = Number(i) + 1;
         }
         var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(HappyRechargeManager.instance.currentPrizeItemID);
         if(item != null)
         {
            var tips:String = LanguageMgr.GetTranslation("horseDaren.skill.descTxt",item.Name) + "x1";
            MessageTipManager.getInstance().show(tips,0,true);
            ChatManager.Instance.sysChatYellow(tips);
         }
         _pointerMc.rotation = _rotationArr[_currentRotation];
         SocketManager.Instance.out.happyRechargeQuestGetItem();
         HappyRechargeManager.instance.dispatchEvent(new Event("HAPPYRECHARGE_UPDATE_TICKET"));
         var time:uint = setTimeout(function():void
         {
            clearTimeout(time);
            if(HappyRechargeManager.instance.isAutoStart)
            {
               startTrun();
            }
         },500);
      }
      
      private function _stopRoll() : void
      {
         removeEventListener("enterFrame",__startroll);
         _frameIndex = 0;
         _hideHaloMc();
         _createCellShine();
      }
      
      private function _showHaloMc() : void
      {
         _haloMc.visible = true;
         _haloMc.gotoAndPlay(1);
      }
      
      private function _hideHaloMc() : void
      {
         _haloMc.visible = false;
         _haloMc.gotoAndStop(1);
      }
      
      private function _createCellShine() : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         _cellShine = ClassUtils.CreatInstance("happyRecharge.mainFrame.cellbackhalo");
         addToContent(_cellShine);
         PositionUtils.setPos(_cellShine,"mainframe.cellshinemc.pos." + _currentRotation);
         _shineObject = new Component();
         var _loc1_:int = HappyRechargeManager.instance.currentPrizeItemID;
         if(_loc1_ > 12)
         {
            _loc5_ = ItemManager.Instance.getTemplateById(_loc1_);
            _loc4_ = new BagCell(0,_loc5_);
            _loc2_ = _loc4_.getContent();
            _shineObject.addChild(_loc2_);
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.bigcell.image." + _loc1_);
            _shineObject.addChild(_loc3_);
         }
         addToContent(_shineObject);
         PositionUtils.setPos(_shineObject,"mainframe.cellshineobject.pos." + _currentRotation);
         addEventListener("enterFrame",__cellShineHandler);
      }
      
      private function _removeCellShine() : void
      {
         _cellShineIndex = 0;
         HappyRechargeManager.instance.mouseClickEnable = true;
         SocketManager.Instance.out.happyRechargeQuestGetItem();
         HappyRechargeManager.instance.dispatchEvent(new Event("HAPPYRECHARGE_UPDATE_TICKET"));
         ObjectUtils.disposeObject(_cellShine);
         _cellShine = null;
         removeEventListener("enterFrame",__cellShineHandler);
         _cellFlyToBag();
      }
      
      private function __cellShineHandler(param1:Event) : void
      {
         if(_cellShineIndex == 10)
         {
            _cellShineScale();
         }
         if(_cellShineIndex < 50)
         {
            _cellShineIndex = Number(_cellShineIndex) + 1;
         }
         else
         {
            _removeCellShine();
         }
      }
      
      private function _cellShineScale() : void
      {
         TweenLite.to(_shineObject,0.3,{
            "scaleX":1.2,
            "scaleY":1.2,
            "x":_shineObject.x - 4,
            "y":_shineObject.y - 4,
            "ease":Linear.easeNone
         });
      }
      
      private function _cellFlyToBag() : void
      {
         TweenLite.to(_shineObject,0.5,{
            "scaleX":0.3,
            "scaleY":0.3,
            "x":500,
            "y":478,
            "ease":Linear.easeNone
         });
      }
      
      private function _cellFlyToBagComplete() : void
      {
         InviteManager.Instance.enabled = true;
         updateState();
         ObjectUtils.disposeObject(_shineObject);
         _shineObject = null;
      }
      
      private function _initView() : void
      {
         HappyRechargeManager.instance.mouseClickEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.bg");
         addToContent(_bg);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("happyrecharge.mainframe.helpbt");
         addToContent(_helpBtn);
         refreshLotteryCount();
         refreshPrizeCount();
         setPrizeCell();
         setPrizeAreaCell();
         _bottomBack = ClassUtils.CreatInstance("happyRecharge.mainFrame.pointerbottom");
         PositionUtils.setPos(_bottomBack,"mainframe.bottomBack.mc.pos");
         addToContent(_bottomBack);
         _bigYellowCircle = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.pointerbigcircleback");
         addToContent(_bigYellowCircle);
         _haloMc = ClassUtils.CreatInstance("happyRecharge.mainFrame.pointerhalo");
         _haloMc.gotoAndStop(1);
         _haloMc.visible = false;
         PositionUtils.setPos(_haloMc,"mainframe.pointerbackhalo.mc.pos");
         addToContent(_haloMc);
         _pointerMc = ClassUtils.CreatInstance("happyRecharge.mainFrame.pointer");
         PositionUtils.setPos(_pointerMc,"mainframe.pointer.mc.pos");
         addToContent(_pointerMc);
         _smallCircleBack = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.startsmallcircleback");
         addToContent(_smallCircleBack);
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("happyRecharge.mainFrame.startBtn");
         addToContent(_startBtn);
         _startAllBtn = ComponentFactory.Instance.creatComponentByStylename("happyRecharge.mainFrame.startAllBtn");
         addToContent(_startAllBtn);
         _stopAutoBtn = ComponentFactory.Instance.creatComponentByStylename("happyRecharge.mainFrame.stopAutoBtn");
         addToContent(_stopAutoBtn);
         updateState();
         _recordContents = ComponentFactory.Instance.creatComponentByStylename("mainframe.recordView.Vbox");
         _recordContents.isReverAdd = true;
         _recordPanel = ComponentFactory.Instance.creatComponentByStylename("mainframe.recordViewList");
         _recordPanel.setView(_recordContents);
         addToContent(_recordPanel);
         createRecord();
         _exchangeContents = ComponentFactory.Instance.creatComponentByStylename("mainframe.exchangeView.Vbox");
         _exchangePanel = ComponentFactory.Instance.creatComponentByStylename("mainframe.exchangeViewList");
         _exchangePanel.setView(_exchangeContents);
         addToContent(_exchangePanel);
         createExchangeView();
         _activityData = ComponentFactory.Instance.creatComponentByStylename("mainframe.activityData.Txt");
         _activityData.text = LanguageMgr.GetTranslation("happyRecharge.mainFrame.activityData",HappyRechargeManager.instance.activityData);
         addToContent(_activityData);
      }
      
      private function _initEvent() : void
      {
         addEventListener("response",__response);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         _startBtn.addEventListener("click",___startBtnHandler);
         _startAllBtn.addEventListener("click",__onClickStartAll);
         _stopAutoBtn.addEventListener("click",__onClickStopAuto);
      }
      
      private function updateState(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            _startAllBtn.enable = true;
            _startAllBtn.visible = true;
            _startBtn.enable = true;
            _stopAutoBtn.visible = false;
            InviteManager.Instance.enabled = true;
            HappyRechargeManager.instance.mouseClickEnable = true;
         }
         else if(param1 == 1)
         {
            _startAllBtn.enable = false;
            _startAllBtn.visible = true;
            _startBtn.enable = false;
            _stopAutoBtn.visible = false;
            InviteManager.Instance.enabled = false;
            HappyRechargeManager.instance.mouseClickEnable = false;
         }
         else if(param1 == 2)
         {
            _startAllBtn.enable = false;
            _startAllBtn.visible = false;
            _startBtn.enable = false;
            _stopAutoBtn.enable = true;
            _stopAutoBtn.visible = true;
            InviteManager.Instance.enabled = false;
            HappyRechargeManager.instance.mouseClickEnable = false;
         }
      }
      
      private function __onClickStopAuto(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HappyRechargeManager.instance.isAutoStart = false;
         updateState();
      }
      
      private function __onClickStartAll(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HappyRechargeManager.instance.isAutoStart = true;
         updateState(2);
         startTrun();
      }
      
      private function ___startBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HappyRechargeManager.instance.isAutoStart = false;
         updateState(1);
         startTrun();
      }
      
      public function startTrun() : void
      {
         if(HappyRechargeManager.instance.lotteryCount > 0)
         {
            SocketManager.Instance.out.happyRechargeStartLottery();
         }
         else
         {
            updateState();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("happyRecharge.mainFrame.countless",HappyRechargeManager.instance.moneyCount));
         }
      }
      
      private function _removeEvent() : void
      {
         removeEventListener("response",__response);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",___startBtnHandler);
         }
         if(_startAllBtn)
         {
            _startAllBtn.removeEventListener("click",__onClickStartAll);
         }
         if(_stopAutoBtn)
         {
            _stopAutoBtn.removeEventListener("click",__onClickStopAuto);
         }
         if(this.hasEventListener("enterFrame"))
         {
            removeEventListener("enterFrame",__startroll);
            removeEventListener("enterFrame",__cellShineHandler);
         }
      }
      
      private function refreshLotteryCount() : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         if(_lotteryCountArr == null)
         {
            _lotteryCountArr = [];
         }
         else
         {
            while(_lotteryCountArr.length > 0)
            {
               _loc3_ = _lotteryCountArr.pop();
               ObjectUtils.disposeObject(_loc3_);
               _loc3_ = null;
            }
         }
         var _loc2_:String = HappyRechargeManager.instance.lotteryCount.toString();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.lotteryCount." + _loc2_.charAt(_loc5_));
            addToContent(_loc1_);
            _loc4_ = PositionUtils.creatPoint("mainframe.lotterycount.pos");
            _loc1_.x = _loc4_.x + 13 * _loc5_;
            _loc1_.y = _loc4_.y;
            _lotteryCountArr.push(_loc1_);
            _loc5_++;
         }
      }
      
      private function refreshPrizeCount() : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         if(_prizeCountArr == null)
         {
            _prizeCountArr = [];
         }
         else
         {
            while(_prizeCountArr.length > 0)
            {
               _loc4_ = _prizeCountArr.pop();
               ObjectUtils.disposeObject(_loc4_);
               _loc4_ = null;
            }
         }
         var _loc3_:String = HappyRechargeManager.instance.prizeCount.toString();
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.prizeCount." + _loc3_.charAt(_loc6_));
            addToContent(_loc2_);
            _loc5_ = PositionUtils.creatPoint("mainframe.prizecount.pos");
            _loc2_.x = _loc5_.x + 13 * _loc6_;
            _loc2_.y = _loc5_.y;
            _prizeCountArr.push(_loc2_);
            _loc6_++;
         }
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.prizeCount.x");
         addToContent(_loc1_);
         PositionUtils.setPos(_loc1_,"mainframe.prizecount.x.pos");
      }
      
      private function setPrizeCell() : void
      {
         var _loc2_:ItemTemplateInfo = HappyRechargeManager.instance.prizeItem;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,42,42);
         _loc1_.graphics.endFill();
         _prizeCell = new BagCell(0,_loc2_,false,_loc1_);
         _prizeCell.setCountNotVisible();
         PositionUtils.setPos(_prizeCell,"mainframe.prizecell.pos");
         addToContent(_prizeCell);
      }
      
      private function setPrizeAreaCell() : void
      {
         var _loc1_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:Array = HappyRechargeManager.instance.turnItems;
         if(_prizeArr == null)
         {
            _prizeArr = [];
         }
         else
         {
            while(_prizeArr.length > 0)
            {
               _prizeArr.pop();
            }
         }
         while(_loc4_.length > 0)
         {
            _loc1_ = Math.random() * _loc4_.length;
            _prizeArr.push(_loc4_[_loc1_]);
            _loc4_.splice(_loc1_,1);
         }
         _loc10_ = 0;
         while(_loc10_ < 4)
         {
            _loc9_ = Math.random() * _prizeArr.length;
            _prizeArr.splice(_loc9_,0,_loc10_ + 9);
            _loc10_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 12)
         {
            if(_prizeArr[_loc8_] is HappyRechargeTurnItemInfo)
            {
               _loc5_ = new BagCell(0,(_prizeArr[_loc8_] as HappyRechargeTurnItemInfo).itemInfo,false,ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.cellbg"));
               addToContent(_loc5_);
               _loc5_.setContentSize(44,44);
               _loc5_.PicPos = new Point(4.5,4.5);
               PositionUtils.setPos(_loc5_,"mainframe.prizeAreacell.pos." + _loc8_);
            }
            else
            {
               _loc7_ = _prizeArr[_loc8_];
               _loc2_ = ClassUtils.CreatInstance("happyRecharge.mainFrame.bigcellbg");
               addToContent(_loc2_);
               PositionUtils.setPos(_loc2_,"mainframe.prizeAreacell.pos." + _loc8_);
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("mainframe.bigcell." + _loc7_);
               addToContent(_loc6_);
               _loc6_.x = _loc2_.x + 5;
               _loc6_.y = _loc2_.y + 5;
               _loc3_ = new HappyRechargeSpecialItemTipInfo();
               _loc3_._title = LanguageMgr.GetTranslation("happyRecharge.mainFrame.bigcell.tipTitle" + _loc7_);
               if(_loc7_ == 9 || _loc7_ == 12)
               {
                  _loc3_._body = LanguageMgr.GetTranslation("happyRecharge.mainFrame.bigcell.tipContext" + _loc7_);
               }
               else
               {
                  _loc3_._body = LanguageMgr.GetTranslation("happyRecharge.mainFrame.bigcell.tipContext" + _loc7_,HappyRechargeManager.instance.specialPrizeCount[_loc7_ - 10]);
               }
               _loc6_.tipData = _loc3_;
            }
            _loc8_++;
         }
      }
      
      private function createExchangeView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = HappyRechargeManager.instance.exchangeItems;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_] as HappyRechargeExchangeItem;
            _loc4_ = new HappyRechargeExchangeView();
            _loc4_.setInfo(_loc2_.info,_loc2_.count,HappyRechargeManager.instance.ticketCount,_loc2_.needCount);
            _exchangeContents.addChild(_loc4_);
            if(_loc5_ + 1 < _loc1_.length)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.exchangeItem.line");
               _exchangeContents.addChild(_loc3_);
            }
            _loc5_++;
         }
         _exchangePanel.invalidateViewport();
      }
      
      private function createRecord() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = HappyRechargeManager.instance.recordArr;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc4_] as HappyRechargeRecordItem;
            if(_loc2_.prizeType > 9 && _loc2_.prizeType < 13)
            {
               _loc3_ = new HappyRechargeRecordView(_loc2_.prizeType);
               _loc3_.setText(_loc2_.nickName,_prizeCell.info.Name,_loc2_.count);
               _recordContents.addChild(_loc3_);
            }
            _loc4_++;
         }
         _recordPanel.invalidateViewport();
      }
      
      private function createPrizeAreaCellInfoForTest() : Array
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = [];
         var _loc2_:Array = [11901,11902,11903,11904,11905,11906,11025,100100];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(_loc2_[_loc4_]);
            _loc1_.push(_loc3_);
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function createExchangeItems() : Array
      {
         var _loc1_:Array = [];
         return _loc1_;
      }
      
      private function createTestRecordData() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = new HappyRechargeRecordItem();
            _loc2_.nickName = "呵呵哒";
            _loc2_.prizeType = int(Math.random() * 3 + 10);
            _loc2_.count = int(Math.random() * 1000);
            _loc1_.push(_loc2_);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(HappyRechargeManager.instance.mouseClickEnable)
            {
               SocketManager.Instance.out.happyRechargeQuestGetItem(1);
               dispose();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("happyRecharge.mainFrame.inrolling"));
            }
         }
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            _loc3_ = HappyRechargeManager.instance.moneyCount;
            _loc4_ = HappyRechargeManager.instance.specialPrizeCount[0];
            _loc2_ = HappyRechargeManager.instance.specialPrizeCount[1];
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("happyRecharge.mainFrame.titleTxt");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.bgHelp");
            _content = ComponentFactory.Instance.creatComponentByStylename("mainframe.helpframe.contentTxt");
            _content.htmlText = LanguageMgr.GetTranslation("happyRecharge.mainFrame.helpContentTxt",_loc3_,_loc3_,_loc3_ * 2.5,_loc4_,_loc2_);
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      override public function dispose() : void
      {
         _removeEvent();
         _sound && _sound.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_helpFrame);
         _helpFrame = null;
         ObjectUtils.disposeObject(_bgHelp);
         _bgHelp = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_btnOk);
         _btnOk = null;
         ObjectUtils.disposeObject(_exchangeContents);
         _exchangeContents = null;
         ObjectUtils.disposeObject(_exchangePanel);
         _exchangePanel = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         super.dispose();
      }
   }
}
