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
      
      public function RedPackageGainRecordListCell(){super();}
      
      override public function dispose() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function get tipDirctions() : String{return null;}
      
      override public function asDisplayObject() : DisplayObject{return null;}
   }
}
