package redPackage.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.Helpers;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import redPackage.RedPackageManager;
   
   public class RedPackageGainListCell extends Component implements Disposeable, IListCell
   {
       
      
      private var _cellValue:Object;
      
      private var _pkgId:int;
      
      private var _gainBtn:SimpleBitmapButton;
      
      private var _gainHistoryBtn:SimpleBitmapButton;
      
      private var _detailGainedText:FilterFrameText;
      
      private var _detailDidntGainText:FilterFrameText;
      
      public function RedPackageGainListCell()
      {
         super();
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "0,7,6";
         _detailGainedText = ComponentFactory.Instance.creat("redpkg.consortionGain.gained.txt");
         addChild(_detailGainedText);
         _detailDidntGainText = ComponentFactory.Instance.creat("redpkg.consortionGain.didntGain.txt");
         addChild(_detailDidntGainText);
         _gainBtn = ComponentFactory.Instance.creat("redpkg.consortionGain.gainBtn");
         _gainBtn.addEventListener("click",onGainBtnClick);
         addChild(_gainBtn);
         _gainHistoryBtn = ComponentFactory.Instance.creat("redpkg.consortionGain.gainHistoryBtn");
         _gainHistoryBtn.addEventListener("click",onHistoryBtnClick);
         addChild(_gainHistoryBtn);
         ShowTipManager.Instance.addTip(this);
      }
      
      protected function onGainBtnClick(param1:MouseEvent) : void
      {
         RedPackageManager.getInstance().onConsortionGainPackage(_pkgId);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(_cellValue && _cellValue["nick"] != null && _cellValue["nick"] != "")
         {
            .super.visible = true;
         }
         else
         {
            .super.visible = param1;
         }
      }
      
      protected function onHistoryBtnClick(param1:MouseEvent) : void
      {
         RedPackageManager.getInstance().onConsortionGainRecord(_pkgId);
      }
      
      override public function get tipData() : Object
      {
         _tipData = "";
         if(_detailDidntGainText && _detailDidntGainText.parent)
         {
            _tipData = _detailDidntGainText.text;
         }
         else if(_detailGainedText && _detailGainedText.parent)
         {
            _tipData = _detailGainedText.text;
         }
         return _tipData;
      }
      
      override public function get tipDirctions() : String
      {
         return "5,4,0";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ShowTipManager.Instance.removeTip(this);
         if(_gainBtn != null)
         {
            ObjectUtils.disposeObject(_gainBtn);
            _gainBtn = null;
         }
         if(_gainHistoryBtn != null)
         {
            ObjectUtils.disposeObject(_gainHistoryBtn);
            _gainHistoryBtn = null;
         }
         if(_detailGainedText != null)
         {
            ObjectUtils.disposeObject(_detailGainedText);
            _detailGainedText = null;
         }
         if(_detailDidntGainText != null)
         {
            ObjectUtils.disposeObject(_detailDidntGainText);
            _detailDidntGainText = null;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _cellValue;
      }
      
      public function setCellValue(param1:*) : void
      {
         _cellValue = param1;
         _pkgId = param1["id"];
         _gainBtn.enable = !param1["isGained"];
         var _loc3_:Date = param1["date"];
         var _loc2_:Date = new Date();
         if(_loc2_.time - _loc3_.time >= 86400000)
         {
            _gainBtn.enable = false;
         }
         if(param1["remain"] == 0)
         {
            _gainBtn.enable = false;
         }
         if(!param1["isGained"])
         {
            _detailDidntGainText.text = LanguageMgr.GetTranslation("redpkg.consortion.gainListCell",formatDate(param1["date"]),param1["nick"]);
            addChildAt(_detailDidntGainText,0);
            _detailGainedText.parent && removeChild(_detailGainedText);
         }
         else
         {
            _detailGainedText.text = LanguageMgr.GetTranslation("redpkg.consortion.gainListCell",formatDate(param1["date"]),param1["nick"]);
            addChildAt(_detailGainedText,0);
            _detailDidntGainText.parent && removeChild(_detailDidntGainText);
         }
      }
      
      private function formatDate(param1:Date) : String
      {
         var _loc3_:* = null;
         var _loc2_:Date = new Date();
         if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
         {
            _loc3_ = "Hôm " + Helpers.fixZero(param1.hours.toString()) + ":" + Helpers.fixZero((param1.minutes + 1).toString());
         }
         else
         {
            _loc3_ = param1.fullYear + "-" + Helpers.fixZero((param1.month + 1).toString()) + "-" + Helpers.fixZero(param1.date.toString()) + " " + Helpers.fixZero(param1.hours.toString()) + ":" + Helpers.fixZero((param1.minutes + 1).toString());
         }
         return _loc3_;
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
