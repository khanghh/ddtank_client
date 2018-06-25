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
      
      public function TryonPanelView(contro:TryonSystemController, frame:TryonPanelFrame)
      {
         super();
         _controller = contro;
         _model = _controller.getModelByView(frame);
         _cells = [];
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var sp:* = null;
         var cell:* = null;
         var _itemShine:* = null;
         var animation:* = null;
         var i:int = 0;
         var cell1:* = null;
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
         var animationControl:AnimationControl = new AnimationControl();
         animationControl.addEventListener("complete",_cellLightComplete);
         var _loc10_:int = 0;
         var _loc9_:* = _model.items;
         for each(var item in _model.items)
         {
            sp = new Sprite();
            sp.graphics.beginFill(16777215,0);
            sp.graphics.drawRect(0,0,43,43);
            sp.graphics.endFill();
            cell = new TryonCell(sp);
            cell.info = item;
            cell.addEventListener("click",__onClick);
            cell.buttonMode = true;
            _itemList.addChild(cell);
            _cells.push(cell);
            if(item.CategoryID == 3)
            {
               _hideHatBtn.selected = true;
               _model.playerInfo.setHatHide(_hideHatBtn.selected);
            }
            else
            {
               _hideHatBtn.selected = _model.playerInfo.getHatHide();
            }
            _itemShine = ComponentFactory.Instance.creatComponentByStylename("asset.core.itemBigShinelight");
            _itemShine.movie.play();
            cell.addChildAt(_itemShine,1);
            animation = new GlowFilterAnimation();
            animation.start(_itemShine,false,16763955,0,0);
            animation.addMovie(0,0,19,0);
            animationControl.addMovies(animation);
         }
         addChild(_itemList);
         _bagItems = _model.bagItems;
         _bagCells = [];
         for(i = 0; i < 8; )
         {
            cell1 = new PersonalInfoCell(i,_bagItems[CELL_PLACE[i]] as InventoryItemInfo,true);
            _bagCells.push(cell1);
            i++;
         }
         _nickName = ComponentFactory.Instance.creatComponentByStylename("tryonNickNameText");
         addChild(_nickName);
         _nickName.text = PlayerManager.Instance.Self.NickName;
         animationControl.startMovie();
      }
      
      private function _cellLightComplete(e:Event) : void
      {
         var len:int = 0;
         var i:int = 0;
         var movie:* = null;
         e.currentTarget.removeEventListener("complete",_cellLightComplete);
         if(_cells)
         {
            len = _cells.length;
            for(i = 0; i < len; )
            {
               movie = _cells[i].removeChildAt(1);
               movie.dispose();
               i++;
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
      
      private function __onchange(event:Event) : void
      {
         var index:int = 0;
         for(index = 0; index < 8; )
         {
            _bagCells[index].info = _bagItems[CELL_PLACE[index]] as InventoryItemInfo;
            index++;
         }
      }
      
      private function __hideWingClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.wingHide = _hideWingBtn.selected;
      }
      
      private function __hideSuitClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.setSuiteHide(_hideSuitBtn.selected);
      }
      
      private function __hideHatClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.setHatHide(_hideHatBtn.selected);
      }
      
      private function __hideGlassClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.playerInfo.setGlassHide(_hideGlassBtn.selected);
      }
      
      private function __onClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var cell in _cells)
         {
            cell.selected = false;
         }
         TryonCell(event.currentTarget).selected = true;
         _model.selectedItem = TryonCell(event.currentTarget).info as InventoryItemInfo;
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
         for each(var cell in _cells)
         {
            cell.removeEventListener("click",__onClick);
            cell.dispose();
         }
         _cells = null;
         var _loc6_:int = 0;
         var _loc5_:* = _bagCells;
         for each(var cell1 in _bagCells)
         {
            cell1.dispose();
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
