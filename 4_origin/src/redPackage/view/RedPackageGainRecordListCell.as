package redPackage.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.Helpers;
   import flash.display.DisplayObject;
   
   public class RedPackageGainRecordListCell extends Component implements Disposeable, IListCell
   {
       
      
      private var _detailText:FilterFrameText;
      
      private var _cellValue:Object;
      
      public function RedPackageGainRecordListCell()
      {
         super();
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "0,7,6";
         _detailText = ComponentFactory.Instance.creat("redpkg.consortion.gainrecord.listCellTxt");
         addChild(_detailText);
         ShowTipManager.Instance.addTip(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ShowTipManager.Instance.removeTip(this);
         if(_detailText != null)
         {
            ObjectUtils.disposeObject(_detailText);
            _detailText = null;
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
         var _loc2_:Date = param1["date"];
         var _loc3_:String = _loc2_.fullYear.toString() + "-" + Helpers.fixZero((_loc2_.month + 1).toString()) + "-" + Helpers.fixZero(_loc2_.date.toString()) + " " + Helpers.fixZero(_loc2_.hours.toString()) + ":" + Helpers.fixZero((_loc2_.minutes + 1).toString());
         _detailText.text = LanguageMgr.GetTranslation("redpkg.consortion.gainRecordListCell",param1["sendNick"],param1["gainedNick"],param1["money"],_loc3_);
      }
      
      override public function get tipData() : Object
      {
         _tipData = _detailText.text;
         return _tipData;
      }
      
      override public function get tipDirctions() : String
      {
         return "5,4,0";
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
