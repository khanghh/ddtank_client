package rescue.views
{
   import baglocked.BaglockedManager;
   import catchInsect.data.RescueSceneInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import rescue.RescueControl;
   import rescue.RescueManager;
   import rescue.components.RescuePrizeItem;
   import rescue.components.RescueSceneItem;
   import rescue.components.RescueShopItem;
   import rescue.data.RescueRewardInfo;
   import road7th.comm.PackageIn;
   
   public class RescueMainFrame extends Frame
   {
      
      private static const NUM:int = 3;
       
      
      private var _bg:Bitmap;
      
      private var _sceneArr:Vector.<RescueSceneItem>;
      
      private var _tileList:SimpleTileList;
      
      private var _txtImg:Bitmap;
      
      private var _arrowTxt:FilterFrameText;
      
      private var _bloodPackTxt:FilterFrameText;
      
      private var _kingBlessTxt:FilterFrameText;
      
      private var _shopVBox:VBox;
      
      private var _prizeHBox:HBox;
      
      private var _prizeArr:Vector.<RescuePrizeItem>;
      
      private var _challengeBtn:SimpleBitmapButton;
      
      private var _CDTimeBg:ScaleBitmapImage;
      
      private var _CDTimeTxt:FilterFrameText;
      
      private var _accelerateBtn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _help:BaseButton;
      
      private var _remainSecond:int;
      
      private var _curIndex:int;
      
      private var _cleanCDcount:int;
      
      private var _CDTimer:Timer;
      
      private var _infoDic:Dictionary;
      
      private var _curPage:int;
      
      private var _totalPage:int;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      public function RescueMainFrame()
      {
         super();
         initData();
         initView();
         initEvents();
      }
      
      private function initData() : void
      {
         _sceneArr = new Vector.<RescueSceneItem>();
         _prizeArr = new Vector.<RescuePrizeItem>();
         _infoDic = new Dictionary();
         SocketManager.Instance.out.requestRescueFrameInfo();
         SocketManager.Instance.out.requestRescueItemInfo();
         _CDTimer = new Timer(1000);
         _CDTimer.addEventListener("timer",__onCDTimer);
         _curPage = 1;
         _totalPage = 1;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var item2:* = null;
         var k:int = 0;
         var item3:* = null;
         titleText = LanguageMgr.GetTranslation("rescue.title");
         _bg = ComponentFactory.Instance.creat("rescue.bg");
         addToContent(_bg);
         _txtImg = ComponentFactory.Instance.creat("rescue.txtImg");
         addToContent(_txtImg);
         _arrowTxt = ComponentFactory.Instance.creatComponentByStylename("rescue.numTxt");
         PositionUtils.setPos(_arrowTxt,"rescue.arrowTxtPos");
         addToContent(_arrowTxt);
         _arrowTxt.text = "26";
         _bloodPackTxt = ComponentFactory.Instance.creatComponentByStylename("rescue.numTxt");
         PositionUtils.setPos(_bloodPackTxt,"rescue.bloodPackTxtPos");
         addToContent(_bloodPackTxt);
         _bloodPackTxt.text = "26";
         _kingBlessTxt = ComponentFactory.Instance.creatComponentByStylename("rescue.numTxt");
         PositionUtils.setPos(_kingBlessTxt,"rescue.kingBlessTxtPos");
         addToContent(_kingBlessTxt);
         _kingBlessTxt.text = "26";
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("rescue.challengeBtn");
         addToContent(_challengeBtn);
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("rescue.prevBtn");
         addToContent(_prevBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("rescue.nextBtn");
         addToContent(_nextBtn);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("rescue.pageBG");
         addToContent(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("rescue.pageTxt");
         addToContent(_pageTxt);
         _pageTxt.text = "1/2";
         _tileList = ComponentFactory.Instance.creat("rescue.tileList",[3]);
         addToContent(_tileList);
         for(i = 1; i <= 6; )
         {
            item = new RescueSceneItem();
            _tileList.addChild(item);
            _sceneArr.push(item);
            item.setData(false);
            i++;
         }
         _curIndex = 0;
         _sceneArr[0].setSelected(true);
         _shopVBox = ComponentFactory.Instance.creatComponentByStylename("rescue.shopVBox");
         addToContent(_shopVBox);
         for(j = 0; j <= 2; )
         {
            item2 = new RescueShopItem(j);
            _shopVBox.addChild(item2);
            j++;
         }
         _prizeHBox = ComponentFactory.Instance.creatComponentByStylename("rescue.prizeHBox");
         addToContent(_prizeHBox);
         for(k = 0; k <= 2; )
         {
            item3 = new RescuePrizeItem(k);
            _prizeHBox.addChild(item3);
            _prizeArr.push(item3);
            k++;
         }
         _CDTimeBg = ComponentFactory.Instance.creatComponentByStylename("rescue.cdTimeBg");
         _CDTimeTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         PositionUtils.setPos(_CDTimeTxt,"rescue.cdTimeTxtPos");
         _CDTimeTxt.text = "00:00:00";
         _accelerateBtn = ComponentFactory.Instance.creatComponentByStylename("rescue.accelerateBtn");
         addToContent(_CDTimeBg);
         addToContent(_CDTimeTxt);
         addToContent(_accelerateBtn);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("rescue.countTxt");
         addToContent(_countTxt);
         _countTxt.text = "(3)";
         _help = HelpFrameUtils.Instance.simpleHelpButton(this,"rescue.helpBtn",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),"rescue.helpTxt",504,484);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(277,7),__updateView);
         SocketManager.Instance.addEventListener(PkgEvent.format(277,2),__updateItem);
         SocketManager.Instance.addEventListener(PkgEvent.format(277,5),__cleanCD);
         SocketManager.Instance.addEventListener(PkgEvent.format(277,4),__buyItem);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         _challengeBtn.addEventListener("click",__challengeBtnClick);
         _accelerateBtn.addEventListener("click",__accelerateBtnClick);
         _prevBtn.addEventListener("click",__prevBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
      }
      
      protected function __prevBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_curPage > 1)
         {
            _curPage = Number(_curPage) - 1;
            pageChange();
         }
      }
      
      protected function __nextBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_curPage < _totalPage)
         {
            _curPage = Number(_curPage) + 1;
            pageChange();
         }
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __updateItem(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _arrowTxt.text = pkg.readInt().toString();
         _bloodPackTxt.text = pkg.readInt().toString();
         _kingBlessTxt.text = pkg.readInt().toString();
      }
      
      protected function __buyItem(event:PkgEvent) : void
      {
         SocketManager.Instance.out.requestRescueItemInfo();
      }
      
      protected function __cleanCD(event:PkgEvent) : void
      {
         SocketManager.Instance.out.requestRescueFrameInfo(_sceneArr[_curIndex].sceneId);
      }
      
      protected function __accelerateBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpNeedMoney:int = getNeedMoney();
         if(RescueControl.instance.isNoPrompt)
         {
            if(RescueControl.instance.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               RescueControl.instance.isNoPrompt = false;
            }
            else if(!RescueControl.instance.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               RescueControl.instance.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendRescueCleanCD(RescueControl.instance.isBand,_sceneArr[_curIndex].sceneId);
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("rescue.cleanCDtxt",getNeedMoney()),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"rescue.confirmView",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",comfirmHandler,false,0,true);
      }
      
      private function comfirmHandler(event:FrameEvent) : void
      {
         var tmpNeedMoney:int = 0;
         var confirmFrame2:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",comfirmHandler);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            tmpNeedMoney = getNeedMoney();
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as RescueConfirmView).isNoPrompt)
            {
               RescueControl.instance.isNoPrompt = true;
               RescueControl.instance.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendRescueCleanCD(confirmFrame.isBand,_sceneArr[_curIndex].sceneId);
         }
      }
      
      private function reConfirmHandler(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",reConfirmHandler);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needMoney = getNeedMoney();
            if(PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendRescueCleanCD(confirmFrame.isBand,_sceneArr[_curIndex].sceneId);
         }
      }
      
      private function getNeedMoney() : int
      {
         var i:int = 0;
         var arr:Array = ServerConfigManager.instance.rescueCleanCDPrice;
         var base:int = parseInt(arr[0]);
         var increase:int = parseInt(arr[1]);
         _cleanCDcount = 0;
         for(i = 0; i <= _sceneArr.length - 1; )
         {
            _cleanCDcount = _cleanCDcount + _sceneArr[i].info.cleanCDcount;
            i++;
         }
         return base + _cleanCDcount * increase;
      }
      
      protected function __challengeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendRescueChallenge(_sceneArr[_curIndex].sceneId);
      }
      
      protected function __updateView(event:PkgEvent) : void
      {
         var i:int = 0;
         var sceneId:int = 0;
         var info:* = null;
         var pkg:PackageIn = event.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i <= len - 1; )
         {
            sceneId = pkg.readInt();
            info = new RescueSceneInfo();
            info.starCount = pkg.readInt();
            info.rewardStatus = pkg.readInt();
            info.freeCount = pkg.readInt();
            info.remainSecond = pkg.readInt();
            info.cleanCDcount = pkg.readInt();
            _infoDic[sceneId] = info;
            updateSceneItem(sceneId,info);
            i++;
         }
         _remainSecond = _sceneArr[_curIndex].info.remainSecond;
         _CDTimeTxt.text = parseDate(_remainSecond);
         if(_remainSecond > 0)
         {
            _CDTimer.start();
         }
         updatePrize();
         _totalPage = getTotalPage();
         _pageTxt.text = _curPage + "/" + _totalPage;
      }
      
      private function getTotalPage() : int
      {
         var total:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _infoDic;
         for(var id in _infoDic)
         {
            total++;
         }
         return (total - 1) / 6 + 1;
      }
      
      private function pageChange() : void
      {
         var i:int = 0;
         _curIndex = 0;
         for(i = 0; i <= _sceneArr.length - 1; )
         {
            _sceneArr[i].removeEventListener("click",__itemClick);
            _sceneArr[i].buttonMode = false;
            _sceneArr[i].setData(false);
            _sceneArr[i].setSelected(false);
            i++;
         }
         _sceneArr[_curIndex].setSelected(true);
         var _loc4_:int = 0;
         var _loc3_:* = _infoDic;
         for(var sceneId in _infoDic)
         {
            updateSceneItem(parseInt(sceneId),_infoDic[sceneId]);
         }
         RescueControl.instance.curSceneId = _sceneArr[_curIndex].sceneId;
         _remainSecond = _sceneArr[_curIndex].info.remainSecond;
         _CDTimeTxt.text = parseDate(_remainSecond);
         if(_remainSecond > 0)
         {
            _CDTimer.start();
         }
         updatePrize();
         _pageTxt.text = _curPage + "/" + _totalPage;
      }
      
      private function updateSceneItem(sceneId:int, info:RescueSceneInfo) : void
      {
         var idx:int = 0;
         idx = sceneId - 1;
         idx = idx - (_curPage - 1) * 6;
         if(idx >= 0 && idx < 6)
         {
            _sceneArr[idx].removeEventListener("click",__itemClick);
            _sceneArr[idx].buttonMode = true;
            _sceneArr[idx].setData(true,sceneId,info);
            _sceneArr[idx].addEventListener("click",__itemClick);
         }
      }
      
      protected function __onCDTimer(event:TimerEvent) : void
      {
         if(_remainSecond < 0)
         {
            _CDTimer.stop();
            SocketManager.Instance.out.requestRescueFrameInfo(_sceneArr[_curIndex].sceneId);
            return;
         }
         _CDTimeTxt.text = parseDate(_remainSecond);
         _remainSecond = Number(_remainSecond) - 1;
      }
      
      private function parseDate(remain:int) : String
      {
         var s:int = remain % 60;
         remain = Math.floor(remain / 60);
         var m:int = remain % 60;
         remain = Math.floor(remain / 60);
         var h:int = remain % 60;
         var ss:String = s >= 10?s.toString():"0" + s;
         var mm:String = m >= 10?m.toString():"0" + m;
         var hh:String = h >= 10?h.toString():"0" + h;
         return hh + ":" + mm + ":" + ss;
      }
      
      protected function __itemClick(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         var item:RescueSceneItem = event.currentTarget as RescueSceneItem;
         for(i = 0; i <= _sceneArr.length - 1; )
         {
            if(item == _sceneArr[i])
            {
               _curIndex = i;
            }
            _sceneArr[i].setSelected(false);
            i++;
         }
         item.setSelected(true);
         RescueControl.instance.curSceneId = _sceneArr[_curIndex].sceneId;
         SocketManager.Instance.out.requestRescueFrameInfo(_sceneArr[_curIndex].sceneId);
      }
      
      private function updatePrize() : void
      {
         var i:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = RescueManager.instance.rewardArr;
         for each(var rewardInfo in RescueManager.instance.rewardArr)
         {
            if(rewardInfo.MissionID == _sceneArr[_curIndex].sceneId)
            {
               switch(int(rewardInfo.Star) - 11)
               {
                  case 0:
                     _prizeArr[0].setData(rewardInfo);
                     continue;
                  case 1:
                     _prizeArr[1].setData(rewardInfo);
                     continue;
                  case 2:
                     _prizeArr[2].setData(rewardInfo);
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         var status:* = int(_sceneArr[_curIndex].info.rewardStatus);
         for(i = 0; i <= _prizeArr.length - 1; )
         {
            _prizeArr[i].setStatus(status & 3);
            status = status >> 2;
            i++;
         }
         if(_sceneArr[_curIndex].info.freeCount > 0)
         {
            _countTxt.text = "(" + _sceneArr[_curIndex].info.freeCount + ")";
            _countTxt.visible = true;
         }
         else
         {
            _countTxt.visible = false;
         }
         if(_sceneArr[_curIndex].info.freeCount > 0 || _remainSecond <= 0)
         {
            _challengeBtn.enable = true;
         }
         else
         {
            _challengeBtn.enable = false;
         }
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(277,7),__updateView);
         SocketManager.Instance.removeEventListener(PkgEvent.format(277,2),__updateItem);
         SocketManager.Instance.removeEventListener(PkgEvent.format(277,5),__cleanCD);
         SocketManager.Instance.removeEventListener(PkgEvent.format(277,4),__buyItem);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         _challengeBtn.removeEventListener("click",__challengeBtnClick);
         _accelerateBtn.removeEventListener("click",__accelerateBtnClick);
         _prevBtn.removeEventListener("click",__prevBtnClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
         _CDTimer.stop();
         _CDTimer.removeEventListener("timer",__onCDTimer);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         removeEvents();
         for(i = 0; i <= _sceneArr.length - 1; )
         {
            ObjectUtils.disposeObject(_sceneArr[i]);
            _sceneArr[i] = null;
            i++;
         }
         for(j = 0; j <= _prizeArr.length - 1; )
         {
            ObjectUtils.disposeObject(_prizeArr[j]);
            _prizeArr[j] = null;
            j++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tileList);
         _tileList = null;
         ObjectUtils.disposeObject(_txtImg);
         _txtImg = null;
         ObjectUtils.disposeObject(_arrowTxt);
         _arrowTxt = null;
         ObjectUtils.disposeObject(_bloodPackTxt);
         _bloodPackTxt = null;
         ObjectUtils.disposeObject(_kingBlessTxt);
         _kingBlessTxt = null;
         ObjectUtils.disposeObject(_shopVBox);
         _shopVBox = null;
         ObjectUtils.disposeObject(_prizeHBox);
         _prizeHBox = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_CDTimeBg);
         _CDTimeBg = null;
         ObjectUtils.disposeObject(_CDTimeTxt);
         _CDTimeTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_accelerateBtn);
         _accelerateBtn = null;
         ObjectUtils.disposeObject(_help);
         _help = null;
         ObjectUtils.disposeObject(_prevBtn);
         _prevBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         super.dispose();
      }
   }
}
