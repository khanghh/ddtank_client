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
         var totaloccupyTime:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalOccupyCount;
         var occupyTime:int = AnotherDimensionManager.Instance.anotherDimensionInfo.occupyCount;
         var totalLootCount:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalLootCount;
         var lootCount:int = AnotherDimensionManager.Instance.anotherDimensionInfo.lootCount;
         _canZhanlingCountTxt.text = totaloccupyTime - occupyTime + "";
         _canLueduoCountTxt.text = totalLootCount - lootCount + "";
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
         var otherIndex:int = 0;
         var other:* = null;
         var selfIndex:int = 0;
         var selfone:* = null;
         var i:int = 0;
         var info:* = null;
         var another:* = null;
         var j:int = 0;
         var info1:* = null;
         var self:* = null;
         var resourceList:Array = AnotherDimensionManager.Instance.resourceList;
         var haveResourceList:Array = AnotherDimensionManager.Instance.haveResourceList;
         if(otherItemArr && otherItemArr.length > 0)
         {
            for(otherIndex = 0; otherIndex < otherItemArr.length; )
            {
               other = otherItemArr[otherIndex] as AnotherDimensionOtherItemView;
               other.dispose();
               other = null;
               otherIndex++;
            }
         }
         if(selfItemArr && selfItemArr.length > 0)
         {
            for(selfIndex = 0; selfIndex < selfItemArr.length; )
            {
               selfone = selfItemArr[selfIndex] as AnotherDimensionSelfItemView;
               selfone.dispose();
               selfone = null;
               selfIndex++;
            }
         }
         otherItemArr = [];
         selfItemArr = [];
         for(i = 0; i < resourceList.length; )
         {
            info = resourceList[i] as AnotherDimensionResourceInfo;
            another = new AnotherDimensionOtherItemView(info);
            PositionUtils.setPos(another,"anotherDimension.anotherDimension.anotherPos" + info.resourcePos);
            addToContent(another);
            otherItemArr.push(another);
            i++;
         }
         for(j = 0; j < haveResourceList.length; )
         {
            info1 = haveResourceList[j] as AnotherDimensionResourceInfo;
            self = new AnotherDimensionSelfItemView(info1);
            PositionUtils.setPos(self,"anotherDimension.anotherDimension.selfPos" + (j + 1));
            addToContent(self);
            selfItemArr.push(self);
            j++;
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
      
      private function openHelpViewHander(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var helpframe:AnotherDimensionHelpFrame = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.view.helpFrame");
         helpframe.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(helpframe,2,true,1);
      }
      
      private function frameEvent(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         e.currentTarget.dispose();
      }
      
      protected function __onStartLoad(event:Event) : void
      {
         var roomInfo:RoomInfo = RoomManager.Instance.current;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         dispose();
      }
      
      private function __addMsg(e:Event) : void
      {
         var msg:* = null;
         var i:int = 0;
         var info:* = null;
         if(_vbox && _vbox.numChildren > 0)
         {
            _vbox.removeAllChild();
         }
         var infoArr:Array = AnotherDimensionManager.Instance.msgArr;
         for(i = 0; i < infoArr.length; )
         {
            info = infoArr[i] as AnotherDimensionMsgInfo;
            if(info.userID != info.ownUserID && info.restatus == 2)
            {
               msg = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionTxt.msgTxt2",info.ownName);
            }
            else if(info.userID == info.ownUserID && info.restatus == 2)
            {
               msg = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionTxt.msgTxt3",info.ownName);
            }
            else if(info.userID == info.ownUserID && info.restatus == 3)
            {
               msg = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionTxt.msgTxt4");
            }
            addMsg(msg);
            i++;
         }
      }
      
      private function _showMCOver(e:Event) : void
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
      
      private function __updateInfoView(e:Event) : void
      {
         var currentExp:int = 0;
         var totalCurrentExp:int = 0;
         var progress:int = 0;
         var shijiankongzhiCount:int = getTimeControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv == 0)
         {
            shijiankongzhiCount = 0;
         }
         var kongjianzhangwoCount:int = getSpaceControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv == 0)
         {
            kongjianzhangwoCount = 0;
         }
         var lueduodashiCount:int = getLooterControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv == 0)
         {
            lueduodashiCount = 0;
         }
         _shijiankongzhiTxt.text = LanguageMgr.GetTranslation("anotherDimension.shijiankongzhiTxt.txt",shijiankongzhiCount);
         _kongjianzhangwoTxt.text = LanguageMgr.GetTranslation("anotherDimension.kongjianzhangwoTxt.txt",kongjianzhangwoCount);
         _lueduodashiTxt.text = LanguageMgr.GetTranslation("anotherDimension.lueduodashiTxt.txt",lueduodashiCount);
         var totaloccupyTime:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalOccupyCount;
         var occupyTime:int = AnotherDimensionManager.Instance.anotherDimensionInfo.occupyCount;
         var totalLootCount:int = AnotherDimensionManager.Instance.anotherDimensionInfo.totalLootCount;
         var lootCount:int = AnotherDimensionManager.Instance.anotherDimensionInfo.lootCount;
         _canZhanlingCountTxt.text = totaloccupyTime - occupyTime + "";
         _canLueduoCountTxt.text = totalLootCount - lootCount + "";
         if(_type == 1)
         {
            currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
            totalCurrentExp = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
            if(timeLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(currentExp + "/" + totalCurrentExp);
            }
         }
         else if(_type == 2)
         {
            currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlExp;
            totalCurrentExp = getSpaceControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[1];
            if(spaceLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(currentExp + "/" + totalCurrentExp);
            }
         }
         else if(_type == 3)
         {
            currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlExp;
            totalCurrentExp = getLooterControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[1];
            if(lootLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(currentExp + "/" + totalCurrentExp);
            }
         }
         if(currentExp == 0 && totalCurrentExp == 0)
         {
            this.mouseEnabled = true;
            this.mouseChildren = true;
            progress = 1;
            _progress.setProgress(1);
         }
         else if(currentExp == 0 && totalCurrentExp != 0)
         {
            progress = 1;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            _progress.playProgress(progress,1);
         }
         else
         {
            progress = currentExp / totalCurrentExp * 100;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            _progress.playProgress(progress);
         }
      }
      
      private function __upGradeClick(e:MouseEvent) : void
      {
         var _itemId:int = 0;
         var haveItemCount:int = 0;
         var currentExp:int = 0;
         var totalCurrentExp:int = 0;
         var anotherItemNum:int = 0;
         SoundManager.instance.play("008");
         if(_allInSelect.selected)
         {
            _itemId = ServerConfigManager.instance.getLevelUpItemID();
            haveItemCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_itemId);
            if(_type == 1)
            {
               currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
               totalCurrentExp = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
            }
            else if(_type == 2)
            {
               currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlExp;
               totalCurrentExp = getSpaceControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[1];
            }
            else if(_type == 3)
            {
               currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlExp;
               totalCurrentExp = getLooterControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[1];
            }
            anotherItemNum = (totalCurrentExp - currentExp) / oneItemExp;
            if(anotherItemNum < haveItemCount)
            {
               SocketManager.Instance.out.clickAnotherDimenUpgrade(_type,anotherItemNum);
            }
            else
            {
               SocketManager.Instance.out.clickAnotherDimenUpgrade(_type,haveItemCount);
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
      
      private function __searchClick(e:MouseEvent) : void
      {
         var price:int = 0;
         var content:* = null;
         SoundManager.instance.play("008");
         var info:AnotherDimensionInfo = AnotherDimensionManager.Instance.anotherDimensionInfo;
         if(AnotherDimensionManager.Instance.showBuyCountFram && info && info.refreshCount >= 1)
         {
            price = ServerConfigManager.instance.getSearchPrice() * info.refreshCount;
            content = LanguageMgr.GetTranslation("anotherDimension.buyCountDescription",price);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),content,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
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
      
      private function __onClickSelectedBtn(e:MouseEvent) : void
      {
         AnotherDimensionManager.Instance.showBuyCountFram = !_selectBtn.selected;
      }
      
      private function __onRecoverResponse(e:FrameEvent) : void
      {
         var price:int = 0;
         SoundManager.instance.playButtonSound();
         var info:AnotherDimensionInfo = AnotherDimensionManager.Instance.anotherDimensionInfo;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            price = ServerConfigManager.instance.getSearchPrice() * info.refreshCount;
            if(PlayerManager.Instance.Self.Money < price)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.clickAnotherDimenSearch();
         }
         else if(e.responseCode == 4 || e.responseCode == 0 || e.responseCode == 1)
         {
            AnotherDimensionManager.Instance.showBuyCountFram = true;
         }
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(e.currentTarget);
      }
      
      private function _closeClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AnotherDimensionControl.instance.disposeMainView();
      }
      
      private function _shijiankongzhiSelectClick(e:MouseEvent) : void
      {
         var currentExp:int = 0;
         var totalCurrentExp:int = 0;
         var progress:int = 0;
         if(_shijiankongzhiSelect.selected)
         {
            _kongjianzhangwoSelect.selected = false;
            _lueduodashiSelect.selected = false;
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv;
            currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
            totalCurrentExp = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
            progress = currentExp / totalCurrentExp * 100;
            _progress.setProgress(progress);
            if(timeLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(currentExp + "/" + totalCurrentExp);
            }
            _type = 1;
         }
      }
      
      private function _kongjianzhangwoSelectClick(e:MouseEvent) : void
      {
         var currentExp:int = 0;
         var totalCurrentExp:int = 0;
         var progress:int = 0;
         if(_kongjianzhangwoSelect.selected)
         {
            _shijiankongzhiSelect.selected = false;
            _lueduodashiSelect.selected = false;
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv;
            currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlExp;
            totalCurrentExp = getSpaceControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[1];
            progress = currentExp / totalCurrentExp * 100;
            _progress.setProgress(progress);
            if(spaceLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(currentExp + "/" + totalCurrentExp);
            }
            _type = 2;
         }
      }
      
      private function _lueduodashiSelectClick(e:MouseEvent) : void
      {
         var currentExp:int = 0;
         var totalCurrentExp:int = 0;
         var progress:int = 0;
         if(_lueduodashiSelect.selected)
         {
            _shijiankongzhiSelect.selected = false;
            _kongjianzhangwoSelect.selected = false;
            _levelTxt.text = "LV." + AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv;
            currentExp = AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlExp;
            totalCurrentExp = getLooterControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[1];
            progress = currentExp / totalCurrentExp * 100;
            _progress.setProgress(progress);
            if(lootLvMax)
            {
               _progress.setProgressTxt("MAX");
            }
            else
            {
               _progress.setProgressTxt(currentExp + "/" + totalCurrentExp);
            }
            _type = 3;
         }
      }
      
      private function getTimeControlExpBylv(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getTimeControl();
         if(lv == arr.length)
         {
            timeLvMax = true;
         }
         if(lv == 0)
         {
            lv = 1;
         }
         var info:String = arr[lv - 1];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      private function getTimeControlExpBylv_1(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getTimeControl();
         if(lv == arr.length)
         {
            lv = lv - 1;
            timeLvMax = true;
         }
         var info:String = arr[lv];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      private function getSpaceControlExpBylv(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getSpaceControl();
         if(lv == arr.length)
         {
            spaceLvMax = true;
         }
         if(lv == 0)
         {
            lv = 1;
         }
         var info:String = arr[lv - 1];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      private function getSpaceControlExpBylv_1(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getSpaceControl();
         if(lv == arr.length)
         {
            lv = lv - 1;
            spaceLvMax = true;
         }
         var info:String = arr[lv];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      private function getLooterControlExpBylv(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getLootControl();
         if(lv == arr.length)
         {
            lootLvMax = true;
         }
         if(lv == 0)
         {
            lv = 1;
         }
         var info:String = arr[lv - 1];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      private function getLooterControlExpBylv_1(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getLootControl();
         if(lv == arr.length)
         {
            lv = lv - 1;
            lootLvMax = true;
         }
         var info:String = arr[lv];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      private function addSelectionBnt() : void
      {
         _shijiankongzhiSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.shijiankongzhiSelectBnt");
         _kongjianzhangwoSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.kongjianzhangwoSelectBnt");
         _lueduodashiSelect = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.lueduodashiSelectBnt");
         addToContent(_shijiankongzhiSelect);
         addToContent(_kongjianzhangwoSelect);
         addToContent(_lueduodashiSelect);
         var shijiankongzhiCount:int = getTimeControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv == 0)
         {
            shijiankongzhiCount = 0;
         }
         var kongjianzhangwoCount:int = getSpaceControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.spaceControlLv == 0)
         {
            kongjianzhangwoCount = 0;
         }
         var lueduodashiCount:int = getLooterControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv)[2];
         if(AnotherDimensionManager.Instance.anotherDimensionInfo.looterControlLv == 0)
         {
            lueduodashiCount = 0;
         }
         _shijiankongzhiTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.shijiankongzhiTxt");
         _shijiankongzhiTxt.text = LanguageMgr.GetTranslation("anotherDimension.shijiankongzhiTxt.txt",shijiankongzhiCount);
         _kongjianzhangwoTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.kongjianzhangwoTxt");
         _kongjianzhangwoTxt.text = LanguageMgr.GetTranslation("anotherDimension.kongjianzhangwoTxt.txt",kongjianzhangwoCount);
         _lueduodashiTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.lueduodashiTxt");
         _lueduodashiTxt.text = LanguageMgr.GetTranslation("anotherDimension.lueduodashiTxt.txt",lueduodashiCount);
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
         var currentExp:int = AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlExp;
         var totalCurrentExp:int = getTimeControlExpBylv_1(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[1];
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
      
      public function addMsg(msg:String) : void
      {
         var _lblName:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.msgTxt");
         _lblName.mouseEnabled = false;
         _lblName.htmlText = msg;
         _vbox.addChild(_lblName);
         _scrollPanel.invalidateViewport_toTop(true);
      }
      
      private function __helpBntClick(e:MouseEvent) : void
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
