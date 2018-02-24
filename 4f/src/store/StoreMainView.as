package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import store.events.ChoosePanelEvnet;
   import store.events.StoreIIEvent;
   import store.newFusion.view.FusionNewMainView;
   import store.view.Compose.StoreIIComposeBG;
   import store.view.exalt.StoreExaltBG;
   import store.view.strength.StoreIIStrengthBG;
   import store.view.transfer.StoreIITransferBG;
   import trainer.view.NewHandContainer;
   
   public class StoreMainView extends Sprite implements Disposeable
   {
      
      public static const STRENGTH:int = 0;
      
      public static const EXALT:int = 1;
      
      public static const COMPOSE:int = 2;
      
      public static const TRANSF:int = 3;
      
      public static const FUSION:int = 4;
      
      public static const GHOST:int = 7;
       
      
      private var _composePanel:StoreIIComposeBG;
      
      private var _strengthPanel:StoreIIStrengthBG;
      
      private var _newFusionView:FusionNewMainView;
      
      private var _transferPanel:StoreIITransferBG;
      
      private var _exaltPanel:StoreExaltBG;
      
      private var _currentPanelIndex:int;
      
      private var _tabSelectedButtonContainer:VBox;
      
      private var _tabSelectedButtonGroup:SelectedButtonGroup;
      
      private var strength_btn:SelectedButton;
      
      private var compose_btn:SelectedButton;
      
      private var fusion_btn:SelectedButton;
      
      private var embed_btn:SelectedButton;
      
      private var transf_Btn:SelectedButton;
      
      private var _exaltBtn:SelectedButton;
      
      private var bg:ScaleFrameImage;
      
      private var _embedBtn_shine:MovieImage;
      
      private var _disEnabledFilters:Array;
      
      public function StoreMainView(){super();}
      
      private function setIndex() : void{}
      
      private function init() : void{}
      
      public function changeToConsortiaState() : void{}
      
      public function changeToBaseState() : void{}
      
      private function initEvent() : void{}
      
      protected function __exaltBtnClick(param1:MouseEvent) : void{}
      
      protected function __groupChangeHandler(param1:Event) : void{}
      
      private function removeEvents() : void{}
      
      private function changeHandler(param1:Event) : void{}
      
      private function __updateStoreBag(param1:BagEvent) : void{}
      
      public function set currentPanelIndex(param1:int) : void{}
      
      public function get currentPanelIndex() : int{return 0;}
      
      public function get currentPanel() : IStoreViewBG{return null;}
      
      public function get StrengthPanel() : StoreIIStrengthBG{return null;}
      
      private function __strengthClick(param1:MouseEvent) : void{}
      
      private function __composeClick(param1:MouseEvent) : void{}
      
      public function skipFromWantStrong(param1:int) : void{}
      
      private function __fusionClick(param1:MouseEvent) : void{}
      
      protected function __onGetPetsFormInfo(param1:PkgEvent) : void{}
      
      private function __lianhuaClick(param1:MouseEvent) : void{}
      
      private function __transferClick(param1:MouseEvent) : void{}
      
      private function changeToTab(param1:int, param2:Boolean = true) : void{}
      
      private function judgePointComposeArrow() : void{}
      
      private function judgePointTransfArrow() : void{}
      
      private function __openAssetManager(param1:MouseEvent) : void{}
      
      private function sortBtn() : void{}
      
      public function shineEmbedBtn() : void{}
      
      private function embedInfoChangeHandler(param1:StoreIIEvent) : void{}
      
      public function refreshCurrentPanel() : void{}
      
      public function deleteSomeDataTemp() : void{}
      
      public function dispose() : void{}
   }
}
