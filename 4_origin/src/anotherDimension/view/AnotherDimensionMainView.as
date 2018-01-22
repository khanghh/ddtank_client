package anotherDimension.view
{
   import anotherDimension.AnotherDimensionControl;
   import anotherDimension.controller.AnotherDimensionManager;
   import anotherDimension.model.AnotherDimensionInfo;
   import anotherDimension.model.AnotherDimensionMsgInfo;
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class AnotherDimensionMainView extends Frame
   {
       
      
      private var _helpBnt:BaseButton;
      
      private var _bg:Bitmap;
      
      private var _searchBnt:BaseButton;
      
      private var _helpBnt2:BaseButton;
      
      private var _closeBnt:BaseButton;
      
      private var _downBg:Bitmap;
      
      private var _canZhanlingTxt:FilterFrameText;
      
      private var _canLueduoTxt:FilterFrameText;
      
      private var _canZhanlingCountTxt:FilterFrameText;
      
      private var _canLueduoCountTxt:FilterFrameText;
      
      private var _shijiankongzhiSelect:SelectedCheckButton;
      
      private var _kongjianzhangwoSelect:SelectedCheckButton;
      
      private var _lueduodashiSelect:SelectedCheckButton;
      
      private var _shijiankongzhiTxt:FilterFrameText;
      
      private var _kongjianzhangwoTxt:FilterFrameText;
      
      private var _lueduodashiTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _itemCell:AnotherDimensionItemCell;
      
      private var _upGradeBnt:BaseButton;
      
      private var _allInSelect:SelectedCheckButton;
      
      private var _progress:AnotherDimensionProgress;
      
      private var _type:int = 1;
      
      private var oneItemExp:int = 10;
      
      private var otherItemArr:Array;
      
      private var selfItemArr:Array;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var alert:BaseAlerFrame;
      
      private var timeLvMax:Boolean = false;
      
      private var spaceLvMax:Boolean = false;
      
      private var lootLvMax:Boolean = false;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function AnotherDimensionMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("anotherDimension.mainBg");
         _searchBnt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.searchBnt");
         _helpBnt2 = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.helpBnt");
         _closeBnt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.closeBnt");
         _downBg = ComponentFactory.Instance.creat("anotherDimension.zhanling");
         _canZhanlingTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.canZhanlingTxt");
         _canLueduoTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.canLueduoTxt");
         _canZhanlingCountTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.canZhanlingCountTxt");
         _canLueduoCountTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.canLueduoCountTxt");
         _canZhanlingTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensioncanZhanlingTxt");
         _canLueduoTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensioncanLueduoTxt");
         var _loc1_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalOccupyCount;
         var _loc3_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.occupyCount;
         var _loc2_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalLootCount;
         var _loc4_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.lootCount;
         _canZhanlingCountTxt.text = _loc1_ - _loc3_ + "";
         _canLueduoCountTxt.text = _loc2_ - _loc4_ + "";
         addToContent(_bg);
         addToContent(_searchBnt);
         addToContent(_helpBnt2);
         addToContent(_closeBnt);
         addToContent(_downBg);
         addToContent(_canZhanlingTxt);
         addToContent(_canLueduoTxt);
         addToContent(_canZhanlingCountTxt);
         addToContent(_canLueduoCountTxt);
         otherItemArr = [];
         selfItemArr = [];
         setResourceData();
         addSelectionBnt();
         addMsgView();
      }
      
      public function setResourceData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc10_:int = 0;
         var _loc4_:* = null;
         var _loc12_:int = 0;
         var _loc11_:* = null;
         var _loc1_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc5_:Array = AnotherDimensionManager.Instance.resourceList;
         var _loc6_:Array = AnotherDimensionManager.Instance.haveResourceList;
         if(otherItemArr && otherItemArr.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < otherItemArr.length)
            {
               _loc3_ = otherItemArr[_loc2_] as AnotherDimensionOtherItemView;
               _loc3_.dispose();
               _loc3_ = null;
               _loc2_++;
            }
         }
         if(selfItemArr && selfItemArr.length > 0)
         {
            _loc10_ = 0;
            while(_loc10_ < selfItemArr.length)
            {
               _loc4_ = selfItemArr[_loc10_] as AnotherDimensionSelfItemView;
               _loc4_.dispose();
               _loc4_ = null;
               _loc10_++;
            }
         }
         otherItemArr = [];
         selfItemArr = [];
         _loc12_ = 0;
         while(_loc12_ < _loc5_.length)
         {
            _loc11_ = _loc5_[_loc12_] as AnotherDimensionResourceInfo;
            _loc1_ = new AnotherDimensionOtherItemView(_loc11_);
            PositionUtils.setPos(_loc1_,"anotherDimension.anotherDimension.anotherPos" + _loc11_.resourcePos);
            addToContent(_loc1_);
            otherItemArr.push(_loc1_);
            _loc12_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc9_] as AnotherDimensionResourceInfo;
            _loc8_ = new AnotherDimensionSelfItemView(_loc7_);
            PositionUtils.setPos(_loc8_,"anotherDimension.anotherDimension.selfPos" + (_loc9_ + 1));
            addToContent(_loc8_);
            selfItemArr.push(_loc8_);
            _loc9_++;
         }
      }
      
      private function initEvent() : void
      {
         _closeBnt.addEventListener("click",_closeClick);
         _shijiankongzhiSelect.addEventListener("click",_shijiankongzhiSelectClick);
         _kongjianzhangwoSelect.addEventListener("click",_kongjianzhangwoSelectClick);
         _lueduodashiSelect.addEventListener("click",_lueduodashiSelectClick);
         _upGradeBnt.addEventListener("click",__upGradeClick);
         _searchBnt.addEventListener("click",__searchClick);
         AnotherDimensionManager.Instance.addEventListener("updateView",__updateInfoView);
         AnotherDimensionManager.Instance.addEventListener("addMsg",__addMsg);
         _progress.addEventListener("mcStop",_showMCOver);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
         _helpBnt2.addEventListener("click",openHelpViewHander);
      }
      
      private function openHelpViewHander(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:AnotherDimensionHelpFrame = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.view.helpFrame");
         _loc2_.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      private function frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         param1.currentTarget.dispose();
      }
      
      protected function __onStartLoad(param1:Event) : void
      {
         var _loc2_:RoomInfo = RoomManager.Instance.current;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         dispose();
      }
      
      private function __addMsg(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         if(_vbox && _vbox.numChildren > 0)
         {
            _vbox.removeAllChild();
         }
         var _loc2_:Array = AnotherDimensionManager.Instance.msgArr;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_] as AnotherDimensionMsgInfo;
            if(_loc4_.userID != _loc4_.ownUserID && _loc4_.restatus == 2)
            {
               _loc3_ = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionTxt.msgTxt2",_loc4_.ownName);
            }
            else if(_loc4_.userID == _loc4_.ownUserID && _loc4_.restatus == 2)
            {
               _loc3_ = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionTxt.msgTxt3",_loc4_.ownName);
            }
            else if(_loc4_.userID == _loc4_.ownUserID && _loc4_.restatus == 3)
            {
               _loc3_ = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionTxt.msgTxt4");
            }
            addMsg(_loc3_);
            _loc5_++;
         }
      }
      
      private function _showMCOver(param1:Event) : void
      {
         this.mouseEnabled = true;
         this.mouseChildren = true;
         if(_type == 1)
         {
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv;
         }
         else if(_type == 2)
         {
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv;
         }
         else if(_type == 3)
         {
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv;
         }
      }
      
      private function __updateInfoView(param1:Event) : void
      {
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = getTimeControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv == 0)
         {
            _loc5_ = 0;
         }
         var _loc7_:int = getSpaceControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv == 0)
         {
            _loc7_ = 0;
         }
         var _loc10_:int = getLooterControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv == 0)
         {
            _loc10_ = 0;
         }
         _shijiankongzhiTxt.text = LanguageMgr.GetTranslation("anotherDimension.shijiankongzhiTxt.txt",_loc5_);
         _kongjianzhangwoTxt.text = LanguageMgr.GetTranslation("anotherDimension.kongjianzhangwoTxt.txt",_loc7_);
         _lueduodashiTxt.text = LanguageMgr.GetTranslation("anotherDimension.lueduodashiTxt.txt",_loc10_);
         var _loc3_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalOccupyCount;
         var _loc6_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.occupyCount;
         var _loc4_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalLootCount;
         var _loc8_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.lootCount;
         _canZhanlingCountTxt.text = _loc3_ - _loc6_ + "";
         _canLueduoCountTxt.text = _loc4_ - _loc8_ + "";
         if(_type == 1)
         {
            _loc9_ = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
            _loc11_ = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
            if(timeLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(_loc9_ + "/" + _loc11_);
            }
         }
         else if(_type == 2)
         {
            _loc9_ = AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlExp;
            _loc11_ = getSpaceControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[1];
            if(spaceLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(_loc9_ + "/" + _loc11_);
            }
         }
         else if(_type == 3)
         {
            _loc9_ = AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlExp;
            _loc11_ = getLooterControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[1];
            if(lootLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(_loc9_ + "/" + _loc11_);
            }
         }
         if(_loc9_ == 0 && _loc11_ == 0)
         {
            this.mouseEnabled = true;
            this.mouseChildren = true;
            _loc2_ = 1;
            _progress.setProgress(1);
         }
         else if(_loc9_ == 0 && _loc11_ != 0)
         {
            _loc2_ = 1;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            _progress.playProgress(_loc2_,1);
         }
         else
         {
            _loc2_ = _loc9_ / _loc11_ * 100;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            _progress.playProgress(_loc2_);
         }
      }
      
      private function __upGradeClick(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(_allInSelect.selected)
         {
            _loc5_ = ServerConfigManager.instance.getLevelUpItemID();
            _loc3_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc5_);
            if(_type == 1)
            {
               _loc4_ = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
               _loc6_ = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
            }
            else if(_type == 2)
            {
               _loc4_ = AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlExp;
               _loc6_ = getSpaceControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[1];
            }
            else if(_type == 3)
            {
               _loc4_ = AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlExp;
               _loc6_ = getLooterControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[1];
            }
            _loc2_ = (_loc6_ - _loc4_) / oneItemExp;
            if(_loc2_ < _loc3_)
            {
               SocketManager.Instance.out.clickAnotherDimenUpgrade(_type,_loc2_);
            }
            else
            {
               SocketManager.Instance.out.clickAnotherDimenUpgrade(_type,_loc3_);
            }
         }
         else
         {
            SocketManager.Instance.out.clickAnotherDimenUpgrade(_type,1);
         }
      }
      
      private function removeEvent() : void
      {
         _closeBnt.removeEventListener("click",_closeClick);
         _shijiankongzhiSelect.removeEventListener("click",_shijiankongzhiSelectClick);
         _kongjianzhangwoSelect.removeEventListener("click",_kongjianzhangwoSelectClick);
         _lueduodashiSelect.removeEventListener("click",_lueduodashiSelectClick);
         _upGradeBnt.removeEventListener("click",__upGradeClick);
         _searchBnt.removeEventListener("click",__searchClick);
         AnotherDimensionManager.Instance.removeEventListener("updateView",__updateInfoView);
         AnotherDimensionManager.Instance.removeEventListener("addMsg",__addMsg);
         _progress.removeEventListener("mcStop",_showMCOver);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
      }
      
      private function __searchClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:AnotherDimensionInfo = AnotherDimensionManager.Instance.anotherDimensionInfo;
         if(AnotherDimensionManager.Instance.showBuyCountFram && _loc4_ && _loc4_.refreshCount >= 1)
         {
            _loc3_ = ServerConfigManager.instance.getSearchPrice() * _loc4_.refreshCount;
            _loc2_ = LanguageMgr.GetTranslation("anotherDimension.buyCountDescription",_loc3_);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn.addEventListener("click",__onClickSelectedBtn);
            alert.addToContent(_selectBtn);
            alert.moveEnable = false;
            alert.addEventListener("response",__onRecoverResponse);
            alert.height = 200;
            _selectBtn.x = 63;
            _selectBtn.y = 67;
         }
         else
         {
            SocketManager.Instance.out.clickAnotherDimenSearch();
         }
      }
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void
      {
         AnotherDimensionManager.Instance.showBuyCountFram = !_selectBtn.selected;
      }
      
      private function __onRecoverResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc3_:AnotherDimensionInfo = AnotherDimensionManager.Instance.anotherDimensionInfo;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = ServerConfigManager.instance.getSearchPrice() * _loc3_.refreshCount;
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.clickAnotherDimenSearch();
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            AnotherDimensionManager.Instance.showBuyCountFram = true;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _closeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AnotherDimensionControl.instance.disposeMainView();
      }
      
      private function _shijiankongzhiSelectClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_shijiankongzhiSelect.selected)
         {
            _kongjianzhangwoSelect.selected = false;
            _lueduodashiSelect.selected = false;
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv;
            _loc3_ = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
            _loc4_ = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
            _loc2_ = _loc3_ / _loc4_ * 100;
            _progress.setProgress(_loc2_);
            if(timeLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(_loc3_ + "/" + _loc4_);
            }
            _type = 1;
         }
      }
      
      private function _kongjianzhangwoSelectClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_kongjianzhangwoSelect.selected)
         {
            _shijiankongzhiSelect.selected = false;
            _lueduodashiSelect.selected = false;
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv;
            _loc3_ = AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlExp;
            _loc4_ = getSpaceControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[1];
            _loc2_ = _loc3_ / _loc4_ * 100;
            _progress.setProgress(_loc2_);
            if(spaceLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(_loc3_ + "/" + _loc4_);
            }
            _type = 2;
         }
      }
      
      private function _lueduodashiSelectClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(_lueduodashiSelect.selected)
         {
            _shijiankongzhiSelect.selected = false;
            _kongjianzhangwoSelect.selected = false;
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv;
            _loc3_ = AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlExp;
            _loc4_ = getLooterControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[1];
            _loc2_ = _loc3_ / _loc4_ * 100;
            _progress.setProgress(_loc2_);
            if(lootLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(_loc3_ + "/" + _loc4_);
            }
            _type = 3;
         }
      }
      
      private function getTimeControlExpBylv(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getTimeControl();
         if(param1 == _loc2_.length)
         {
            timeLvMax = true;
         }
         if(param1 == 0)
         {
            param1 = 1;
         }
         var _loc4_:String = _loc2_[param1 - 1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
      }
      
      private function getTimeControlExpBylv_1(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getTimeControl();
         if(param1 == _loc2_.length)
         {
            param1 = param1 - 1;
            timeLvMax = true;
         }
         var _loc4_:String = _loc2_[param1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
      }
      
      private function getSpaceControlExpBylv(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getSpaceControl();
         if(param1 == _loc2_.length)
         {
            spaceLvMax = true;
         }
         if(param1 == 0)
         {
            param1 = 1;
         }
         var _loc4_:String = _loc2_[param1 - 1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
      }
      
      private function getSpaceControlExpBylv_1(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getSpaceControl();
         if(param1 == _loc2_.length)
         {
            param1 = param1 - 1;
            spaceLvMax = true;
         }
         var _loc4_:String = _loc2_[param1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
      }
      
      private function getLooterControlExpBylv(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getLootControl();
         if(param1 == _loc2_.length)
         {
            lootLvMax = true;
         }
         if(param1 == 0)
         {
            param1 = 1;
         }
         var _loc4_:String = _loc2_[param1 - 1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
      }
      
      private function getLooterControlExpBylv_1(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getLootControl();
         if(param1 == _loc2_.length)
         {
            param1 = param1 - 1;
            lootLvMax = true;
         }
         var _loc4_:String = _loc2_[param1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
      }
      
      private function addSelectionBnt() : void
      {
         _shijiankongzhiSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.shijiankongzhiSelectBnt");
         _kongjianzhangwoSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.kongjianzhangwoSelectBnt");
         _lueduodashiSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.lueduodashiSelectBnt");
         addToContent(_shijiankongzhiSelect);
         addToContent(_kongjianzhangwoSelect);
         addToContent(_lueduodashiSelect);
         var _loc1_:int = getTimeControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv == 0)
         {
            _loc1_ = 0;
         }
         var _loc2_:int = getSpaceControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv == 0)
         {
            _loc2_ = 0;
         }
         var _loc4_:int = getLooterControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv == 0)
         {
            _loc4_ = 0;
         }
         _shijiankongzhiTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.shijiankongzhiTxt");
         _shijiankongzhiTxt.text = LanguageMgr.GetTranslation("anotherDimension.shijiankongzhiTxt.txt",_loc1_);
         _kongjianzhangwoTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.kongjianzhangwoTxt");
         _kongjianzhangwoTxt.text = LanguageMgr.GetTranslation("anotherDimension.kongjianzhangwoTxt.txt",_loc2_);
         _lueduodashiTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.lueduodashiTxt");
         _lueduodashiTxt.text = LanguageMgr.GetTranslation("anotherDimension.lueduodashiTxt.txt",_loc4_);
         addToContent(_shijiankongzhiTxt);
         addToContent(_kongjianzhangwoTxt);
         addToContent(_lueduodashiTxt);
         _allInSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.allInCheckBtn");
         _allInSelect.text = LanguageMgr.GetTranslation("anotherDimension.allInCheckBtnTxt");
         addToContent(_allInSelect);
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.levelTxt");
         _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv;
         _shijiankongzhiSelect.selected = true;
         addToContent(_levelTxt);
         _progress = new AnotherDimensionProgress();
         PositionUtils.setPos(_progress,"anotherDimension.progressPos");
         addToContent(_progress);
         var _loc3_:int = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
         var _loc5_:int = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
         _shijiankongzhiSelectClick(null);
         _itemCell = new AnotherDimensionItemCell();
         PositionUtils.setPos(_itemCell,"anotherDimension.itemCellPos");
         addToContent(_itemCell);
         _upGradeBnt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.upGradeBnt");
         addToContent(_upGradeBnt);
      }
      
      private function addMsgView() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.msgBox");
         addToContent(_vbox);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.msgBoxScroll");
         addToContent(_scrollPanel);
         _scrollPanel.setView(_vbox);
         _scrollPanel.invalidateViewport_toTop(true);
         __addMsg(null);
      }
      
      public function addMsg(param1:String) : void
      {
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.msgTxt");
         _loc2_.mouseEnabled = false;
         _loc2_.htmlText = param1;
         _vbox.addChild(_loc2_);
         _scrollPanel.invalidateViewport_toTop(true);
      }
      
      private function __helpBntClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         AnotherDimensionManager.Instance.gameOver = false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
