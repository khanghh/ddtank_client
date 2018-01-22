package magicHouse
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import magicHouse.magicBox.MagicHouseBoxView;
   import magicHouse.magicCollection.MagicHouseCollectionMainView;
   import magicHouse.treasureHouse.MagicHouseTreasureHouseView;
   
   public class MagicHouseMainView extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _collectionBtn:SelectedButton;
      
      private var _treasureBtn:SelectedButton;
      
      private var _boxBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _collectionView:MagicHouseCollectionMainView;
      
      private var _treasureView:MagicHouseTreasureHouseView;
      
      private var _magicBoxView:MagicHouseBoxView;
      
      public function MagicHouseMainView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function _showCollectionView() : void{}
      
      private function _showTreasureView() : void{}
      
      private function _showMagicBoxView() : void{}
      
      public function show(param1:int = 0) : void{}
      
      public function close() : void{}
      
      override public function dispose() : void{}
   }
}
