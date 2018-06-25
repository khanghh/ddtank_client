package totem.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import morn.core.handlers.Handler;
   import totem.TotemControl;
   import totem.TotemManager;
   import totem.data.TotemUpGradDataVo;
   import totem.mornUI.TotemUpGradeViewUI;
   
   public class TotemUpGradeView extends TotemUpGradeViewUI
   {
       
      
      private var _preItem:TotemUpGradeItemView;
      
      private var _nextItem:TotemUpGradeItemView;
      
      private var _curPage:int = -1;
      
      private var _clickNum:Number = 0;
      
      public function TotemUpGradeView(page:int)
      {
         _curPage = page;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _preItem = new TotemUpGradeItemView();
         PositionUtils.setPos(_preItem,"totem.upGrade.preItemPos");
         addChild(_preItem);
         _nextItem = new TotemUpGradeItemView();
         addChild(_nextItem);
         PositionUtils.setPos(_nextItem,"totem.upGrade.nextItemPos");
         btn_maxGrade.visible = false;
         btn_upGrade.clickHandler = new Handler(__upGradeHandler);
         btn_close.clickHandler = new Handler(__closeHandler);
         TotemManager.instance.addEventListener("updateUpGrade",updateData);
      }
      
      private function __closeHandler() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function __upGradeHandler() : void
      {
         SoundManager.instance.playButtonSound();
         if(!canClick)
         {
            return;
         }
         if(checkIsCanUpGrade())
         {
            SocketManager.Instance.out.sendTotemUpGrade(_curPage);
         }
      }
      
      private function get canClick() : Boolean
      {
         var nowTime:Number = new Date().time;
         if(nowTime - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return false;
         }
         _clickNum = nowTime;
         return true;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         updateData(null);
      }
      
      private function updateData(evt:CEvent) : void
      {
         var curGrade:int = TotemControl.instance.getGradeByTotemPage(_curPage);
         var curGradeInfo:TotemUpGradDataVo = TotemControl.instance.getUpGradeInfo(_curPage,curGrade);
         curGrade++;
         var NextGradeInfo:* = TotemControl.instance.getUpGradeInfo(_curPage,curGrade);
         var isMaxGrade:Boolean = false;
         if(curGradeInfo != null && NextGradeInfo == null)
         {
            NextGradeInfo = curGradeInfo;
            isMaxGrade = true;
         }
         _preItem.update(curGradeInfo);
         _nextItem.update(NextGradeInfo);
         btn_maxGrade.visible = isMaxGrade;
         btn_upGrade.visible = !isMaxGrade;
         btn_maxGrade.disabled = isMaxGrade;
         creatTotemGoodItem(NextGradeInfo.itemTempId1,NextGradeInfo.itemTempId2);
         var gloryCount:int = PlayerManager.Instance.Self.myHonor;
         var totemCount:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(NextGradeInfo.itemTempId2);
         lbl_glory.text = gloryCount + "/" + NextGradeInfo.param1;
         lbl_totem.text = totemCount + "/" + NextGradeInfo.param2;
      }
      
      private function checkIsCanUpGrade() : Boolean
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return false;
         }
         var curGrade:int = TotemControl.instance.getGradeByTotemPage(_curPage);
         curGrade++;
         var NextGradeInfo:TotemUpGradDataVo = TotemControl.instance.getUpGradeInfo(_curPage,curGrade);
         var gloryCount:int = PlayerManager.Instance.Self.myHonor;
         var totemCount:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(NextGradeInfo.itemTempId2);
         if(gloryCount < NextGradeInfo.param1 || totemCount < NextGradeInfo.param2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.upGrade.fail"),0,true);
            return false;
         }
         return true;
      }
      
      private function creatTotemGoodItem(temID1:int, temID2:int) : void
      {
         var totemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(temID2);
         var totemCell:BagCell = new BagCell(0);
         totemCell.setBgVisible(false);
         totemCell.width = 38;
         totemCell.height = 38;
         totemCell.info = totemInfo;
         PositionUtils.setPos(totemCell,"totem.upGrade.totemCellPos");
         addChild(totemCell);
      }
      
      private function removeEvent() : void
      {
         TotemManager.instance.removeEventListener("updateUpGrade",updateData);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _preItem.dispose();
         _preItem = null;
         _nextItem.dispose();
         _nextItem = null;
      }
   }
}
