package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AvatarCollectionMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _rightView:AvatarCollectionRightView;
      
      private var _canActivitySCB:SelectedCheckButton;
      
      private var _canBuySCB:SelectedCheckButton;
      
      private var _btnHelp:BaseButton;
      
      private var _leftView:AvatarCollectionLeftView;
      
      public function AvatarCollectionMainView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function reset() : void{}
      
      private function canBuyChangeHandler(param1:MouseEvent) : void{}
      
      private function canActivityChangeHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get unitList() : Vector.<AvatarCollectionUnitView>{return null;}
   }
}
