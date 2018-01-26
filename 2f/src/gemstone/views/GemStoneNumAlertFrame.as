package gemstone.views
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GemStoneNumAlertFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _cellBg:ScaleBitmapImage;
      
      private var _cell:BagCell;
      
      private var _descript:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var maxLimit:int;
      
      private var submitFunc:Function;
      
      public function GemStoneNumAlertFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __maxBtnClick(param1:MouseEvent) : void{}
      
      protected function __inputChange(param1:Event) : void{}
      
      protected function _response(param1:FrameEvent) : void{}
      
      public function callBack(param1:Function) : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
   }
}
