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
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
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
         _loc6_ = 1;
         while(_loc6_ <= 6)
         {
            _loc3_ = new RescueSceneItem();
            _tileList.addChild(_loc3_);
            _sceneArr.push(_loc3_);
            _loc3_.setData(false);
            _loc6_++;
         }
         _curIndex = 0;
         _sceneArr[0].setSelected(true);
         _shopVBox = ComponentFactory.Instance.creatComponentByStylename("rescue.shopVBox");
         addToContent(_shopVBox);
         _loc4_ = 0;
         while(_loc4_ <= 2)
         {
            _loc1_ = new RescueShopItem(_loc4_);
            _shopVBox.addChild(_loc1_);
            _loc4_++;
         }
         _prizeHBox = ComponentFactory.Instance.creatComponentByStylename("rescue.prizeHBox");
         addToContent(_prizeHBox);
         _loc5_ = 0;
         while(_loc5_ <= 2)
         {
            _loc2_ = new RescuePrizeItem(_loc5_);
            _prizeHBox.addChild(_loc2_);
            _prizeArr.push(_loc2_);
            _loc5_++;
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
      
      protected function __prevBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_curPage > 1)
         {
            _curPage = Number(_curPage) - 1;
            pageChange();
         }
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_curPage < _totalPage)
         {
            _curPage = Number(_curPage) + 1;
            pageChange();
         }
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      protected function __updateItem(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _arrowTxt.text = _loc2_.readInt().toString();
         _bloodPackTxt.text = _loc2_.readInt().toString();
         _kingBlessTxt.text = _loc2_.readInt().toString();
      }
      
      protected function __buyItem(param1:PkgEvent) : void
      {
         SocketManager.Instance.out.requestRescueItemInfo();
      }
      
      protected function __cleanCD(param1:PkgEvent) : void
      {
         SocketManager.Instance.out.requestRescueFrameInfo(_sceneArr[_curIndex].sceneId);
      }
      
      protected function __accelerateBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = getNeedMoney();
         if(RescueControl.instance.isNoPrompt)
         {
            if(RescueControl.instance.isBand && PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               RescueControl.instance.isNoPrompt = false;
            }
            else if(!RescueControl.instance.isBand && PlayerManager.Instance.Self.Money < _loc2_)
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
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("rescue.cleanCDtxt",getNeedMoney()),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"rescue.confirmView",30,true,1);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",comfirmHandler,false,0,true);
      }
      
      private function comfirmHandler(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",comfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc3_ = getNeedMoney();
            if(_loc4_.isBand && PlayerManager.Instance.Self.BandMoney < _loc3_)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!_loc4_.isBand && PlayerManager.Instance.Self.Money < _loc3_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc4_ as RescueConfirmView).isNoPrompt)
            {
               RescueControl.instance.isNoPrompt = true;
               RescueControl.instance.isBand = _loc4_.isBand;
            }
            SocketManager.Instance.out.sendRescueCleanCD(_loc4_.isBand,_sceneArr[_curIndex].sceneId);
         }
      }
      
      private function reConfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",reConfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = getNeedMoney();
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendRescueCleanCD(_loc3_.isBand,_sceneArr[_curIndex].sceneId);
         }
      }
      
      private function getNeedMoney() : int
      {
         var _loc4_:int = 0;
         var _loc1_:Array = ServerConfigManager.instance.rescueCleanCDPrice;
         var _loc2_:int = parseInt(_loc1_[0]);
         var _loc3_:int = parseInt(_loc1_[1]);
         _cleanCDcount = 0;
         _loc4_ = 0;
         while(_loc4_ <= _sceneArr.length - 1)
         {
            _cleanCDcount = _cleanCDcount + _sceneArr[_loc4_].info.cleanCDcount;
            _loc4_++;
         }
         return _loc2_ + _cleanCDcount * _loc3_;
      }
      
      protected function __challengeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendRescueChallenge(_sceneArr[_curIndex].sceneId);
      }
      
      protected function __updateView(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ <= _loc4_ - 1)
         {
            _loc2_ = _loc3_.readInt();
            _loc5_ = new RescueSceneInfo();
            _loc5_.starCount = _loc3_.readInt();
            _loc5_.rewardStatus = _loc3_.readInt();
            _loc5_.freeCount = _loc3_.readInt();
            _loc5_.remainSecond = _loc3_.readInt();
            _loc5_.cleanCDcount = _loc3_.readInt();
            _infoDic[_loc2_] = _loc5_;
            updateSceneItem(_loc2_,_loc5_);
            _loc6_++;
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
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _infoDic;
         for(var _loc1_ in _infoDic)
         {
            _loc2_++;
         }
         return (_loc2_ - 1) / 6 + 1;
      }
      
      private function pageChange() : void
      {
         var _loc2_:int = 0;
         _curIndex = 0;
         _loc2_ = 0;
         while(_loc2_ <= _sceneArr.length - 1)
         {
            _sceneArr[_loc2_].removeEventListener("click",__itemClick);
            _sceneArr[_loc2_].buttonMode = false;
            _sceneArr[_loc2_].setData(false);
            _sceneArr[_loc2_].setSelected(false);
            _loc2_++;
         }
         _sceneArr[_curIndex].setSelected(true);
         var _loc4_:int = 0;
         var _loc3_:* = _infoDic;
         for(var _loc1_ in _infoDic)
         {
            updateSceneItem(parseInt(_loc1_),_infoDic[_loc1_]);
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
      
      private function updateSceneItem(param1:int, param2:RescueSceneInfo) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param1 - 1;
         _loc3_ = _loc3_ - (_curPage - 1) * 6;
         if(_loc3_ >= 0 && _loc3_ < 6)
         {
            _sceneArr[_loc3_].removeEventListener("click",__itemClick);
            _sceneArr[_loc3_].buttonMode = true;
            _sceneArr[_loc3_].setData(true,param1,param2);
            _sceneArr[_loc3_].addEventListener("click",__itemClick);
         }
      }
      
      protected function __onCDTimer(param1:TimerEvent) : void
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
      
      private function parseDate(param1:int) : String
      {
         var _loc3_:int = param1 % 60;
         param1 = Math.floor(param1 / 60);
         var _loc6_:int = param1 % 60;
         param1 = Math.floor(param1 / 60);
         var _loc7_:int = param1 % 60;
         var _loc5_:String = _loc3_ >= 10?_loc3_.toString():"0" + _loc3_;
         var _loc2_:String = _loc6_ >= 10?_loc6_.toString():"0" + _loc6_;
         var _loc4_:String = _loc7_ >= 10?_loc7_.toString():"0" + _loc7_;
         return _loc4_ + ":" + _loc2_ + ":" + _loc5_;
      }
      
      protected function __itemClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         var _loc2_:RescueSceneItem = param1.currentTarget as RescueSceneItem;
         _loc3_ = 0;
         while(_loc3_ <= _sceneArr.length - 1)
         {
            if(_loc2_ == _sceneArr[_loc3_])
            {
               _curIndex = _loc3_;
            }
            _sceneArr[_loc3_].setSelected(false);
            _loc3_++;
         }
         _loc2_.setSelected(true);
         RescueControl.instance.curSceneId = _sceneArr[_curIndex].sceneId;
         SocketManager.Instance.out.requestRescueFrameInfo(_sceneArr[_curIndex].sceneId);
      }
      
      private function updatePrize() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = RescueManager.instance.rewardArr;
         for each(var _loc1_ in RescueManager.instance.rewardArr)
         {
            if(_loc1_.MissionID == _sceneArr[_curIndex].sceneId)
            {
               switch(int(_loc1_.Star) - 11)
               {
                  case 0:
                     _prizeArr[0].setData(_loc1_);
                     continue;
                  case 1:
                     _prizeArr[1].setData(_loc1_);
                     continue;
                  case 2:
                     _prizeArr[2].setData(_loc1_);
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         var _loc2_:* = int(_sceneArr[_curIndex].info.rewardStatus);
         _loc3_ = 0;
         while(_loc3_ <= _prizeArr.length - 1)
         {
            _prizeArr[_loc3_].setStatus(_loc2_ & 3);
            _loc2_ = _loc2_ >> 2;
            _loc3_++;
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
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         removeEvents();
         _loc2_ = 0;
         while(_loc2_ <= _sceneArr.length - 1)
         {
            ObjectUtils.disposeObject(_sceneArr[_loc2_]);
            _sceneArr[_loc2_] = null;
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ <= _prizeArr.length - 1)
         {
            ObjectUtils.disposeObject(_prizeArr[_loc1_]);
            _prizeArr[_loc1_] = null;
            _loc1_++;
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
