package dragonBoat.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerConfigInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import dragonBoat.event.DragonBoatEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import store.HelpFrame;
   
   public class DragonBoatFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftDragonBoatSprite:Sprite;
      
      private var _leftPlayerSprite:Sprite;
      
      private var _dragonboatBg:Bitmap;
      
      private var _selfRankBg:Bitmap;
      
      private var _otherRankBg:Bitmap;
      
      private var _smallBorder:Bitmap;
      
      private var _progressBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _progressMask:Bitmap;
      
      private var _selfRankSelectedBtn:SelectedButton;
      
      private var _otherRankSelectedBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _selfRankSprite:Sprite;
      
      private var _otherRankSprite:Sprite;
      
      private var _normalDecorateBtn:SimpleBitmapButton;
      
      private var _highDecorateBtn:SimpleBitmapButton;
      
      private var _normalBuildBtn:SimpleBitmapButton;
      
      private var _highBuildBtn:SimpleBitmapButton;
      
      private var _scoreExchangeBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _progressTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _scoreTxt2:FilterFrameText;
      
      private var _rankTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _leftBottomTxt:FilterFrameText;
      
      private var _rightBottomTxt:FilterFrameText;
      
      private var _selfRankList:ListPanel;
      
      private var _otherRankList:ListPanel;
      
      private var _selfDataList:Array;
      
      private var _selfRank:String = "";
      
      private var _selfLessScore:String = "";
      
      private var _otherDataList:Array;
      
      private var _otherRank:String = "";
      
      private var _otherLessScore:String = "";
      
      private var _timer:Timer;
      
      private var _displayMc:MovieClip;
      
      private var _dragonBoatLeftCurrentCharcter:DragonBoatLeftCurrentCharcter;
      
      private var type:int;
      
      private var _playerInfo:PlayerInfo;
      
      public function DragonBoatFrame()
      {
         _selfDataList = [];
         _otherDataList = [];
         super();
      }
      
      public function init2(activeID:int) : void
      {
         type = activeID;
         initView();
         initEvent();
         refreshView();
         refreshItemCount();
         _btnGroup.selectIndex = 0;
         var tmpStartTime:Date = DragonBoatManager.instance.tmpStartTime;
         var tmpEndTime:Date = DragonBoatManager.instance.tmpEndTime;
         _timeTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.timeTxt",tmpStartTime.fullYear,tmpStartTime.month + 1,tmpStartTime.date,tmpEndTime.fullYear,tmpEndTime.month + 1,tmpEndTime.date);
         initTimer();
         SocketManager.Instance.out.sendDragonBoatRefreshBoatStatus();
         SocketManager.Instance.out.sendDragonBoatRefreshRank();
         DragonBoatManager.instance.setOpenFrameParam();
      }
      
      private function initView() : void
      {
         if(DragonBoatManager.instance.isBuildEnd)
         {
            titleText = LanguageMgr.GetTranslation("ddt.hall.dragonboatentrybtnTitle");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.frameTitle");
         }
         if(type == 1)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.bg");
         }
         else if(type == 4)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.kingStatue.mainFrame.bg");
         }
         _leftDragonBoatSprite = new Sprite();
         _leftPlayerSprite = new Sprite();
         _selfRankBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.selfRank.bg");
         _otherRankBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.otherRank.bg");
         _smallBorder = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.smallBorder");
         _selfRankSprite = new Sprite();
         PositionUtils.setPos(_selfRankSprite,"dragonBoat.mainFrame.selfRankPos");
         _selfRankSprite.addChild(_selfRankBg);
         _otherRankSprite = new Sprite();
         PositionUtils.setPos(_otherRankSprite,"dragonBoat.mainFrame.otherRankPos");
         _otherRankSprite.addChild(_otherRankBg);
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.progressBg");
         _progress = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.progress");
         _progressMask = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.progressBg");
         _progress.mask = _progressMask;
         _selfRankSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.selfRank.btn");
         _otherRankSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.otherRank.btn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_selfRankSelectedBtn);
         _btnGroup.addSelectItem(_otherRankSelectedBtn);
         _normalDecorateBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalDecorateBtn");
         _highDecorateBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.highDecorateBtn");
         _normalBuildBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalBuildBtn");
         _highBuildBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.highBuildBtn");
         _scoreExchangeBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.scoreBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.helpBtn");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.progressTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.timeTxt");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.scoreTxt");
         PositionUtils.setPos(_itemCountTxt,"dragonBoat.mainFrame.itemCountTxtPos");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.scoreTxt");
         PositionUtils.setPos(_scoreTxt,"dragonBoat.mainFrame.scoreTxt1Pos");
         _scoreTxt2 = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.scoreTxt");
         PositionUtils.setPos(_scoreTxt2,"dragonBoat.mainFrame.scoreTxt2Pos");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.rankTxt");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.needTxt");
         _leftBottomTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.bottomTxt");
         _leftBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.leftBottomTxt");
         _rightBottomTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.bottomTxt2");
         var dragonBoatAreaMinScore:String = "";
         var sConfigInfo:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("DragonBoatAreaMinScore");
         if(sConfigInfo)
         {
            dragonBoatAreaMinScore = sConfigInfo.Value;
         }
         _rightBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.rightBottomTxt",DragonBoatManager.instance.activeInfo.MinScore,dragonBoatAreaMinScore);
         _selfRankList = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.selfRankList");
         _selfRankSprite.addChild(_selfRankList);
         _otherRankList = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.otherRankList");
         _otherRankSprite.addChild(_otherRankList);
         switch(int(type) - 1)
         {
            case 0:
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.frameTitle");
               _bg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.bg");
               PositionUtils.setPos(_itemCountTxt,"dragonBoat.mainFrame.itemCountTxtPos");
               _leftBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.leftBottomTxt");
               _rightBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.rightBottomTxt",DragonBoatManager.instance.activeInfo.MinScore,dragonBoatAreaMinScore);
               _displayMc = ComponentFactory.Instance.creat("asset.dragonBoat.boatMc");
               _displayMc.scaleX = 1.2;
               _displayMc.scaleY = 1.2;
               PositionUtils.setPos(_displayMc,"dragonBoat.shopFrame.boatMcPos");
               _dragonboatBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.dragonboatBg");
               break;
            default:
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.frameTitle");
               _bg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.bg");
               PositionUtils.setPos(_itemCountTxt,"dragonBoat.mainFrame.itemCountTxtPos");
               _leftBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.leftBottomTxt");
               _rightBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.rightBottomTxt",DragonBoatManager.instance.activeInfo.MinScore,dragonBoatAreaMinScore);
               _displayMc = ComponentFactory.Instance.creat("asset.dragonBoat.boatMc");
               _displayMc.scaleX = 1.2;
               _displayMc.scaleY = 1.2;
               PositionUtils.setPos(_displayMc,"dragonBoat.shopFrame.boatMcPos");
               _dragonboatBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.dragonboatBg");
               break;
            default:
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.frameTitle");
               _bg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.bg");
               PositionUtils.setPos(_itemCountTxt,"dragonBoat.mainFrame.itemCountTxtPos");
               _leftBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.leftBottomTxt");
               _rightBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.rightBottomTxt",DragonBoatManager.instance.activeInfo.MinScore,dragonBoatAreaMinScore);
               _displayMc = ComponentFactory.Instance.creat("asset.dragonBoat.boatMc");
               _displayMc.scaleX = 1.2;
               _displayMc.scaleY = 1.2;
               PositionUtils.setPos(_displayMc,"dragonBoat.shopFrame.boatMcPos");
               _dragonboatBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.dragonboatBg");
               break;
            case 3:
               titleText = LanguageMgr.GetTranslation("kingStatue.title");
               _bg = ComponentFactory.Instance.creatBitmap("asset.kingStatue.mainFrame.bg");
               PositionUtils.setPos(_itemCountTxt,"dragonBoat.mainFrame.itemCountTxtPos");
               _leftBottomTxt.text = LanguageMgr.GetTranslation("kingStatue.leftBottomTxt");
               _rightBottomTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.rightBottomTxt2",DragonBoatManager.instance.activeInfo.MinScore,dragonBoatAreaMinScore);
               _displayMc = ComponentFactory.Instance.creat("asset.kingStatue.statueFrameMc");
               _displayMc.gotoAndStop(6);
               PositionUtils.setPos(_displayMc,"kingStatue.mainFrame.statuePos");
               _dragonboatBg = ComponentFactory.Instance.creatBitmap("asset.kingStatue.mainFrame.kingStatueBg");
         }
         addToContent(_bg);
         addToContent(_leftDragonBoatSprite);
         addToContent(_leftPlayerSprite);
         _leftDragonBoatSprite.addChild(_dragonboatBg);
         addToContent(_selfRankSprite);
         addToContent(_otherRankSprite);
         addToContent(_smallBorder);
         _leftDragonBoatSprite.addChild(_displayMc);
         _leftDragonBoatSprite.addChild(_progress);
         _leftDragonBoatSprite.addChild(_progressBg);
         _leftDragonBoatSprite.addChild(_progressMask);
         addToContent(_selfRankSelectedBtn);
         addToContent(_otherRankSelectedBtn);
         _leftDragonBoatSprite.addChild(_normalDecorateBtn);
         _leftDragonBoatSprite.addChild(_highDecorateBtn);
         _leftDragonBoatSprite.addChild(_normalBuildBtn);
         _leftDragonBoatSprite.addChild(_highBuildBtn);
         addToContent(_scoreExchangeBtn);
         addToContent(_helpBtn);
         _leftDragonBoatSprite.addChild(_progressTxt);
         addToContent(_timeTxt);
         addToContent(_itemCountTxt);
         addToContent(_scoreTxt);
         addToContent(_scoreTxt2);
         addToContent(_rankTxt);
         addToContent(_needTxt);
         addToContent(_leftBottomTxt);
         addToContent(_rightBottomTxt);
         if(DragonBoatManager.instance.isBuildEnd)
         {
            _leftDragonBoatSprite.visible = false;
         }
         else
         {
            isShowDragonboat(true);
         }
      }
      
      private function initTimer() : void
      {
         if(DragonBoatManager.instance.isCanBuildOrDecorate)
         {
            _timer = new Timer(300000);
            _timer.addEventListener("timer",timerHander,false,0,true);
            _timer.start();
         }
      }
      
      private function timerHander(event:TimerEvent) : void
      {
         SocketManager.Instance.out.sendDragonBoatRefreshBoatStatus();
         SocketManager.Instance.out.sendDragonBoatRefreshRank();
      }
      
      private function refreshView() : void
      {
         var isShowBuild:Boolean = false;
         var isEnable:Boolean = false;
         _displayMc.gotoAndStop(6);
         var completeStatus:int = DragonBoatManager.instance.boatCompleteStatus;
         _progressMask.scaleX = completeStatus / 100;
         _progressTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.progressTxt",completeStatus);
         _scoreTxt.text = DragonBoatManager.instance.useableScore + "";
         _scoreTxt2.text = DragonBoatManager.instance.totalScore + "";
         _leftDragonBoatSprite.addChild(_normalDecorateBtn);
         _leftDragonBoatSprite.addChild(_highDecorateBtn);
         _leftDragonBoatSprite.addChild(_normalBuildBtn);
         _leftDragonBoatSprite.addChild(_highBuildBtn);
         if(completeStatus >= 100)
         {
            isShowBuild = false;
         }
         else
         {
            isShowBuild = true;
         }
         if(DragonBoatManager.instance.isCanBuildOrDecorate)
         {
            isEnable = true;
         }
         else
         {
            isEnable = false;
         }
         refreshBtnStatus(isShowBuild,isEnable);
      }
      
      private function refreshBtnStatus(isShowBuild:Boolean, isEnable:Boolean) : void
      {
         _normalDecorateBtn.visible = !isShowBuild;
         _highDecorateBtn.visible = !isShowBuild;
         _normalBuildBtn.visible = isShowBuild;
         _highBuildBtn.visible = isShowBuild;
         _normalDecorateBtn.enable = isEnable;
         _highDecorateBtn.enable = isEnable;
         _normalBuildBtn.enable = isEnable;
         _highBuildBtn.enable = isEnable;
      }
      
      private function refreshItemCount() : void
      {
         var useChipId:int = 0;
         var num:int = 0;
         if(type == 1)
         {
            useChipId = 11690;
         }
         else
         {
            useChipId = 11771;
         }
         _itemCountTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(useChipId,false).toString();
         var _item2:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201309,false);
         if(_item2 > 0)
         {
            num = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(useChipId,true) + _item2;
            _itemCountTxt.text = num.toString();
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnGroup.addEventListener("change",__changeHandler,false,0,true);
         _selfRankSelectedBtn.addEventListener("click",__soundPlay,false,0,true);
         _otherRankSelectedBtn.addEventListener("click",__soundPlay,false,0,true);
         _normalBuildBtn.addEventListener("click",consumeHandler,false,0,true);
         _highBuildBtn.addEventListener("click",consumeHandler,false,0,true);
         _normalDecorateBtn.addEventListener("click",consumeHandler,false,0,true);
         _highDecorateBtn.addEventListener("click",consumeHandler,false,0,true);
         _helpBtn.addEventListener("click",openHelpFrame,false,0,true);
         _scoreExchangeBtn.addEventListener("click",openShopFrame,false,0,true);
         DragonBoatManager.instance.addEventListener("DragonBoatBuildOrDecorateUpdate",buildOrDecorateHandler);
         DragonBoatManager.instance.addEventListener("DragonBoatRefreshBoatStatus",refreshBoatStatusHandler);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",itemUpdateHandler);
         DragonBoatManager.instance.addEventListener("DragBoatUpdateRankInfo",updateRankInfo);
      }
      
      private function updateRankInfo(event:DragonBoatEvent) : void
      {
         var rank:int = 0;
         var rank2:int = 0;
         var tag:int = event.tag;
         if(tag == 1)
         {
            _selfDataList = event.data.dataList;
            rank = event.data.myRank;
            if(rank < 0)
            {
               _selfRank = LanguageMgr.GetTranslation("ddt.dragonBoat.rankNoPlace");
            }
            else
            {
               _selfRank = rank.toString();
            }
            _selfLessScore = event.data.lessScore.toString();
            if(_btnGroup.selectIndex == 0)
            {
               refreshRankView(1);
            }
            if(DragonBoatManager.instance.isBuildEnd)
            {
               isShowDragonboat(false);
            }
            else
            {
               isShowDragonboat(true);
            }
         }
         else
         {
            _otherDataList = event.data.dataList;
            rank2 = event.data.myRank;
            if(rank2 < 0)
            {
               _otherRank = LanguageMgr.GetTranslation("ddt.dragonBoat.rankNoPlace");
            }
            else
            {
               _otherRank = rank2.toString();
            }
            _otherLessScore = event.data.lessScore.toString();
            if(_btnGroup.selectIndex == 1)
            {
               refreshRankView(2);
            }
         }
      }
      
      private function refreshRankView(tag:int) : void
      {
         if(tag == 1)
         {
            _selfRankList.vectorListModel.clear();
            _selfRankList.vectorListModel.appendAll(_selfDataList);
            _selfRankList.list.updateListView();
            _rankTxt.text = _selfRank;
            _needTxt.text = _selfLessScore;
         }
         else
         {
            _otherRankList.vectorListModel.clear();
            _otherRankList.vectorListModel.appendAll(_otherDataList);
            _otherRankList.list.updateListView();
            _rankTxt.text = _otherRank;
            _needTxt.text = _otherLessScore;
         }
         var _rankTextFormatSize:int = 30;
         if(_rankTxt.textWidth > _rankTxt.width)
         {
            _rankTextFormatSize = 14;
            _rankTxt.y = 420;
         }
         else
         {
            _rankTxt.y = 413;
         }
         var _txtFormat:TextFormat = _rankTxt.getTextFormat();
         _txtFormat.size = _rankTextFormatSize;
         _rankTxt.setTextFormat(_txtFormat);
         _rankTxt.defaultTextFormat = _txtFormat;
      }
      
      private function openShopFrame(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var shopFrame:DragonBoatShopFrame = ComponentFactory.Instance.creatComponentByStylename("DragonBoatShopFrame");
         LayerManager.Instance.addToLayer(shopFrame,3,true,1);
      }
      
      private function openHelpFrame(event:MouseEvent) : void
      {
         var helpBd:* = null;
         SoundManager.instance.play("008");
         switch(int(type) - 1)
         {
            case 0:
               helpBd = ComponentFactory.Instance.creat("dragonBoat.HelpPrompt");
               break;
            default:
               helpBd = ComponentFactory.Instance.creat("dragonBoat.HelpPrompt");
               break;
            default:
               helpBd = ComponentFactory.Instance.creat("dragonBoat.HelpPrompt");
               break;
            case 3:
               helpBd = ComponentFactory.Instance.creat("dragonBoat.statueHelpPrompt");
         }
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("dragonBoat.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(helpPage,3,true,1);
      }
      
      private function refreshBoatStatusHandler(event:Event) : void
      {
         refreshView();
      }
      
      private function itemUpdateHandler(event:BagEvent) : void
      {
         refreshItemCount();
      }
      
      private function buildOrDecorateHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendDragonBoatRefreshRank();
         refreshView();
      }
      
      private function consumeHandler(event:Event) : void
      {
         var normalView:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmp:int = 1;
         var _loc4_:* = event.currentTarget;
         if(_normalBuildBtn !== _loc4_)
         {
            if(_normalDecorateBtn !== _loc4_)
            {
               if(_highBuildBtn !== _loc4_)
               {
                  if(_highDecorateBtn === _loc4_)
                  {
                     tmp = 4;
                  }
               }
               else
               {
                  tmp = 3;
               }
            }
            else
            {
               tmp = 2;
            }
         }
         else
         {
            tmp = 1;
         }
         switch(int(tmp) - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               if((tmp == 1 || tmp == 2) && int(_itemCountTxt.text) <= 0)
               {
                  if(type == 1)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.dragonBoat.noEnoughPiece"),0,true);
                  }
                  else if(type == 4)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.dragonBoat.statueNoEnoughPiece"),0,true);
                  }
                  return;
               }
               if((tmp == 3 || tmp == 4) && PlayerManager.Instance.Self.Money < 100)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               normalView = ComponentFactory.Instance.creatComponentByStylename("DragonBoatNormalView");
               normalView.setView(tmp);
               LayerManager.Instance.addToLayer(normalView,3,true,1);
               break;
         }
      }
      
      private function __changeHandler(event:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _selfRankSelectedBtn.x = 390;
               _selfRankSelectedBtn.y = 4;
               _otherRankSelectedBtn.x = 563;
               _otherRankSelectedBtn.y = 7;
               _selfRankSprite.visible = true;
               _otherRankSprite.visible = false;
               refreshRankView(1);
               break;
            case 1:
               _selfRankSelectedBtn.x = 396;
               _selfRankSelectedBtn.y = 6;
               _otherRankSelectedBtn.x = 550;
               _otherRankSelectedBtn.y = 4;
               _selfRankSprite.visible = false;
               _otherRankSprite.visible = true;
               refreshRankView(2);
         }
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function isShowDragonboat(bool:Boolean) : void
      {
         _leftDragonBoatSprite.visible = bool;
         if(_dragonBoatLeftCurrentCharcter)
         {
            _dragonBoatLeftCurrentCharcter.visible = !bool;
         }
         if(!bool)
         {
            showPlayerNo1();
         }
      }
      
      private function showPlayerNo1() : void
      {
         var tempPlayerObj:* = null;
         if(_selfDataList.length <= 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _selfDataList;
         for each(var obj in _selfDataList)
         {
            if(obj.rank == 1)
            {
               tempPlayerObj = obj;
               break;
            }
         }
         _playerInfo = new PlayerInfo();
         if(tempPlayerObj.name == PlayerManager.Instance.Self.NickName)
         {
            _playerInfo = PlayerManager.Instance.Self;
         }
         else
         {
            _playerInfo = PlayerManager.Instance.findPlayerByNickName(_playerInfo,tempPlayerObj.name);
         }
         if(_playerInfo.ID && _playerInfo.Style)
         {
            initPlayerNo1();
         }
         else
         {
            SocketManager.Instance.out.sendItemEquip(tempPlayerObj.name,true);
            _playerInfo.addEventListener("propertychange",__playerInfoChange);
         }
      }
      
      private function __playerInfoChange(event:PlayerPropertyEvent) : void
      {
         _playerInfo.removeEventListener("propertychange",__playerInfoChange);
         initPlayerNo1();
      }
      
      private function initPlayerNo1() : void
      {
         if(!_dragonBoatLeftCurrentCharcter)
         {
            _dragonBoatLeftCurrentCharcter = new DragonBoatLeftCurrentCharcter();
            _leftPlayerSprite.addChild(_dragonBoatLeftCurrentCharcter);
         }
         _dragonBoatLeftCurrentCharcter.updateInfo(_playerInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _selfRankSelectedBtn.removeEventListener("click",__soundPlay);
         _otherRankSelectedBtn.removeEventListener("click",__soundPlay);
         _normalBuildBtn.removeEventListener("click",consumeHandler);
         _highBuildBtn.removeEventListener("click",consumeHandler);
         _normalDecorateBtn.removeEventListener("click",consumeHandler);
         _highDecorateBtn.removeEventListener("click",consumeHandler);
         _helpBtn.removeEventListener("click",openHelpFrame);
         _scoreExchangeBtn.removeEventListener("click",openShopFrame);
         DragonBoatManager.instance.removeEventListener("DragonBoatBuildOrDecorateUpdate",buildOrDecorateHandler);
         DragonBoatManager.instance.removeEventListener("DragonBoatRefreshBoatStatus",refreshBoatStatusHandler);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",itemUpdateHandler);
         DragonBoatManager.instance.removeEventListener("DragBoatUpdateRankInfo",updateRankInfo);
         if(_playerInfo)
         {
            _playerInfo.removeEventListener("propertychange",__playerInfoChange);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_dragonBoatLeftCurrentCharcter)
         {
            _dragonBoatLeftCurrentCharcter.dispose();
         }
         _dragonBoatLeftCurrentCharcter = null;
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHander);
            _timer.stop();
            _timer = null;
         }
         if(_displayMc)
         {
            _displayMc.gotoAndStop(_displayMc.totalFrames);
            _displayMc = null;
         }
         _selfDataList = null;
         _otherDataList = null;
         ObjectUtils.disposeObject(_selfRankList);
         _selfRankList = null;
         ObjectUtils.disposeObject(_otherRankList);
         _otherRankList = null;
         super.dispose();
         _bg = null;
         _selfRankBg = null;
         _otherRankBg = null;
         _smallBorder = null;
         _progressBg = null;
         _progress = null;
         _progressMask = null;
         _selfRankSelectedBtn = null;
         _otherRankSelectedBtn = null;
         _btnGroup = null;
         _selfRankSprite = null;
         _otherRankSprite = null;
         _normalDecorateBtn = null;
         _highDecorateBtn = null;
         _normalBuildBtn = null;
         _highBuildBtn = null;
         _scoreExchangeBtn = null;
         _helpBtn = null;
         _progressTxt = null;
         _timeTxt = null;
         _itemCountTxt = null;
         _scoreTxt = null;
         _scoreTxt2 = null;
         _rankTxt = null;
         _needTxt = null;
         _leftBottomTxt = null;
         _rightBottomTxt = null;
         _leftDragonBoatSprite = null;
         _leftPlayerSprite = null;
      }
   }
}
