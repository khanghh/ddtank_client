package sanXiao.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonForArrange;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperHelpBtnCreate;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import sanXiao.SanXiaoManager;
   
   public class SanXiaoMainView extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _selectGridBox:HBox;
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var _btnGame:SelectedButtonForArrange;
      
      private var _btnStore:SelectedButtonForArrange;
      
      private var _btnDetail:SelectedButtonForArrange;
      
      private var _viewGame:SanXiaoViewGame;
      
      private var _viewStore:SanXiaoViewStore;
      
      private var _viewDetail:SanXiaoViewDetail;
      
      private var _curView:Sprite;
      
      private var _help:HelperHelpBtnCreate;
      
      public function SanXiaoMainView(){super();}
      
      override protected function init() : void{}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      protected function onBtnClick(param1:MouseEvent) : void{}
      
      protected function onSelectGroupChange(param1:Event) : void{}
      
      public function lockProps() : void{}
      
      public function unLockProps() : void{}
      
      public function updateDropOutItem() : void{}
      
      public function update() : void{}
      
      override public function dispose() : void{}
   }
}
