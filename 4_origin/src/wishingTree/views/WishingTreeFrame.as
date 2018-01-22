package wishingTree.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import wishingTree.components.PrizeAlterContainer;
   import wishingTree.components.PrizeDropList;
   import wishingTree.components.WishingTreeItem;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class WishingTreeFrame extends Frame
   {
      
      private static const WISHING_CARD:int = 12502;
       
      
      private var _bg:Bitmap;
      
      private var _treeImg:Bitmap;
      
      private var _wishBtn:SimpleBitmapButton;
      
      private var _prizeDisplay:PrizeDropList;
      
      private var _border:Bitmap;
      
      private var _recordBtn:SimpleBitmapButton;
      
      private var _wishingCardCount:FilterFrameText;
      
      private var _wishingTimes:FilterFrameText;
      
      private var _remainDate:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemArr:Vector.<WishingTreeItem>;
      
      private var _glowMc:MovieClip;
      
      private var _alertContainer:PrizeAlterContainer;
      
      private var _mask:Sprite;
      
      private var _itemTxtArr:Array;
      
      private var _btnHelp:SimpleBitmapButton;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var completeCount:int = 0;
      
      public function WishingTreeFrame()
      {
         super();
         initView();
         addEvents();
         initTimer();
         SocketManager.Instance.out.wishingTreeUpdateFrame();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         titleText = LanguageMgr.GetTranslation("wishingTree.title");
         _bg = ComponentFactory.Instance.creat("wishingTree.bg");
         addToContent(_bg);
         _treeImg = ComponentFactory.Instance.creat("wishingTree.tree");
         addToContent(_treeImg);
         _prizeDisplay = new PrizeDropList();
         PositionUtils.setPos(_prizeDisplay,"wishingTree.dropListPos");
         addToContent(_prizeDisplay);
         _prizeDisplay.info = ServerConfigManager.instance.getWishingTreeDisplayRewards();
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("wishingTree.inputBg");
         addToContent(_inputBg);
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("wishingTree.inputTxt");
         _inputTxt.text = "1";
         _inputTxt.restrict = "0-9";
         addToContent(_inputTxt);
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("wishingTree.maxBtn");
         addToContent(_maxBtn);
         _wishBtn = ComponentFactory.Instance.creatComponentByStylename("wishingTree.wishBtn");
         addToContent(_wishBtn);
         _border = ComponentFactory.Instance.creat("wishingTree.border");
         addToContent(_border);
         _recordBtn = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordBtn");
         addToContent(_recordBtn);
         _wishingCardCount = ComponentFactory.Instance.creatComponentByStylename("wishingTree.cardCount");
         addToContent(_wishingCardCount);
         var _loc2_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12502);
         _wishingCardCount.text = LanguageMgr.GetTranslation("wishingTree.cardCount",_loc2_);
         _wishingTimes = ComponentFactory.Instance.creatComponentByStylename("wishingTree.wishingTimes");
         addToContent(_wishingTimes);
         _wishingTimes.text = LanguageMgr.GetTranslation("wishingTree.wishingTimes",0);
         _remainDate = ComponentFactory.Instance.creatComponentByStylename("wishingTree.remainDate");
         addToContent(_remainDate);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("wishingTree.vbox");
         addToContent(_vBox);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall","wishingTreeFrame.helpBtnPos",LanguageMgr.GetTranslation("store.view.HelpButtonText"),"wishingTree.helpText",408,488);
         var _loc5_:Array = ServerConfigManager.instance.getWishingTreeAccRewards();
         _itemArr = new Vector.<WishingTreeItem>();
         _loc7_ = 0;
         while(_loc7_ <= _loc5_.length - 1)
         {
            _loc3_ = _loc5_[_loc7_].split(",");
            _loc1_ = _loc3_[0];
            _loc6_ = _loc3_[1];
            _loc4_ = new WishingTreeItem(_loc7_,_loc1_,_loc6_);
            _vBox.addChild(_loc4_);
            _itemArr.push(_loc4_);
            _loc7_++;
         }
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         _wishBtn.addEventListener("click",__wishBtnClick);
         _recordBtn.addEventListener("click",__recordBtnClick);
         _prizeDisplay.addEventListener("large",__dropListLarge);
         _prizeDisplay.addEventListener("small",__dropListSmall);
         SocketManager.Instance.addEventListener(PkgEvent.format(299,3),__wishResultHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(299,2),__updateFrameInfo);
         _inputTxt.addEventListener("change",__inputChange);
         _maxBtn.addEventListener("click",__maxBtnClick);
      }
      
      private function initTimer() : void
      {
         timerHandler();
         WonderfulActivityManager.Instance.addTimerFun("wishingTree",timerHandler);
      }
      
      private function timerHandler() : void
      {
         var _loc3_:Date = DateUtils.getDateByStr(ServerConfigManager.instance.getWishingTreeEndDate());
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:String = WonderfulActivityManager.Instance.getTimeDiff(_loc3_,_loc2_);
         if(_remainDate)
         {
            _remainDate.text = LanguageMgr.GetTranslation("wishingTree.remainDate",_loc1_);
         }
         if(_loc1_ == "0")
         {
            WonderfulActivityManager.Instance.delTimerFun("wishingTree");
         }
      }
      
      protected function __wishResultHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:Boolean = _loc3_.readBoolean();
         var _loc2_:String = _loc3_.readUTF();
         playMC(_loc4_,_loc2_);
      }
      
      protected function __dropListSmall(param1:Event) : void
      {
         _prizeDisplay.y = 312;
         _container.swapChildren(_wishBtn,_prizeDisplay);
      }
      
      protected function __dropListLarge(param1:Event) : void
      {
         _prizeDisplay.y = 254;
         _container.swapChildren(_wishBtn,_prizeDisplay);
      }
      
      protected function __updateFrameInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         var _loc4_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ <= _itemArr.length - 1)
         {
            _itemArr[_loc6_].setState(_loc3_,_loc4_);
            _loc6_++;
         }
         var _loc2_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12502);
         _wishingCardCount.text = LanguageMgr.GetTranslation("wishingTree.cardCount",_loc2_);
         _wishingTimes.text = LanguageMgr.GetTranslation("wishingTree.wishingTimes",_loc3_);
      }
      
      protected function __recordBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:WishingTreeRecordFrame = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordframe");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1,true);
      }
      
      protected function __wishBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _wishBtn.enable = false;
         var _loc3_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12502);
         var _loc2_:int = parseInt(_inputTxt.text);
         if(_loc2_ <= 0)
         {
            _wishBtn.enable = true;
            return;
         }
         if(_loc3_ > 0)
         {
            SocketManager.Instance.out.wishingTreeSendWish(_loc2_);
         }
         else
         {
            playMC(false);
         }
      }
      
      private function playMC(param1:Boolean, param2:String = "") : void
      {
         var _loc3_:int = 0;
         addMask();
         if(param1)
         {
            _glowMc = ComponentFactory.Instance.creat("wishingTree.mc");
            PositionUtils.setPos(_glowMc,"wishingTree.mcPos");
            addToContent(_glowMc);
            _container.swapChildren(_wishBtn,_glowMc);
            _glowMc.addEventListener("enterFrame",__mcEnterFrame);
            _itemTxtArr = param2.split("|");
            _loc3_ = 0;
            while(_loc3_ <= _itemTxtArr.length - 1)
            {
               if(_itemTxtArr[_loc3_])
               {
                  _alertContainer = new PrizeAlterContainer();
                  PositionUtils.setPos(_alertContainer,"wishingTree.spritePos");
                  _alertContainer.show(true,_itemTxtArr[_loc3_],0.2 * _loc3_);
                  _alertContainer.addEventListener("complete",__alterContainerComplete);
                  addToContent(_alertContainer);
                  completeCount = Number(completeCount) + 1;
               }
               _loc3_++;
            }
         }
         else
         {
            _alertContainer = new PrizeAlterContainer();
            PositionUtils.setPos(_alertContainer,"wishingTree.spritePos");
            _alertContainer.show(false);
            _alertContainer.addEventListener("complete",__alterContainerComplete);
            addToContent(_alertContainer);
            completeCount = Number(completeCount) + 1;
         }
      }
      
      protected function __alterContainerComplete(param1:Event) : void
      {
         var _loc2_:PrizeAlterContainer = param1.target as PrizeAlterContainer;
         _loc2_.removeEventListener("complete",__alterContainerComplete);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         completeCount = Number(completeCount) - 1;
         if(completeCount <= 0)
         {
            alertComplete();
         }
      }
      
      private function alertComplete() : void
      {
         removeMask();
         _wishBtn.enable = true;
      }
      
      protected function __mcEnterFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener("enterFrame",__mcEnterFrame);
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
      }
      
      private function addMask() : void
      {
         if(_mask == null)
         {
            _mask = new Sprite();
            _mask.graphics.beginFill(0,0);
            _mask.graphics.drawRect(0,0,2000,1200);
            _mask.graphics.endFill();
         }
         LayerManager.Instance.addToLayer(_mask,3,false,2);
      }
      
      private function removeMask() : void
      {
         if(_mask != null)
         {
            _mask.parent.removeChild(_mask);
            _mask = null;
         }
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      protected function __maxBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12502);
         if(_loc2_ <= 0)
         {
            _loc2_ = 1;
         }
         else if(_loc2_ > 99)
         {
            _loc2_ = 99;
         }
         _inputTxt.text = _loc2_.toString();
      }
      
      protected function __inputChange(param1:Event) : void
      {
         var _loc3_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12502);
         var _loc2_:int = parseInt(_inputTxt.text);
         if(_loc2_ <= 0)
         {
            _inputTxt.text = "1";
         }
         else if(_loc2_ > _loc3_)
         {
            _inputTxt.text = _loc3_.toString();
         }
         if(parseInt(_inputTxt.text) <= 0)
         {
            _inputTxt.text = "1";
         }
         else if(parseInt(_inputTxt.text) > 99)
         {
            _inputTxt.text = "99";
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         _wishBtn.removeEventListener("click",__wishBtnClick);
         _recordBtn.removeEventListener("click",__recordBtnClick);
         _prizeDisplay.removeEventListener("large",__dropListLarge);
         _prizeDisplay.removeEventListener("small",__dropListSmall);
         SocketManager.Instance.removeEventListener(PkgEvent.format(299,3),__wishResultHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(299,2),__updateFrameInfo);
         if(_glowMc)
         {
            _glowMc.removeEventListener("enterFrame",__mcEnterFrame);
         }
         _inputTxt.removeEventListener("change",__inputChange);
         _maxBtn.removeEventListener("click",__maxBtnClick);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         WonderfulActivityManager.Instance.delTimerFun("wishingTree");
         removeEvents();
         _loc1_ = 0;
         while(_loc1_ <= _itemArr.length - 1)
         {
            ObjectUtils.disposeObject(_itemArr[_loc1_]);
            _itemArr[_loc1_] = null;
            _loc1_++;
         }
         _itemArr = null;
         _btnHelp = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_treeImg);
         _treeImg = null;
         ObjectUtils.disposeObject(_wishBtn);
         _wishBtn = null;
         ObjectUtils.disposeObject(_prizeDisplay);
         _prizeDisplay = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_recordBtn);
         _recordBtn = null;
         ObjectUtils.disposeObject(_wishingCardCount);
         _wishingCardCount = null;
         ObjectUtils.disposeObject(_wishingTimes);
         _wishingTimes = null;
         ObjectUtils.disposeObject(_remainDate);
         _remainDate = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_glowMc);
         _glowMc = null;
         ObjectUtils.disposeObject(_alertContainer);
         _alertContainer = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         super.dispose();
      }
   }
}
