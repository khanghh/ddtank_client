package store.newFusion.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import horse.HorseControl;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewUnitListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _isActivatedText:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _selectedCover:Bitmap;
      
      private var _data:FusionNewVo;
      
      public function FusionNewUnitListCell()
      {
         super();
         this.mouseChildren = false;
         this.buttonMode = true;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.cellNameTxt");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.cellCountTxt");
         _isActivatedText = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.cellIsActivateTxt");
         _isActivatedText.text = "Đã Mở";
         _selectedCover = ComponentFactory.Instance.creatBitmap("asset.newFusion.unitCell.selectedCover");
         _selectedCover.visible = false;
         addChild(_selectedCover);
         addChild(_nameTxt);
         addChild(_countTxt);
         this.graphics.lineStyle(1,4137989);
         this.graphics.moveTo(0,24);
         this.graphics.lineTo(205,24);
         this.graphics.lineStyle(1,9334339);
         this.graphics.moveTo(0,25);
         this.graphics.lineTo(205,25);
      }
      
      private function updateViewData() : void
      {
         isPetsActivated = function(param1:FusionNewVo):Boolean
         {
            return PetsAdvancedManager.Instance.isActivated(param1.fusionItemInfo.TemplateID);
         };
         isMountsActivated = function(param1:FusionNewVo):Boolean
         {
            var _loc3_:Boolean = false;
            var _loc2_:Array = HorseControl.instance.getHorsePicCherishState(param1.mountID,param1.fusionItemInfo.TemplateID);
            if(_loc2_[0] == true)
            {
               _loc3_ = true;
            }
            return _loc3_;
         };
         _nameTxt.text = _data.fusionItemInfo.Name;
         var tmp:int = _data.canFusionCount;
         if(tmp > 0)
         {
            _countTxt.text = "(" + tmp + ")";
         }
         else
         {
            _countTxt.text = "";
         }
         _countTxt.x = _nameTxt.x + _nameTxt.textWidth + 2;
         if(_data.FusionType == 3)
         {
            _data.isActivated = isPetsActivated(_data) || isMountsActivated(_data);
            if(_data.isActivated)
            {
               addChild(_isActivatedText);
               _isActivatedText.visible = true;
               _isActivatedText.x = 3 + (_countTxt.text == ""?_nameTxt.x + _nameTxt.textWidth:Number(_countTxt.x + _countTxt.textWidth));
            }
            else
            {
               _isActivatedText.parent && removeChild(_isActivatedText);
               _isActivatedText.visible = false;
            }
         }
         else
         {
            _isActivatedText.parent && removeChild(_isActivatedText);
            _data.isActivated = false;
            _isActivatedText.visible = false;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _selectedCover.visible = param2;
         _nameTxt.textColor = !!param2?16051939:16768669;
         _countTxt.textColor = !!param2?16051939:16768669;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as FusionNewVo;
         updateViewData();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _selectedCover = null;
         _nameTxt = null;
         _countTxt = null;
         _isActivatedText = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
