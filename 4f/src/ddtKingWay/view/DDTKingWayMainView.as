package ddtKingWay.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddtKingWay.DDTKingWayManager;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   
   public class DDTKingWayMainView extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _bgItem:Image;
      
      private var _btnHelp:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _prevBtn:BaseButton;
      
      private var _leftView:DDTKingWayLevelView;
      
      private var _HBox:HBox;
      
      private var _item:ScaleFrameImage;
      
      private var _list:Vector.<ScaleFrameImage>;
      
      private var _index:int;
      
      private var _maxIndex:int;
      
      private var _currentGradeIndex:int;
      
      public function DDTKingWayMainView(){super();}
      
      override protected function init() : void{}
      
      private function __onClickNext(param1:MouseEvent) : void{}
      
      private function __onClickPrev(param1:MouseEvent) : void{}
      
      private function updateView() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onFrameClose() : void{}
      
      override public function dispose() : void{}
   }
}
