package godCardRaise.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardPointRewardListInfo;
   
   public class GodCardRaiseScoreViewItem extends Sprite implements Disposeable
   {
       
      
      private var _info:GodCardPointRewardListInfo;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _awardCell:BagCell;
      
      private var _getBtn:BaseButton;
      
      private var _getBmp:Bitmap;
      
      private var _clickNum:Number = 0;
      
      public function GodCardRaiseScoreViewItem(param1:GodCardPointRewardListInfo)
      {
         super();
         _info = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseScoreViewItem.scoreTxt");
         _scoreTxt.text = "" + _info.Point;
         addChild(_scoreTxt);
         _awardCell = new BagCell(0);
         PositionUtils.setPos(_awardCell,"godCardRaiseScoreViewItem.cellPos");
         addChild(_awardCell);
         var _loc1_:InventoryItemInfo = new InventoryItemInfo();
         _loc1_.TemplateID = _info.ItemID;
         ItemManager.fill(_loc1_);
         _loc1_.IsBinds = _info.IsBind;
         _loc1_.MaxCount = _info.Count;
         _loc1_.Count = _info.Count;
         _loc1_.ValidDate = _info.Valid;
         _awardCell.info = _loc1_;
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseScoreViewItem.getBtn");
         addChild(_getBtn);
         _getBmp = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseScoreViewItem.getBmp");
         addChild(_getBmp);
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Dictionary = GodCardRaiseManager.Instance.model.awardIds;
         if(_loc1_.hasOwnProperty(_info.ID))
         {
            _getBtn.visible = false;
            _getBmp.visible = true;
            _getBtn.enable = false;
         }
         else
         {
            _loc2_ = GodCardRaiseManager.Instance.model.score;
            if(_loc2_ >= _info.Point)
            {
               _getBtn.visible = true;
               _getBmp.visible = false;
               _getBtn.enable = true;
            }
            else
            {
               _getBtn.visible = true;
               _getBmp.visible = false;
               _getBtn.enable = false;
            }
         }
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:Number = new Date().time;
         if(_loc2_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = _loc2_;
         GameInSocketOut.sendGodCardPointAwardAttribute(_info.ID);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _info = null;
         _scoreTxt = null;
         _awardCell = null;
         _getBtn = null;
         _getBmp = null;
         _clickNum = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
