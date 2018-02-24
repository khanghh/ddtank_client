package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import shop.view.NewShopBugleView;
   import shop.view.NewShopMultiBugleView;
   import shop.view.SetsShopView;
   import texpSystem.TexpEvent;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   import trainer.view.NewHandContainer;
   
   public class TexpView extends Sprite implements Disposeable
   {
       
      
      private var _bg1:MovieImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _bg3:Scale9CornerImage;
      
      private var _bg4:Bitmap;
      
      private var _txtBg1:Bitmap;
      
      private var _bg5:MutipleImage;
      
      private var _texpCell:TexpCell;
      
      private var _lblTexpName:FilterFrameText;
      
      private var _lblCurrLv:FilterFrameText;
      
      private var _limitCount:FilterFrameText;
      
      private var _lblCurrEffect:FilterFrameText;
      
      private var _lblUpEffect:FilterFrameText;
      
      private var _txtCurrEffect:FilterFrameText;
      
      private var _txtUpEffect:FilterFrameText;
      
      private var _buyText:FilterFrameText;
      
      private var _buyText1:FilterFrameText;
      
      private var _sbtnGroup:SelectedButtonGroup;
      
      private var _sbtnAtt:SelectedButton;
      
      private var _sbtnHp:SelectedButton;
      
      private var _sbtnLuk:SelectedButton;
      
      private var _sbtnDef:SelectedButton;
      
      private var _sbtnSpd:SelectedButton;
      
      private var _sbtnMagicAtk:SelectedButton;
      
      private var _sbtnMagicDef:SelectedButton;
      
      private var _attLevel:FilterFrameText;
      
      private var _hpLevel:FilterFrameText;
      
      private var _lukLevel:FilterFrameText;
      
      private var _defLevel:FilterFrameText;
      
      private var _spdLevel:FilterFrameText;
      
      private var _magicAtkLevel:FilterFrameText;
      
      private var _magicDefLevel:FilterFrameText;
      
      private var _infoArray:Vector.<FilterFrameText>;
      
      private var _background1:Bitmap;
      
      private var _progressLevel:TexpLevelPro;
      
      private var _btnTexp:SimpleBitmapButton;
      
      private var _btnHelp:BaseButton;
      
      private var _btnBuy:TexpBuyButton;
      
      private var _textBack:Bitmap;
      
      private var _allInjectSCB:SelectedCheckButton;
      
      private var isActive:Boolean = false;
      
      public function TexpView(){super();}
      
      private function texpGuide() : void{}
      
      private function initView() : void{}
      
      private function setLimitTxt() : void{}
      
      private function setInfoLevel() : void{}
      
      private function initEvent() : void{}
      
      private function __isInjectSelectClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __allInjectSCBClick(param1:MouseEvent) : void{}
      
      private function playerPropertyEventHander(param1:PlayerPropertyEvent) : void{}
      
      private function __buyBuff(param1:MouseEvent) : void{}
      
      public function clearInfo() : void{}
      
      public function startShine() : void{}
      
      public function stopShine() : void{}
      
      private function __updateStoreBag(param1:BagEvent) : void{}
      
      private function __onChange(param1:TexpEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function __texpTypeClick(param1:MouseEvent) : void{}
      
      private function __texpClick(param1:MouseEvent) : void{}
      
      private function __buyClick(param1:MouseEvent) : void{}
      
      private function setTexpInfo(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
