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
      
      public function RedPackageGainListCell(){super();}
      
      protected function onGainBtnClick(param1:MouseEvent) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      protected function onHistoryBtnClick(param1:MouseEvent) : void{}
      
      override public function get tipData() : Object{return null;}
      
      override public function get tipDirctions() : String{return null;}
      
      override public function dispose() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function formatDate(param1:Date) : String{return null;}
      
      override public function asDisplayObject() : DisplayObject{return null;}
   }
}
