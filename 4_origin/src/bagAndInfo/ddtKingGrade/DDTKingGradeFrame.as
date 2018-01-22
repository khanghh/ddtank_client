package bagAndInfo.ddtKingGrade
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.utils.MovieClipWrapper;
   
   public class DDTKingGradeFrame extends Frame
   {
       
      
      private var _viewBg:Bitmap;
      
      private var _viewTitle:Bitmap;
      
      private var _propertyVBox:VBox;
      
      private var _propertyTextList:Vector.<FilterFrameText>;
      
      private var _usableNumText:FilterFrameText;
      
      private var _usableNum:int = 0;
      
      private var _currentExp:Number;
      
      private var _nextExp:Number;
      
      private var _tipsText:FilterFrameText;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _allBtn:SimpleBitmapButton;
      
      private var _breakBtn:MovieClip;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _rotateBg:MovieClipWrapper;
      
      private var _progress:MovieClip;
      
      private var _progressText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _progressTips:Component;
      
      private var _btnHelp:BaseButton;
      
      private var _currentButton:DDTKingGradeSelectedButton;
      
      private var _currentTime:int;
      
      public function DDTKingGradeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"coreii.helpBtn",{
            "x":539,
            "y":5
         },LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),"asset.ddtKingGrade.helpContent",408,488);
         _viewBg = ComponentFactory.Instance.creatBitmap("asset.ddtKingGrade.viewBg");
         _viewTitle = ComponentFactory.Instance.creatBitmap("asset.ddtKingGrade.viewTitle");
         _propertyVBox = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.vBox");
         _usableNumText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.usableNumText");
         _tipsText = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.propertyTipsText");
         _tipsText.text = LanguageMgr.GetTranslation("tank.ddtkingGrade.tips");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.resetBtn");
         _allBtn = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.allBtn");
         _breakBtn = ComponentFactory.Instance.creat("asset.ddtKingGrade.break");
         _breakBtn.buttonMode = true;
         PositionUtils.setPos(_breakBtn,"ddtKingGrade.breakBtnPos");
         _rotateBg = new MovieClipWrapper(ComponentFactory.Instance.creat("asset.ddtKingGrade.rotateBg"));
         PositionUtils.setPos(_rotateBg.movie,"ddtKingGrade.rotateBgPos");
         _propertyTextList = new Vector.<FilterFrameText>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ddtkinggrade.propertyText");
            _propertyVBox.addChild(_loc1_);
            _propertyTextList.push(_loc1_);
            _loc2_++;
         }
         addToContent(_viewBg);
         addToContent(_viewTitle);
         addToContent(_propertyVBox);
         addToContent(_usableNumText);
         addToContent(_tipsText);
         addToContent(_rotateBg.movie);
         addToContent(_resetBtn);
         addToContent(_allBtn);
         addToContent(_breakBtn);
         _btnGroup = new SelectedButtonGroup();
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.attackButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.defenceButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.agilityButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.luckButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.mAttackButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _currentButton = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.mDefendButton");
         _btnGroup.addSelectItem(_currentButton);
         addToContent(_currentButton);
         _btnGroup.selectIndex = -1;
         _progress = ComponentFactory.Instance.creat("asset.ddtKingGrade.progress");
         _progress.mouseChildren = false;
         PositionUtils.setPos(_progress,"ddtKingGrade.progressPos");
         addToContent(_progress);
         _progressText = ComponentFactory.Instance.creat("ddtKingGrade.progressText");
         addToContent(_progressText);
         _gradeText = ComponentFactory.Instance.creat("ddtKingGrade.gradeText");
         _gradeText.text = LanguageMgr.GetTranslation("ddtKingGrade.grade",PlayerManager.Instance.Self.ddtKingGrade);
         addToContent(_gradeText);
         _progressTips = ComponentFactory.Instance.creatComponentByStylename("ddtKingGrade.progressTips");
         _progressTips.graphics.beginFill(0,0);
         _progressTips.graphics.drawRect(0,0,290,20);
         _progressTips.graphics.endFill();
         addToContent(_progressTips);
         _progressTips.tipData = "0/0";
         _currentButton = null;
         updateView();
      }
      
      private function __onBreak(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.break"));
            playAction();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.breakFail"));
         }
      }
      
      private function __onUpdateInfo(param1:PkgEvent) : void
      {
         var _loc4_:* = NaN;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         _usableNum = param1.pkg.readInt();
         _currentExp = param1.pkg.readLong();
         _nextExp = param1.pkg.readLong();
         _progressTips.tipData = _currentExp + "/" + _nextExp;
         if(_nextExp > 0)
         {
            _loc4_ = Number(Math.floor(_currentExp / _nextExp * 10000) / 100);
         }
         else
         {
            _loc4_ = 0;
         }
         _progressText.text = _loc4_ + "%";
         _gradeText.text = LanguageMgr.GetTranslation("ddtKingGrade.grade",PlayerManager.Instance.Self.ddtKingGrade);
         _progress.gotoAndStop(int(_loc4_));
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            _loc3_ = _btnGroup.getItemByIndex(_loc6_) as DDTKingGradeSelectedButton;
            _loc5_ = param1.pkg.readInt();
            _loc3_.cost = _loc5_;
            _loc3_.tipData = {
               "cost":_loc5_,
               "currentCost":_usableNum,
               "type":_loc6_
            };
            _loc2_ = param1.pkg.readInt() / 10;
            _propertyTextList[_loc6_].text = _loc2_ + "%";
            _loc6_++;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         _usableNumText.text = LanguageMgr.GetTranslation("tank.ddtkingGrade.usableNum",_usableNum);
      }
      
      public function playAction() : void
      {
         _rotateBg.movie.visible = true;
         _rotateBg.gotoAndPlay(1);
         if(_currentButton)
         {
            _currentButton.playAction();
         }
      }
      
      private function __onPlayActionComplete(param1:Event) : void
      {
         _rotateBg.movie.visible = false;
      }
      
      private function __onClickReset(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_btnGroup.selectIndex == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.selectReset"));
            return;
         }
         if(_currentButton && _currentButton.level <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.propertyNotReset"));
            return;
         }
         var _loc3_:Array = ["attack","defence","agility","luck","magicAttack","magicDefend"];
         var _loc4_:String = LanguageMgr.GetTranslation(_loc3_[_btnGroup.selectIndex]);
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddtKingGrade.reset",ServerConfigManager.instance.maxLevelResetCost,_loc4_),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _loc2_.addEventListener("response",__onReset);
      }
      
      private function __onReset(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onReset);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,ServerConfigManager.instance.maxLevelResetCost,function():void
            {
               SocketManager.Instance.out.sendDDTKingGradeReset(false,_btnGroup.selectIndex + 1);
            });
         }
      }
      
      private function __onClickAllReset(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc4_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _btnGroup.length())
         {
            _loc3_ = _btnGroup.getItemByIndex(_loc5_) as DDTKingGradeSelectedButton;
            if(_loc3_.level > 0)
            {
               _loc4_ = true;
               break;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddtKingGrade.allReset",ServerConfigManager.instance.maxLevelAllResetCost),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
            _loc2_.addEventListener("response",__onAllReset);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.allNotReset"));
         }
      }
      
      private function __onAllReset(param1:FrameEvent) : void
      {
         e = param1;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onAllReset);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,ServerConfigManager.instance.maxLevelAllResetCost,function():void
            {
               SocketManager.Instance.out.sendDDTKingGradeReset(true,_btnGroup.selectIndex + 1);
            });
         }
      }
      
      private function __onClickBreak(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(getTimer() - _currentTime < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _currentTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_btnGroup.selectIndex == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.selectBreak"));
            return;
         }
         var _loc2_:DDTKingGradeInfo = DDTKingGradeManager.Instance.data[_currentButton.level + 1];
         if(_loc2_ == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.maxProperty"));
            return;
         }
         if(_usableNum + _currentButton.cost < _loc2_.Cost)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKingGrade.breakTip"));
            return;
         }
         SocketManager.Instance.out.sendDDTKingGradeUp(_btnGroup.selectIndex + 1);
      }
      
      private function __onButtonChange(param1:Event) : void
      {
         _currentButton = _btnGroup.getItemByIndex(_btnGroup.selectIndex) as DDTKingGradeSelectedButton;
      }
      
      public function show() : void
      {
         SocketManager.Instance.out.sendDDTKingGradeInfo();
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         _resetBtn.addEventListener("click",__onClickReset);
         _allBtn.addEventListener("click",__onClickAllReset);
         _breakBtn.addEventListener("click",__onClickBreak);
         _rotateBg.addEventListener("complete",__onPlayActionComplete);
         _btnGroup.addEventListener("change",__onButtonChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(370,3),__onUpdateInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(370,1),__onBreak);
      }
      
      private function removeEvent() : void
      {
         _resetBtn.removeEventListener("click",__onClickReset);
         _allBtn.removeEventListener("click",__onClickAllReset);
         _breakBtn.removeEventListener("click",__onClickBreak);
         _rotateBg.removeEventListener("complete",__onPlayActionComplete);
         _btnGroup.removeEventListener("change",__onButtonChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(370,3),__onUpdateInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(370,1),__onBreak);
      }
      
      override protected function onResponse(param1:int) : void
      {
         DDTKingGradeManager.Instance.isOpen = false;
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_btnHelp)
         {
            ObjectUtils.disposeObject(_btnHelp);
         }
         _btnHelp = null;
         removeEvent();
         _propertyTextList.splice(0,_propertyTextList.length);
         ObjectUtils.disposeObject(_propertyVBox);
         ObjectUtils.disposeObject(_btnGroup);
         ObjectUtils.disposeObject(_rotateBg);
         ObjectUtils.disposeObject(_progress);
         ObjectUtils.disposeObject(_progressText);
         ObjectUtils.disposeObject(_gradeText);
         super.dispose();
         _gradeText = null;
         _progressText = null;
         _propertyTextList = null;
         _progress = null;
         _btnGroup = null;
         _resetBtn = null;
         _allBtn = null;
         _breakBtn = null;
         _propertyVBox = null;
         _viewBg = null;
         _viewTitle = null;
         _rotateBg = null;
      }
   }
}
