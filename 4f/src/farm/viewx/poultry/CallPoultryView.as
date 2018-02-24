package farm.viewx.poultry
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import farm.modelx.FarmPoultryInfo;
   import flash.utils.Dictionary;
   
   public class CallPoultryView extends BaseAlerFrame
   {
       
      
      private var _titleBg:ScaleBitmapImage;
      
      private var _btnBg:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _poultryBox:ComboBox;
      
      public function CallPoultryView(){super();}
      
      private function initView() : void{}
      
      private function addPoultryName() : void{}
      
      private function initEvent() : void{}
      
      protected function __onListClick(param1:ListItemEvent) : void{}
      
      private function __closeFarmHelper(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
