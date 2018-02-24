package rank.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import rank.RankManager;
   
   public class RankFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftBorderbg:ScaleBitmapImage;
      
      private var _leftView:RankMenu;
      
      private var _rightView:RankRewardView;
      
      private var _activityTime:FilterFrameText;
      
      private var _acitvityEndInfo:FilterFrameText;
      
      public function RankFrame(){super();}
      
      private function initView() : void{}
      
      public function init() : void{}
      
      public function setRightView() : void{}
      
      private function removeEvent() : void{}
      
      private function addEvent() : void{}
      
      protected function _responseHandle(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
