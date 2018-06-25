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
      
      public function updateView(recordItem:HappyRechargeRecordItem = null) : void
      {
         var view:* = null;
         refreshLotteryCount();
         refreshPrizeCount();
         if(recordItem != null)
         {
            view = new HappyRechargeRecordView(recordItem.prizeType);
            view.setText(recordItem.nickName,_prizeCell.info.Name,recordItem.count);
            _recordContents.addChild(view);
            _recordContents.arrange();
            _recordPanel.invalidateViewport();
         }
      }
      
      public function startTurn(pos:int = 6) : void
      {
         var i:int = 0;
         var info:* = null;
         !_sound && new TurnSoundControl();
         InviteManager.Instance.enabled = false;
         for(i = 0; i < _prizeArr.length; )
         {
            if(_prizeArr[i] is HappyRechargeTurnItemInfo)
            {
               info = _prizeArr[i] as HappyRechargeTurnItemInfo;
               if(info.indexId == pos)
               {
                  _currentRotation = i;
                  break;
               }
            }
            else if(_prizeArr[i] == pos)
            {
               _currentRotation = i;
               break;
            }
            i++;
         }
         addEventListener("enterFrame",__startroll);
         _showHaloMc();
      }
      
      private function __startroll(e:Event) : void
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
      
      public function autoStartTuren(index:int) : void
      {
         index = index;
         for(var i:int = 0; i < _prizeArr.length; )
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
         var info:* = null;
         var cell:* = null;
         var sp:* = null;
         var bm:* = null;
         _cellShine = ClassUtils.CreatInstance("happyRecharge.mainFrame.cellbackhalo");
         addToContent(_cellShine);
         PositionUtils.setPos(_cellShine,"mainframe.cellshinemc.pos." + _currentRotation);
         _shineObject = new Component();
         var t:int = HappyRechargeManager.instance.currentPrizeItemID;
         if(t > 12)
         {
            info = ItemManager.Instance.getTemplateById(t);
            cell = new BagCell(0,info);
            sp = cell.getContent();
            _shineObject.addChild(sp);
         }
         else
         {
            bm = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.bigcell.image." + t);
            _shineObject.addChild(bm);
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
      
      private function __cellShineHandler(e:Event) : void
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
      
      private function updateState(type:int = 0) : void
      {
         if(type == 0)
         {
            _startAllBtn.enable = true;
            _startAllBtn.visible = true;
            _startBtn.enable = true;
            _stopAutoBtn.visible = false;
            InviteManager.Instance.enabled = true;
            HappyRechargeManager.instance.mouseClickEnable = true;
         }
         else if(type == 1)
         {
            _startAllBtn.enable = false;
            _startAllBtn.visible = true;
            _startBtn.enable = false;
            _stopAutoBtn.visible = false;
            InviteManager.Instance.enabled = false;
            HappyRechargeManager.instance.mouseClickEnable = false;
         }
         else if(type == 2)
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
      
      private function __onClickStopAuto(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HappyRechargeManager.instance.isAutoStart = false;
         updateState();
      }
      
      private function __onClickStartAll(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         HappyRechargeManager.instance.isAutoStart = true;
         updateState(2);
         startTrun();
      }
      
      private function ___startBtnHandler(e:MouseEvent) : void
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
         var bm:* = null;
         var i:int = 0;
         var num:* = null;
         var pos:* = null;
         if(_lotteryCountArr == null)
         {
            _lotteryCountArr = [];
         }
         else
         {
            while(_lotteryCountArr.length > 0)
            {
               bm = _lotteryCountArr.pop();
               ObjectUtils.disposeObject(bm);
               bm = null;
            }
         }
         var count:String = HappyRechargeManager.instance.lotteryCount.toString();
         for(i = 0; i < count.length; )
         {
            num = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.lotteryCount." + count.charAt(i));
            addToContent(num);
            pos = PositionUtils.creatPoint("mainframe.lotterycount.pos");
            num.x = pos.x + 13 * i;
            num.y = pos.y;
            _lotteryCountArr.push(num);
            i++;
         }
      }
      
      private function refreshPrizeCount() : void
      {
         var bm:* = null;
         var i:int = 0;
         var num:* = null;
         var pos:* = null;
         if(_prizeCountArr == null)
         {
            _prizeCountArr = [];
         }
         else
         {
            while(_prizeCountArr.length > 0)
            {
               bm = _prizeCountArr.pop();
               ObjectUtils.disposeObject(bm);
               bm = null;
            }
         }
         var count:String = HappyRechargeManager.instance.prizeCount.toString();
         for(i = 0; i < count.length; )
         {
            num = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.prizeCount." + count.charAt(i));
            addToContent(num);
            pos = PositionUtils.creatPoint("mainframe.prizecount.pos");
            num.x = pos.x + 13 * i;
            num.y = pos.y;
            _prizeCountArr.push(num);
            i++;
         }
         var bitmapX:Bitmap = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.prizeCount.x");
         addToContent(bitmapX);
         PositionUtils.setPos(bitmapX,"mainframe.prizecount.x.pos");
      }
      
      private function setPrizeCell() : void
      {
         var info:ItemTemplateInfo = HappyRechargeManager.instance.prizeItem;
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(16711680,0);
         bg.graphics.drawRect(0,0,42,42);
         bg.graphics.endFill();
         _prizeCell = new BagCell(0,info,false,bg);
         _prizeCell.setCountNotVisible();
         PositionUtils.setPos(_prizeCell,"mainframe.prizecell.pos");
         addToContent(_prizeCell);
      }
      
      private function setPrizeAreaCell() : void
      {
         var index:int = 0;
         var i:int = 0;
         var bigindex:int = 0;
         var j:int = 0;
         var cell:* = null;
         var type:int = 0;
         var bgmc:* = null;
         var image:* = null;
         var tipinfo:* = null;
         var tempArr:Array = HappyRechargeManager.instance.turnItems;
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
         while(tempArr.length > 0)
         {
            index = Math.random() * tempArr.length;
            _prizeArr.push(tempArr[index]);
            tempArr.splice(index,1);
         }
         for(i = 0; i < 4; )
         {
            bigindex = Math.random() * _prizeArr.length;
            _prizeArr.splice(bigindex,0,i + 9);
            i++;
         }
         for(j = 0; j < 12; )
         {
            if(_prizeArr[j] is HappyRechargeTurnItemInfo)
            {
               cell = new BagCell(0,(_prizeArr[j] as HappyRechargeTurnItemInfo).itemInfo,false,ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.cellbg"));
               addToContent(cell);
               cell.setContentSize(44,44);
               cell.PicPos = new Point(4.5,4.5);
               PositionUtils.setPos(cell,"mainframe.prizeAreacell.pos." + j);
            }
            else
            {
               type = _prizeArr[j];
               bgmc = ClassUtils.CreatInstance("happyRecharge.mainFrame.bigcellbg");
               addToContent(bgmc);
               PositionUtils.setPos(bgmc,"mainframe.prizeAreacell.pos." + j);
               image = ComponentFactory.Instance.creatComponentByStylename("mainframe.bigcell." + type);
               addToContent(image);
               image.x = bgmc.x + 5;
               image.y = bgmc.y + 5;
               tipinfo = new HappyRechargeSpecialItemTipInfo();
               tipinfo._title = LanguageMgr.GetTranslation("happyRecharge.mainFrame.bigcell.tipTitle" + type);
               if(type == 9 || type == 12)
               {
                  tipinfo._body = LanguageMgr.GetTranslation("happyRecharge.mainFrame.bigcell.tipContext" + type);
               }
               else
               {
                  tipinfo._body = LanguageMgr.GetTranslation("happyRecharge.mainFrame.bigcell.tipContext" + type,HappyRechargeManager.instance.specialPrizeCount[type - 10]);
               }
               image.tipData = tipinfo;
            }
            j++;
         }
      }
      
      private function createExchangeView() : void
      {
         var i:int = 0;
         var item:* = null;
         var view:* = null;
         var line:* = null;
         var items:Array = HappyRechargeManager.instance.exchangeItems;
         for(i = 0; i < items.length; )
         {
            item = items[i] as HappyRechargeExchangeItem;
            view = new HappyRechargeExchangeView();
            view.setInfo(item.info,item.count,HappyRechargeManager.instance.ticketCount,item.needCount);
            _exchangeContents.addChild(view);
            if(i + 1 < items.length)
            {
               line = ComponentFactory.Instance.creatBitmap("happyRecharge.mainFrame.exchangeItem.line");
               _exchangeContents.addChild(line);
            }
            i++;
         }
         _exchangePanel.invalidateViewport();
      }
      
      private function createRecord() : void
      {
         var i:int = 0;
         var item:* = null;
         var view:* = null;
         var items:Array = HappyRechargeManager.instance.recordArr;
         for(i = 0; i < items.length; )
         {
            item = items[i] as HappyRechargeRecordItem;
            if(item.prizeType > 9 && item.prizeType < 13)
            {
               view = new HappyRechargeRecordView(item.prizeType);
               view.setText(item.nickName,_prizeCell.info.Name,item.count);
               _recordContents.addChild(view);
            }
            i++;
         }
         _recordPanel.invalidateViewport();
      }
      
      private function createPrizeAreaCellInfoForTest() : Array
      {
         var i:int = 0;
         var info:* = null;
         var arr:Array = [];
         var idArr:Array = [11901,11902,11903,11904,11905,11906,11025,100100];
         for(i = 0; i < idArr.length; )
         {
            info = ItemManager.Instance.getTemplateById(idArr[i]);
            arr.push(info);
            i++;
         }
         return arr;
      }
      
      private function createExchangeItems() : Array
      {
         var arr:Array = [];
         return arr;
      }
      
      private function createTestRecordData() : Array
      {
         var i:int = 0;
         var item:* = null;
         var arr:Array = [];
         for(i = 0; i < 8; )
         {
            item = new HappyRechargeRecordItem();
            item.nickName = "呵呵哒";
            item.prizeType = int(Math.random() * 3 + 10);
            item.count = int(Math.random() * 1000);
            arr.push(item);
            i++;
         }
         return arr;
      }
      
      private function __response(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
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
      
      private function __helpBtnHandler(e:MouseEvent) : void
      {
         var money:int = 0;
         var special1:int = 0;
         var special2:int = 0;
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            money = HappyRechargeManager.instance.moneyCount;
            special1 = HappyRechargeManager.instance.specialPrizeCount[0];
            special2 = HappyRechargeManager.instance.specialPrizeCount[1];
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("happyRecharge.mainFrame.titleTxt");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.bgHelp");
            _content = ComponentFactory.Instance.creatComponentByStylename("mainframe.helpframe.contentTxt");
            _content.htmlText = LanguageMgr.GetTranslation("happyRecharge.mainFrame.helpContentTxt",money,money,money * 2.5,special1,special2);
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(e:MouseEvent) : void
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
