package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.event.PetItemEvent;
   
   public class PetsEatView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _eatPetsBtn:SimpleBitmapButton;
      
      private var _eatStoneBtn:SimpleBitmapButton;
      
      private var _weaponBtn:SimpleBitmapButton;
      
      private var _clothesBtn:SimpleBitmapButton;
      
      private var _hatBtn:SimpleBitmapButton;
      
      private var _btnLight:Bitmap;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defenceAddTxt:FilterFrameText;
      
      private var _attackAddTxt:FilterFrameText;
      
      private var _defenceTitleTxt:FilterFrameText;
      
      private var _attackTitleTxt:FilterFrameText;
      
      private var _autoUseBtn:SelectedCheckButton;
      
      private var _bagCell:PetsAdvancedCell;
      
      private var _progress:PetsAdvancedProgressBar;
      
      private var _chooseMc:MovieClip;
      
      private var _expTitle:Bitmap;
      
      private var _lv:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _listPanel:ScrollPanel;
      
      private var _listContainer:Sprite;
      
      private var _petsImgVec:Vector.<PetsEatSmallItem>;
      
      private var _selectedArr:Array;
      
      private var _eatPetsMc:MovieClip;
      
      private var _eatStoneMc:MovieClip;
      
      private var _eatEnd:MovieClip;
      
      private var _petAddExpTxt:FilterFrameText;
      
      private var _petdesTxt:FilterFrameText;
      
      protected var _tip:OneLineTip;
      
      private var _clickDate:Number = 0;
      
      private var clickType:int;
      
      public function PetsEatView(){super();}
      
      public function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __hideTip(param1:MouseEvent) : void{}
      
      protected function __showTip(param1:MouseEvent) : void{}
      
      private function _infoChangeHandler(param1:PetItemEvent) : void{}
      
      private function _mcExpChangeHandler(param1:Event) : void{}
      
      private function _mcEndHandler(param1:Event) : void{}
      
      private function progressSet() : void{}
      
      private function clearPets() : void{}
      
      private function updataPets() : void{}
      
      private function selectedHandler(param1:Event) : void{}
      
      private function stopAllMc() : void{}
      
      public function update() : void{}
      
      private function checkItem() : void{}
      
      private function _eatBtnHandler(param1:MouseEvent) : void{}
      
      private function __alertEatGreatPet(param1:FrameEvent) : void{}
      
      private function checkEatGreatPets() : Boolean{return false;}
      
      private function __alertEatAllPet(param1:FrameEvent) : void{}
      
      private function _selectHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
