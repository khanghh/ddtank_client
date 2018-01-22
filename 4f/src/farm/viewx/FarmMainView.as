package farm.viewx
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.player.FarmPlayer;
   import farm.player.vo.PlayerVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.viewx.helper.FarmHelperView;
   import farm.viewx.poultry.FarmPoultry;
   import farm.viewx.poultry.FarmTree;
   import farm.viewx.shop.FarmShopView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetFarmGuildeEvent;
   import road7th.comm.PackageIn;
   import toyMachine.ToyMachineManager;
   import trainer.view.NewHandContainer;
   import treasure.controller.TreasureManager;
   
   public class FarmMainView extends Sprite implements Disposeable
   {
       
      
      private var _bgSprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _water:MovieClip;
      
      private var _water1:MovieClip;
      
      private var _waterwheel:MovieClip;
      
      private var _float:MovieClip;
      
      private var _pastureHouseBtn:MovieClip;
      
      private var _friendListView:FarmFriendListView;
      
      private var _farmHelperBtn:BaseButton;
      
      private var _farmShopBtn:BaseButton;
      
      private var _doSeedBtn:BaseButton;
      
      private var _doMatureBtn:BaseButton;
      
      private var _goHomeBtn:BaseButton;
      
      private var _goTreasureBtn:SimpleButton;
      
      private var _arrangeBtn:BaseButton;
      
      private var _buyExpBtn:SimpleBitmapButton;
      
      private var _farmShovelBtn:FarmKillCropCell;
      
      private var _fireflyMC1:MovieClip;
      
      private var _fireflyMC2:MovieClip;
      
      private var _fireflyMC3:MovieClip;
      
      private var _startHelperMC:MovieClip;
      
      private var _fieldView:FarmFieldsView;
      
      private var _hostNameBmp:Bitmap;
      
      private var _farmName:FilterFrameText;
      
      private var _newPetPao:Bitmap;
      
      private var _newdragon:Bitmap;
      
      private var _newPetText:FilterFrameText;
      
      private var _buyExpText:FilterFrameText;
      
      private var _buyExpEffect:MovieImage;
      
      private var _selfPlayer:FarmPlayer;
      
      private var _friendPlayer:FarmPlayer;
      
      private var _currentLoadingPlayer:FarmPlayer;
      
      private var _lastClick:Number = 0;
      
      private var _clickInterval:Number = 200;
      
      private var _mouseMovie:MovieClip;
      
      private var _sceneScene:SceneScene;
      
      private var _meshLayer:Sprite;
      
      private var _needMoney:int;
      
      private var _farmTree:FarmTree;
      
      private var _farmPoultry:FarmPoultry;
      
      private var _farmBuyExpFrame:FarmBuyExpFrame;
      
      private var _selectedView:ManureOrSeedSelectedView;
      
      private var _farmHelper:FarmHelperView;
      
      private var _farmShop:FarmShopView;
      
      private var _currentFarmHelperFrame:int;
      
      public function FarmMainView(){super();}
      
      private function init() : void{}
      
      protected function __onComplete(param1:Event) : void{}
      
      protected function __onGetPoultryLevel(param1:PkgEvent) : void{}
      
      public function addSelfPlayer() : void{}
      
      private function addPlayerCallBack(param1:FarmPlayer, param2:Boolean, param3:int) : void{}
      
      protected function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __onPlayerClick(param1:MouseEvent) : void{}
      
      protected function __updateFrame(param1:Event) : void{}
      
      private function dargonPetShow() : void{}
      
      private function set newPetShowVisble(param1:Boolean) : void{}
      
      private function checkHelper() : void{}
      
      private function setVisibleByAuto(param1:Boolean = true) : void{}
      
      private function __setVisible(param1:FarmEvent) : void{}
      
      private function __setVisibleFal(param1:FarmEvent) : void{}
      
      private function petFarmGuilde() : void{}
      
      private function petFarmGuildeClear() : void{}
      
      protected function initToolBtn() : void{}
      
      private function initEvent() : void{}
      
      private function __goTreasureBtn(param1:MouseEvent) : void{}
      
      private function __arrangeBackHandler(param1:FarmEvent) : void{}
      
      private function addFieldBlockEvent() : void{}
      
      protected function __onFieldBlockClick(param1:FarmEvent) : void{}
      
      protected function __updateNum(param1:FarmEvent) : void{}
      
      protected function __priectListLoadComplete(param1:Event) : void{}
      
      protected function __onBuyExpClick(param1:MouseEvent) : void{}
      
      protected function __BuyExpFrameResponse(param1:FrameEvent) : void{}
      
      private function __doSeedOver(param1:MouseEvent) : void{}
      
      private function __doSeedOut(param1:MouseEvent) : void{}
      
      private function __doMatureOver(param1:MouseEvent) : void{}
      
      private function __doMatureOut(param1:MouseEvent) : void{}
      
      private function __farmShopOver(param1:MouseEvent) : void{}
      
      private function __farmShopOut(param1:MouseEvent) : void{}
      
      private function __goHomeOver(param1:MouseEvent) : void{}
      
      private function __goHomeOut(param1:MouseEvent) : void{}
      
      private function __arrangeOver(param1:MouseEvent) : void{}
      
      private function __arrangeOut(param1:MouseEvent) : void{}
      
      private function __arrangeHandler(param1:MouseEvent) : void{}
      
      private function __updatePetFarmGuilde(param1:UpdatePetFarmGuildeEvent) : void{}
      
      private function __killcrop_iconShow(param1:SelectComposeItemEvent) : void{}
      
      protected function __pastureOut(param1:MouseEvent) : void{}
      
      protected function __pastureOver(param1:MouseEvent) : void{}
      
      private function setFarmPlayerInfo() : void{}
      
      protected function __enterFram(param1:FarmEvent) : void{}
      
      private function __goHomeHandler(param1:MouseEvent) : void{}
      
      private function __onSelectedBtnClick(param1:MouseEvent) : void{}
      
      private function __onFastForwardSelectedBtnClick(param1:MouseEvent) : void{}
      
      protected function __onResponse(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function ripeNum() : int{return 0;}
      
      private function __showHelper(param1:MouseEvent) : void{}
      
      private function __closeHelperView(param1:FrameEvent) : void{}
      
      private function __showShop(param1:MouseEvent) : void{}
      
      private function __closeFarmShop(param1:FrameEvent) : void{}
      
      private function __pastureHouse(param1:MouseEvent) : void{}
      
      private function __farmHelperOver(param1:MouseEvent) : void{}
      
      private function __farmHelperOut(param1:MouseEvent) : void{}
      
      private function __farmHelperDown(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function removeFieldBolckEvent() : void{}
      
      private function deleteSelfPlayer() : void{}
      
      public function dispose() : void{}
   }
}
