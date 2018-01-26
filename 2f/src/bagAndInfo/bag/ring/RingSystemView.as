package bagAndInfo.bag.ring
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class RingSystemView extends Frame
   {
       
      
      private var _helpBtn:BaseButton;
      
      private var _bg:Bitmap;
      
      private var _progress:RingSystemLevel;
      
      private var _ringCell:BagCell;
      
      private var _currentData:FilterFrameText;
      
      private var _nextData:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _coupleNum:RingSystemFilterInfo;
      
      private var _dungeonNum:RingSystemFilterInfo;
      
      private var _propsNum:RingSystemFilterInfo;
      
      private var _skill:ScaleFrameImage;
      
      public function RingSystemView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onHelpClick(param1:MouseEvent) : void{}
      
      protected function setViewInfo() : void{}
      
      private function setSkillTipData() : void{}
      
      private function __onUpdateProperty(param1:PlayerPropertyEvent) : void{}
      
      private function getSurplusCount(param1:int, param2:int) : int{return 0;}
      
      private function sendPkg() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
