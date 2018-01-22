package petsBag.view
{
   import bagAndInfo.bag.BagView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import petsBag.PetsBagControl;
   import petsBag.PetsBagManager;
   
   public class PetsView extends Frame
   {
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _bottom:ScaleBitmapImage;
      
      private var _petsBagOutView:PetsBagOutView;
      
      private var _bagView:BagView;
      
      public function PetsView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __startShine(param1:CellEvent) : void{}
      
      private function __stopShine(param1:CellEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
