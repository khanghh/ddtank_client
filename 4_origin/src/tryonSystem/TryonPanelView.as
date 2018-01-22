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
      
      public function TryonPanelView(param1:TryonSystemController, param2:TryonPanelFrame)
      {
         super();
         _controller = param1;
         _model = _controller.getModelByView(param2);
         _cells = [];
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.tryOnBigBg");
         addChild(_bg);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("core.tryOnSmallBg");
         addChild(_bg1);
         _tryTxt = ComponentFactory.Instance.creatComponentByStylename("asset.tryOnTxt");
         addChild(_tryTxt);
         _tryTxt.text = LanguageMgr.GetTranslation("ddt.quest.tryon.tryonTxt");
         _hideTxt = ComponentFactory.Instance.creatComponentByStylename("asset.core.hideTxt");
         addChild(_hideTxt);
         _hideTxt.text = LanguageMgr.GetTranslation("ddt.quest.tryon.hide");
         _hideGlassBtn = ComponentFactory.Instance.creatComponentByStylename("tryon.HideHatCheckBox");
         addChild(_hideGlassBtn);
         _hideHatBtn = ComponentFactory.Instance.creatComponentByStylename("tryon.HideGlassCheckBox");
         addChild(_hideHatBtn);
         _hideSuitBtn = ComponentFactory.Instance.creatComponentByStylename("tryon.HideSuitCheckBox");
         addChild(_hideSuitBtn);
         _hideWingBtn = ComponentFactory.Instance.creatComponentByStylename("tryon.HideWingCheckBox");
         addChild(_hideWingBtn);
         _hideHatBtn.text = LanguageMgr.GetTranslation("shop.ShopIITryDressView.hideHat");
         _hideGlassBtn.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.glass");
         _hideSuitBtn.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.suit");
         _hideWingBtn.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.wing");
         _hideGlassBtn.selected = _model.playerInfo.getGlassHide();
         _hideSuitBtn.selected = _model.playerInfo.getSuitesHide();
         _hideWingBtn.selected = _model.playerInfo.wingHide;
         _character = CharactoryFactory.createCharacter(_model.playerInfo,"room") as RoomCharacter;
         PositionUtils.setPos(_character,"quest.tryon.character.pos");
         addChild(_character);
         _character.show(false,-1);
         _effect = ComponentFactory.Instance.creat("asset.core.tryonEffect");
         PositionUtils.setPos(_effect,"tryonSystem.TryonPanelView.effectPos");
         _effect.stop();
         addChild(_effect);
         _itemList = new SimpleTileList(2);
         _itemList.vSpace = 60;
         _itemList.hSpace = 50;
         PositionUtils.setPos(_itemList,"quest.tryon.simplelistPos");
         var _loc1_:AnimationControl = new AnimationControl();
         _loc1_.addEventListener("complete",_cellLightComplete);
         var _loc10_:int = 0;
         var _loc9_:* = _model.items;
         for each(var _loc5_ in _model.items)
         {
            _loc3_ = new Sprite();
            _loc3_.graphics.beginFill(16777215,0);
            _loc3_.graphics.drawRect(0,0,43,43);
            _loc3_.graphics.endFill();
            _loc4_ = new TryonCell(_loc3_);
            _loc4_.info = _loc5_;
            _loc4_.addEventListener("click",__onClick);
            _loc4_.buttonMode = true;
            _itemList.addChild(_loc4_);
            _cells.push(_loc4_);
            if(_loc5_.CategoryID == 3)
            {
               _hideHatBtn.selected = true;
               _model.playerInfo.setHatHide(_hideHatBtn.selected);
            }
            else
            {
               _hideHatBtn.selected = _model.playerInfo.getHatHide();
            }
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("asset.core.itemBigShinelight");
            _loc8_.movie.play();
            _loc4_.addChildAt(_loc8_,1);
            _loc2_ = new GlowFilterAnimation();
            _loc2_.start(_loc8_,false,16763955,0,0);
            _loc2_.addMovie(0,0,19,0);
            _loc1_.addMovies(_loc2_);
         }
         addChild(_itemList);
         _bagItems = _model.bagItems;
         _bagCells = [];
         _loc7_ = 0;
         while(_loc7_ < 8)
         {
            _loc6_ = new PersonalInfoCell(_loc7_,_bagItems[CELL_PLACE[_loc7_]] as InventoryItemInfo,true);
            _bagCells.push(_loc6_);
            _loc7_++;
         }
         _nickName = ComponentFactory.Instance.creatComponentByStylename("tryonNickNameText");
         addChild(_nickName);
         _nickName.text = PlayerManager.Instance.Self.NickName;
         _loc1_.startMovie();
      }
      
      private function _cellLightComplete(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         param1.currentTarget.removeEventListener("complete",_cellLightComplete);
         if(_cells)
         {
            _loc3_ = _cells.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = _cells[_loc4_].removeChildAt(1);
               _loc2_.dispose();
               _loc4_++;
            }
         }
      }
      
      private function initEvents() : void
      {
         _hideGlassBtn.addEventListener("click",__hideGlassClickHandler);
         _hideHatBtn.addEventListener("click",__hideHatClickHandler);
         _hideSuitBtn.addEventListener("click",__hideSuitClickHandler);
         _hideWingBtn.addEventListener("click",__hideWingClickHandler);
         _model.addEventListener("change",__onchange);
      }
      
      private function removeEvents() : void
      {
         _hideGlassBtn.removeEventListener("click",__hideGlassClickHandler);
         _hideHatBtn.removeEventListener("click",__hideHatClickHandler);
         _hideSuitBtn.removeEventListener("click",__hideSuitClickHandler);
         _hideWingBtn.removeEventListener("click",__hideWingClickHandler);
         _model.removeEventListener("change",__onchange);
      }
      
      private function __onchange(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _bagCells[_loc2_].info = _bagItems[CELL_PLACE[_loc2_]] as InventoryItemInfo;
            _loc2_++;
         }
      }
      
      private function __hideWingClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.wingHide = _hideWingBtn.selected;
      }
      
      private function __hideSuitClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.setSuiteHide(_hideSuitBtn.selected);
      }
      
      private function __hideHatClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.setHatHide(_hideHatBtn.selected);
      }
      
      private function __hideGlassClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.setGlassHide(_hideGlassBtn.selected);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            _loc2_.selected = false;
         }
         TryonCell(param1.currentTarget).selected = true;
         _model.selectedItem = TryonCell(param1.currentTarget).info as InventoryItemInfo;
         if(_effect)
         {
            _effect.play();
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("click",__onClick);
            _loc1_.dispose();
         }
         _cells = null;
         var _loc6_:int = 0;
         var _loc5_:* = _bagCells;
         for each(var _loc2_ in _bagCells)
         {
            _loc2_.dispose();
         }
         _bagCells = null;
         if(_effect)
         {
            if(_effect.parent)
            {
               _effect.parent.removeChild(_effect);
            }
            _effect = null;
         }
         _bg1.dispose();
         _bg1 = null;
         _bg.dispose();
         _bg = null;
         ObjectUtils.disposeObject(_tryTxt);
         _tryTxt = null;
         ObjectUtils.disposeObject(_hideTxt);
         _hideTxt = null;
         ObjectUtils.disposeObject(_hideGlassBtn);
         _hideGlassBtn = null;
         ObjectUtils.disposeObject(_hideSuitBtn);
         _hideSuitBtn = null;
         ObjectUtils.disposeObject(_hideWingBtn);
         _hideWingBtn = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         _character.dispose();
         _character = null;
         _itemList.dispose();
         _itemList = null;
         _bagItems = null;
         _model = null;
         _controller = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
