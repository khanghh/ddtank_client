package tryonSystem
{
   import bagAndInfo.cell.PersonalInfoCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import equipretrieve.effect.AnimationControl;
   import equipretrieve.effect.GlowFilterAnimation;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class TryonPanelView extends Sprite implements Disposeable
   {
      
      private static const CELL_PLACE:Array = [0,1,2,3,4,5,11,13];
       
      
      private var _controller:TryonSystemController;
      
      private var _model:TryonModel;
      
      private var _bg:MovieImage;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _tryTxt:FilterFrameText;
      
      private var _hideTxt:FilterFrameText;
      
      private var _hideHatBtn:SelectedCheckButton;
      
      private var _hideGlassBtn:SelectedCheckButton;
      
      private var _hideSuitBtn:SelectedCheckButton;
      
      private var _hideWingBtn:SelectedCheckButton;
      
      private var _bagItems:DictionaryData;
      
      private var _character:RoomCharacter;
      
      private var _itemList:SimpleTileList;
      
      private var _cells:Array;
      
      private var _bagCells:Array;
      
      private var _nickName:FilterFrameText;
      
      private var _effect:MovieClip;
      
      public function TryonPanelView(param1:TryonSystemController, param2:TryonPanelFrame){super();}
      
      private function initView() : void{}
      
      private function _cellLightComplete(param1:Event) : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __onchange(param1:Event) : void{}
      
      private function __hideWingClickHandler(param1:MouseEvent) : void{}
      
      private function __hideSuitClickHandler(param1:MouseEvent) : void{}
      
      private function __hideHatClickHandler(param1:MouseEvent) : void{}
      
      private function __hideGlassClickHandler(param1:MouseEvent) : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
